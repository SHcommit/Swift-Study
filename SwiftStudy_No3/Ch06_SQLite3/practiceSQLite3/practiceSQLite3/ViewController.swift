//
//  ViewController.swift
//  practiceSQLite3
//
//  Created by μμΉν on 2022/08/18.
//

import UIKit

class ViewController: UIViewController {
    var sqlite : SQLiteDatabase?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sqlite = SQLiteDatabase()
    }
    
}

