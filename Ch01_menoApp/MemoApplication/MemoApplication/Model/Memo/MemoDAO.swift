//
//  MemoDAO.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/08/26.
//
import UIKit
import CoreData

class MemoDAO
{
    lazy var context: NSManagedObjectContext =
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func fetch()->[MemoData]
    {
        var memoList = [MemoData]()
        //MemoMO 요청 객체
        //fetchrequest()두개가 있어서 타입 어노데이션을 명시해줘야함.
        let fetchRequest : NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        //MemoMO에서 regdate에 따라(최신 글) sort
        let regDateDesc  = NSSortDescriptor(key:"regdate",ascending: false)
        fetchRequest.sortDescriptors = [regDateDesc]
        
        do
        {
            let resultest = try self.context.fetch(fetchRequest)
            for rec in resultest
            {
                let data      = MemoData()
                data.title    = rec.title
                data.contents = rec.contents
                guard let _regdate = rec.regdate as? Date else {NSLog("MemoDAO's MemoMO regdate nil");return [MemoData]()}
                data.regdate  = _regdate
                data.objectID = rec.objectID
                
                if let image = rec.image as Data?
                {
                    data.image = UIImage(data: image)
                }
                memoList.append(data)
            }
        }
        catch let err as NSError
        {
            NSLog("An error has occured : %s", err.localizedDescription)
        }
        return memoList
    }
    func insert(_ data: MemoData)
    {
        guard let obj = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as? MemoMO else {NSLog("MemoDAO insert(_:) entity nil");return}
        obj.title     = data.title
        obj.contents  = data.contents
        guard let _regdate = data.regdate else {NSLog("MemoDAO data.regdate is nil");return}
        obj.regdate   = _regdate
        if let image  = data.image, let _pngData = image.pngData()
        {
            obj.image = _pngData
        }
        
        do
        {
            //컨텍스트를 통해 영구 저장소에 반영
            try self.context.save()
        }
        catch let e as NSError
        {
            NSLog("An error has occured : %s", e.localizedDescription)
        }
    }
    func delete(_ objectID : NSManagedObject) -> Bool
    {
        return false
    }
    
}
