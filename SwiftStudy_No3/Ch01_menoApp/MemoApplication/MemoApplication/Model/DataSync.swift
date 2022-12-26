//
//  DataSync.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/08/31.
//

import Foundation
import CoreData
import Alamofire

class DataSync {
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func downloadBackupData() {
        let ud = UserDefaults.standard
        guard ud.value(forKey: "firstLogin") == nil else {return}
        let tk = TokenUtils()
        let header = tk.getAutohrizationHeader()
        
        let get = AF.request(UserInfoPrivate().searchURL, method: .post, encoding: JSONEncoding.default, headers: header)
        
        get.responseJSON { res in
            do {
                guard let jsonObject = try? res.result.get() as? NSDictionary else {return}
                guard let list       = jsonObject["list"] as? NSArray else {return}
                
                for item in list{
                    guard let record = item as? NSDictionary else {return}
                    guard let obj    = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as? MemoMO else {return}
                    
                    obj.title    = (record["title"] as? String ?? "")
                    obj.contents = (record["contents"] as? String ?? "")
                    obj.regdate  = self.stringToDate(record["create_date"] as? String ?? "")
                    obj.sync     = true
                    
                    if let imgPath = record["image_path"] as? String {
                        guard let url = URL(string: imgPath) else {return}
                        do{
                            obj.image = try? Data(contentsOf: url)
                        }catch let e as NSError{
                            NSLog("imgPath can't convert err : \(e.localizedDescription) ")
                        }
                        
                    }
                    do{
                        try self.context.save()
                    } catch let e as NSError{
                        self.context.rollback()
                        NSLog("An error has occured : %s", e.localizedDescription)
                    }
                    
                }
            }
            catch let e as NSError{
                NSLog("err : \(e.localizedDescription)")
            }
        }
        ud.setValue(true, forKey: "firstLogin")
    }
    //Memo엔터티에 저장된 모든 데이터 중 동기화되지 않은 것을 찾아 서버에 업로드
    func uploadData(_ indicatorView: UIActivityIndicatorView? = nil) {
        // 요청객체를 사용자가 수정한 MemoMO 데이터의 최근 수정일, 생성일 Date( regdate)로 정렬해 우선 순위를 부여하고 sorting한다.
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        //헉;; sync가 false인 것은 아직 업로드가 되지않음을 뜻하고 이것만 데이터를 찾으면 된다.. ㅎㄷㄷ
        fetchRequest.predicate = NSPredicate(format: "sync == false")
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
            
            for record in resultset{
                indicatorView?.startAnimating()
                NSLog("upload data==\(record.title!)")
                
                self.uploadDatum(record){
                    if record === resultset.last{
                        indicatorView?.stopAnimating()
                    }
                }
            }
        }catch let e as NSError{
            NSLog("An error occured : \(e.localizedDescription)")
        }
    }
    
    // 인자값으로 입력된 개별 MemoMO 객체를 서버에 업로드
    func uploadDatum(_ item: MemoMO, complete: (()->Void)? = nil){
        
        // 헤더 설정
        let tk = TokenUtils()
        guard let header = tk.getAutohrizationHeader() else{
            NSLog("로그인 상태 x [\(item.title!)] 업로드 불가.")
            return
        }
        //전송 값 정보
        var param : Parameters = [
            "title" : item.title!,
            "contents" : item.contents!,
            "craete_date" : self.dateToString(item.regdate!)
        ]
        if let imageData = item.image as Data?{
            param["image"] = imageData.base64EncodedString()
        }
        //전송
        let upload = AF.request(UserInfoPrivate().saveURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        
        //응답결과 처리
        upload.responseJSON { res in
            guard let jsonObj = try? res.result.get() as? NSDictionary else{
                NSLog("잘못된 응답입니다.")
                return
            }
            guard let resCode = jsonObj["result_code"] as? Int else {NSLog("result_code can't find in parsed jsonobj");return}
            if resCode == 0{
                NSLog("[\(item.title!)]가 등록됬습니다.")
                do{
                    //아이템 등록되면 sync도 true처리를 한다.
                    item.sync = true
                    try self.context.save()
                } catch let e as NSError{
                    //영구저장소에 저장안되면 다시 롤백
                    self.context.rollback()
                    NSLog("An err has occured : %s",e.localizedDescription)
                }
            }else{
                NSLog(jsonObj["error_msg"] as! String)
            }
            complete?()
        }
    }
}

//MARK: - DataSync 유틸 메소드
extension DataSync{
    func stringToDate(_ value: String)->Date{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    func dateToString(_ value: Date)->String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
}
