//
//  ViewController.swift
//  customNavigationBar
//
//  Created by 양승현 on 2022/07/02.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if var navigation = self.navigationController
        {
            
            var customNavi = CustomNavi(&navigation)
            // 네비게이션 컨트롤러에 넹비게이션 아이템 제목으로 타이틀달면안돼
            //self.navigationController?.navigationItem.titleView = customNavi.containerView
            //self.navigationItem.titleView = customNavi.containerView
            
        }else
        {
            NSLog("커스텀 네비 적용 안됨")
        }
        
    }
    

}

