//
//  ThirdViewController.swift
//  customTabBar
//
//  Created by 양승현 on 2022/06/25.
//

import UIKit

class ThirdViewController : UIViewController
{
    var content : ThirdViewContents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        content = ThirdViewContents(view: &self.view)
    }
}
