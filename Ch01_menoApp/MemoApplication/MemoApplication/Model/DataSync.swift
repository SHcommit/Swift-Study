//
//  DataSync.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/08/31.
//

import Foundation
import CoreData
import Alamofire

class DataSync{
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func downloadBackupData(){
        let ud = UserDefaults.standard
        guard ud.value(forKey: "firstLogin") == nil else {return}
        let tk = TokenUtils()
        let header = tk.getAutohrizationHeader()
        
        let url = "http://swiftapi.rubypaper.co.kr:2029/memo/search"
        let get = AF.request(url, method: .post, encoding: JSONEncoding.default, headers: header)
        
        get.responseJSON{ res in
            do
            {
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
