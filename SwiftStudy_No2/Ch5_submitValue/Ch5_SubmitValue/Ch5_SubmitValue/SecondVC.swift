//
//  SecondVC.swift
//  Ch5_SubmitValue
//
//  Created by 양승현 on 2022/03/10.
//

import UIKit
/**
 *VC1에서 submit 버튼을 통해 화면 전환을 하고난 직후 이전화면에서 사용자가 입력했던 값들을 업데이트 할 것입니다.*
 */
class SecondViewController : UIViewController {
    
    @IBOutlet var resultEmail: UILabel!
    
    @IBOutlet var resultUpdate: UILabel!
    
    @IBOutlet var resultInterval: UILabel!
    
    var paramEmail: String = ""
    var paramUpdate: Bool = false
    var paramInterval: Double = 0.0
    
    override func viewDidLoad() {
        resultEmail.text = paramEmail
        
        resultUpdate.text = paramUpdate ? "자동 갱신" : "자동 갱신 안함"
        
        resultInterval.text = "\(Int(paramInterval))마다 갱신함."
    }
    
    @IBAction func prevBtn(_ sender: Any) {
        self.presentingViewController!.dismiss(animated: true)
    }
}

