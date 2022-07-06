//
//  SecondViewController.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class SecondViewController : UIViewController
{
    var content : SecondViewContents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content = SecondViewContents(view: &self.view)

    }
}
