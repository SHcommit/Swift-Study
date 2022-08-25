//
//  ListVC.swift
//  CoreDataStudy
//
//  Created by 양승현 on 2022/08/25.
//

import UIKit
import CoreData
/*
    Date : 22.08.25
    한가지 신기한 것은
    NSManagedObject 타입이 **클래스**라 그런가
    list에 특정 index값을 꺼낸 후 let temp 프로퍼티로 치환되서 그 temp프로퍼티의 값을 변경하면 list의 값이 변경된다는 것.
    영구저장소에는 따로 save()를 해야한다. else rollback()
    ---
    Date : 22.08.25
    또 다른 고민점은 원래의 최신글은 위에서 볼 수있는데 지금 상태는 아래에 추가된다.
    queue를 사용하며 간단하게 해결할 수 있다고 생각했지만 ?? 성공이다. insert(_:at:)
    근데 이럴 경우 문제가 초기에 이미 저장해두었던 regDate와 새로 저장된 regDate 순서가 바뀔수있다는 문제가있다.
    그래서 NSSortDescriptor 객체를 이용해 날자를 최신 순으로 sort해야한다.
 */
class ListVC : UITableViewController
{
    
    /*
        fetch를 통해 NSManagedObject를 받는다
        ** NSManagedObject란?
        ***** 코어 데이터 모델 object를 기본으로함.
        ***** 관리 객체
        ***** entity 정보 담겨있음
     */
    lazy var list: [NSManagedObject] =
    {
        return self.fetch()
    }()
    
    /*
        return entity
     */
    func fetch() -> [NSManagedObject]
    {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트
        let contextDAO      = appDelegate.persistentContainer.viewContext
        
        
        
        //요청 객체
        //코어 데이터에서 레코드를 읽어오는 과정을 페치라고함(데이터 가져오기)
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        let res          = try! contextDAO.fetch(fetchRequest)
        return res
    }
    override func viewDidLoad()
    {
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    //MARK: - tableView delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let record   = self.list[indexPath.row]
        let title    = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        let cell     = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text       = title
        cell.detailTextLabel?.text = contents
        cell.accessoryType         = .detailDisclosureButton
        return cell
    }
    override func tableView(_ tv: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    {
        let obj = self.list[indexPath.row]
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as? LogVC else {return}
        uvc.board = (obj as? BoardMO)
        self.show(uvc,sender:self)
    }
    override func tableView(_ tv: UITableView, editingStyleForRowAt indexPath : IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    override func tableView(_ tv : UITableView, commit editingStyle : UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let obj = self.list[indexPath.row]
        if self.delete(object:obj)
        {
            self.list.remove(at:indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func tableView(_ tv: UITableView, didSelectRowAt indexPath : IndexPath)
    {
        /*
         기존 list에 특정 idx 객체를 꺼내서 현 상태를 보여준 후 edit함수를 통해 특정 idx객체 값에 새로운 값을 setValue한다.
         */
        let obj       = self.list[indexPath.row]
        let title     = obj.value(forKey: "title") as? String
        let contents  = obj.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        alert.addTextField() { $0.text = title }
        alert.addTextField() { $0.text = contents}
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default)
                        {(_) in
            guard let title = alert.textFields?.first?.text , let contents = alert.textFields?.last?.text else
            {
                return
            }
            if self.edit(object: obj, title: title, contents: contents)
            {
                //self.tableView.reloadData() -> 단순히 수정된 것은 제자리에 indexPath.row행에 머물러있음.
                
                /*
                    와우;; 수정된 글을 위로 올리는 방법이다.
                    차마 생각하지 못했는데,,
                 */
                guard let cell = tv.cellForRow(at: indexPath) else { return }
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = contents
                
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath)
            }
        })
        present(alert, animated: true)
    }
    
    //MARK: - 컨텍스트를 이용한 레코드 save, delete.
    func save(title: String, contents: String) -> Bool
    {
        /*
             1. 앱 델리게이트
             2. 관리 객체 컨텍스트
                ** 모든 관리 객체(NSManagedObject)는 컨텍스트에 담겨 관리된다.
                ** 메모리!! (코어 데이터가 다루는 모든 데이터는 메모리에 로드 된 상태로 처리됨.)
             3. 관리객체 생성 & value부여
             4. 영구 저장소에 코밋되고 나면 list 프로퍼티에 추가
         */
        let appDelegate   = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return false }
        let object        = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        //Date: 22.08.25 save Log
        // Log MO 관리 객체 생성
        guard let logObj = NSEntityDescription.insertNewObject(forEntityName:"Log",into: context) as? LogMO else {return false}
        //값 대입
        logObj.regdate   = Date()
        logObj.type      = LogType.create.rawValue
        
        //게시글 객체의 logs속성에 로그 추가 ( 릴레이션 처리 )
        guard let _obj = object as? BoardMO else {return false}
        _obj.addToLogs(logObj)
        
        do
        {
            //컨텍스트 변경 사항 영구 저장소와 동기화
            //여기서 영구저장소에도 동기화하고 관리객체 컨텍스트에도 동기화를 하네
            try context.save()
            self.list.insert(object, at: 0)
            return true
        }
        catch
        {
            context.rollback()
            return false
        }
    }
    func delete(object : NSManagedObject) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return false
        }
        //관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 컨텍스트를 통해 삭제 후 try문으로 커밋으로 영구 저장소에 커밋
        context.delete(object)
        
        do
        {
            //저장이 아니라 영구 저장소와 동기화!!
            try context.save()
            return true
        }
        catch
        {
            context.rollback()
            return false
        }
    }
    func edit(object: NSManagedObject, title: String, contents: String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return false
        }
        let context = appDelegate.persistentContainer.viewContext
        
        /*
            관리 객체의 값을 수정!!!
            항목별로 값을 수정하면 컨텍스트에 저장된 내용도 그대로 변경된다.
         */
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        guard let logObj = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as? LogMO else { return false }
        logObj.regdate   = Date()
        logObj.type      = LogType.edit.rawValue
        
        logObj.board = object as! BoardMO
        
        do
        {
            /*
                매번 관리객체 값이 바뀔 때마다 save()를 해야할까? x 컨텍스트를 통해 관리 객체를 수정할 때마다
                발생된 변경 내용을 모두 동기화하고 있음 근데 깃헙느낌처럼 영구저장소에도 따로 동기화를 해야함.
             */
            try context.save()
            self.list = self.fetch()
            return true
        }
        catch
        {
            context.rollback()
            return false
        }
    }
    
    //MARK: - event Handler
    @objc func add(_ sender: Any)
    {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        alert.addTextField() { $0.placeholder = "제목" }
        alert.addTextField() { $0.placeholder = "내용" }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default)
                        {
            (_) in
            guard let title = alert.textFields?.first?.text , let contents = alert.textFields?.last?.text else
            {
                return
            }
            if self.save(title: title, contents: contents)
            {
                self.tableView.reloadData()
            }
        })
        self.present(alert, animated: true)
            
    }
    
}
