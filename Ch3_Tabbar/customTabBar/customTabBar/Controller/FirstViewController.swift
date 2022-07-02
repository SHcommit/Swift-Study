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

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tabBar = self.tabBarController?.tabBar
        tabBar?.isHidden = tabBar?.isHidden == true ? false : true
        
        // .animate(withDuration: animations:)
        UIView.animate(withDuration : TimeInterval(0.35))
        {
            tabBar?.alpha = (tabBar?.alpha == 0 ? 1 : 0)
        }
    }
}

