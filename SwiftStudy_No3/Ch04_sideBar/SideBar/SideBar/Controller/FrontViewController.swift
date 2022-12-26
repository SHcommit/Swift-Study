//
//  FrontViewController.swift
//  SideBar
//
//  Created by 양승현 on 2022/07/16.
//

import UIKit

class FrontViewController : UIViewController
{
    
    @IBOutlet weak var sideBarButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*
            .target을 하기 위해서는 메서드가 속한 인스턴스를 지칭 해 주어야 함
            .action은 revealVC.revealToggle(_:)형식으로
         */
        if let revealVC = self.revealViewController()
        {
            self.sideBarButton.target = revealVC
            self.sideBarButton.action = #selector(revealVC.revealToggle(_:))
            
            //버튼말고 제스쳐로도 화면 이동
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
}
