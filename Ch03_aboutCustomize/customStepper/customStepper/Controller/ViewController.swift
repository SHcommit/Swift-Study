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
        
        /*
        countStepper.stepper.leftBtn.addTarget(self, action: #selector(leftButtonTouchUP(_:)), for: .touchUpInside)
        countStepper.stepper.rightBtn.addTarget(self, action: #selector(rightButtonTouchUP(_:)), for: .touchUpInside)
         */
        countStepper.stepper.leftBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
        countStepper.stepper.rightBtn.addTarget(self, action: #selector(valueChange(_:)), for: .touchUpInside)
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
    
}
