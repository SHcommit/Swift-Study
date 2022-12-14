//
//  DataSync.swift
//  MemoApplication
//
//  Created by μμΉν on 2022/08/31.
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
    //Memoμν°ν°μ μ μ₯λ λͺ¨λ  λ°μ΄ν° μ€ λκΈ°νλμ§ μμ κ²μ μ°Ύμ μλ²μ μλ‘λ
    func uploadData(_ indicatorView: UIActivityIndicatorView? = nil) {
        // μμ²­κ°μ²΄λ₯Ό μ¬μ©μκ° μμ ν MemoMO λ°μ΄ν°μ μ΅κ·Ό μμ μΌ, μμ±μΌ Date( regdate)λ‘ μ λ ¬ν΄ μ°μ  μμλ₯Ό λΆμ¬νκ³  sortingνλ€.
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        //ν;; syncκ° falseμΈ κ²μ μμ§ μλ‘λκ° λμ§μμμ λ»νκ³  μ΄κ²λ§ λ°μ΄ν°λ₯Ό μ°ΎμΌλ©΄ λλ€.. γγ·γ·
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
    
    // μΈμκ°μΌλ‘ μλ ₯λ κ°λ³ MemoMO κ°μ²΄λ₯Ό μλ²μ μλ‘λ
    func uploadDatum(_ item: MemoMO, complete: (()->Void)? = nil){
        
        // ν€λ μ€μ 
        let tk = TokenUtils()
        guard let header = tk.getAutohrizationHeader() else{
            NSLog("λ‘κ·ΈμΈ μν x [\(item.title!)] μλ‘λ λΆκ°.")
            return
        }
        //μ μ‘ κ° μ λ³΄
        var param : Parameters = [
            "title" : item.title!,
            "contents" : item.contents!,
            "craete_date" : self.dateToString(item.regdate!)
        ]
        if let imageData = item.image as Data?{
            param["image"] = imageData.base64EncodedString()
        }
        //μ μ‘
        let upload = AF.request(UserInfoPrivate().saveURL, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header)
        
        //μλ΅κ²°κ³Ό μ²λ¦¬
        upload.responseJSON { res in
            guard let jsonObj = try? res.result.get() as? NSDictionary else{
                NSLog("μλͺ»λ μλ΅μλλ€.")
                return
            }
            guard let resCode = jsonObj["result_code"] as? Int else {NSLog("result_code can't find in parsed jsonobj");return}
            if resCode == 0{
                NSLog("[\(item.title!)]κ° λ±λ‘λ¬μ΅λλ€.")
                do{
                    //μμ΄ν λ±λ‘λλ©΄ syncλ trueμ²λ¦¬λ₯Ό νλ€.
                    item.sync = true
                    try self.context.save()
                } catch let e as NSError{
                    //μκ΅¬μ μ₯μμ μ μ₯μλλ©΄ λ€μ λ‘€λ°±
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

//MARK: - DataSync μ νΈ λ©μλ
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
