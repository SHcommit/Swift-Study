//
//  ViewController.swift
//  customButton
//
//  Created by 양승현 on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {
    var vcButton = customFirstBtn(frame: CGRect(x: 30, y: 50, width: 150, height: 30), title: "VC에서 추가했지롱")
    
    var circleButton = customFirstBtn(type: .circle)
    var rectBtn      = customFirstBtn(type: .rect)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(vcButton)
        circleButton.frame    = CGRect(x: 30, y: 200, width: 150, height: 30)
        circleButton.center.y = self.view.center.y / 10 * 4
        self.view.addSubview(circleButton)
        
        rectBtn.frame    = CGRect(x: 30, y: 200, width: 150, height: 30)
        rectBtn.center.y = self.view.center.y / 10 * 6
        self.view.addSubview(rectBtn)
        rectBtn.style = .circle
    }


}

