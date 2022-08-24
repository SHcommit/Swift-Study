//
//  ListVC.swift
//  CoreDataStudy
//
//  Created by 양승현 on 2022/08/25.
//

import UIKit
import CoreData

class ListVC : UITableViewController
{
    
    /*
        fetch를 통해 NSManagedObject를 받는다
        ** NSManagedObject란?
        ***** 코어 데이터 모델 object를 기본으로함.
        ***** 관리 객체
        ***** entity 정보 담겨있음 꺼낼뗸
     */
    lazy var list: [NSManagedObject] =
    {
        return self.fetch()
    }()
    
    
    func fetch() -> [NSManagedObject]
    {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트
        let contextDAO      = appDelegate.persistentContainer.viewContext
        
        //요청 객체
        //코어 데이터에서 레코드를 읽어오는 과정을 페치라고함(데이터 가져오기)
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Board")
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
        return cell
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
    
    //MARK: - barButton
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
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else { return false }
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do
        {
            //컨텍스트 변경 사항 영구 저장소와 동기화
             
            try context.save()
            self.list.append(object)
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
