//
//  ViewController.swift
//  SQLite3
//
//  Created by 양승현 on 2022/08/17.
//

import UIKit

class ViewController: UIViewController {
    var db     : OpaquePointer? = nil
    var stmt   : OpaquePointer? = nil
    let dbpath : String? =
    {
        let fileMgr    = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        return docPathURL?.appendingPathComponent("db.sqlite").path
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

}

class SQLiteDatabase
{
    var db     : OpaquePointer? = nil
    var stmt   : OpaquePointer? = nil
    let dbpath : String? =
    {
        let fileMgr    = FileManager()
        let docPathURL = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        return docPathURL?.appendingPathComponent("db.sqlite").path
    }()
    func openDatabase() -> OpaquePointer?
    {
        var db : OpaquePointer?
        guard let dbPath = self.dbpath else
        {
            NSLog("dbPath is nil")
        }
        
        if sqlite3_open(dbPath, &db)
        {
            NSLog("성공적으로 db를 받아왔습니다.")
            
        }
            
    }
}
