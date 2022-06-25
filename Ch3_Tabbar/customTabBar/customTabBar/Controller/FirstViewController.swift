//
//  ViewController.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class FirstViewController: UIViewController {
    var content : FirstViewcontents?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        content = FirstViewcontents(view: &self.view)

    }


}

