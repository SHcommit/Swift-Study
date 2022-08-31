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
    
    func fetch(keyword text : String? = nil)->[MemoData]
    {
        var memoList = [MemoData]()
        //MemoMO 요청 객체
        //fetchrequest()두개가 있어서 타입 어노데이션을 명시해줘야함.
        let fetchRequest : NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        //MemoMO에서 regdate에 따라(최신 글) sort
        let regDateDesc  = NSSortDescriptor(key:"regdate",ascending: false)
        fetchRequest.sortDescriptors = [regDateDesc]
        
        //NSPredicate검색 조건 추가
        if let t = text, t.isEmpty == false
        {
            fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)
        }
        
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
            //로그인 되어있을 경우 서버에 업로드 기기
            let tk = TokenUtils()
            if tk.getAutohrizationHeader() != nil{
                // fore그라운드 작업 방해 x 하면서 백그라운드에서 실행할수있게해줌.
                DispatchQueue.global(qos: .background).async {
                    let sync = DataSync()
                    sync.uploadDatum(obj)
                }
            }
        }
        catch let e as NSError
        {
            NSLog("An error has occured : %s", e.localizedDescription)
        }
    }
    func delete(_ objectID : NSManagedObjectID) -> Bool
    {
        let obj = self.context.object(with: objectID)
        self.context.delete(obj)
        
        do
        {
            try self.context.save()
            return true
        }
        catch let e as NSError
        {
            NSLog("An error has occured : %s",e.localizedDescription)
            return false
        }
    }
    
}
