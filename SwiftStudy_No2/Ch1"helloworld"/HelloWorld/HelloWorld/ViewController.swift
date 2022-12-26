//
//  ViewController.swift
//  HelloWorld

//  Created by 양승현 on 2022/03/02.
//

import UIKit
/**
 *루트 뷰 컨트롤러
 *화면의 개수 만큼 VC(ViewController)가 사용된다.
 *@IBOutlet 어노데이션!! IB(Interface builder)에 관련된 속성!!
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var uiTitle: UILabel!
    
    @IBAction func btnSayHello(_ sender: Any) {
        self.uiTitle.text = "Hello world!!"
    }
    
}

