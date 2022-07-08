//
//  ViewController.swift
//  customButton
//
//  Created by 양승현 on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {
    var vcButton = customFirstBtn(frame: CGRect(x: 30, y: 50, width: 150, height: 30), title: "VC에서 추가했지롱")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(vcButton)
    }


}

