//
//  ViewController.swift
//  customStepper
//
//  Created by 양승현 on 2022/07/11.
//

import UIKit

class ViewController: UIViewController {
    var countStepper = CSStepper(frame: CGRect(x: 30, y: 100, width: 130, height: 30))
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(countStepper)
        
        
        countStepper.stepper.leftBtn.addTarget(self, action: #selector(leftButtonTouchUP(_:)), for: .touchUpInside)
        countStepper.stepper.rightBtn.addTarget(self, action: #selector(rightButtonTouchUP(_:)), for: .touchUpInside)
    }
    //MARK: - event Handler
    @objc func leftButtonTouchUP(_ sender : UIButton)
    {
        if countStepper.stepper.count != 0
        {
            countStepper.stepper.count -= sender.tag
        }
        countStepper.stepper.centerLabel.text = String(countStepper.stepper.count)
    }
    @objc func rightButtonTouchUP(_ sender : UIButton)
    {
        if countStepper.stepper.count != 100
        {
            countStepper.stepper.count += sender.tag
        }
        countStepper.stepper.centerLabel.text = String(countStepper.stepper.count)
    }
    
    /*
     위에는 내가 해본건데
     sender.tag를 통해서 특정 버튼의 값을 얻어올 수있구나.
     그리고 난 즉시 스트링을변경했느데
     count 에 didset로 바꿔도되는구나 ..
     */
    @objc func valueChange(_ sender : UIButton)
    {
        if countStepper.stepper.count > 100 && countStepper.stepper.count < 0
        {
            return
        }
        countStepper.stepper.count += sender.tag
    }
}

