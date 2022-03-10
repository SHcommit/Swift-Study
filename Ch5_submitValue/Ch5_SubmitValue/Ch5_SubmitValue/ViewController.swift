//
//  ViewController.swift
//  Ch5_SubmitValue
//
//  Created by 양승현 on 2022/03/10.
//

import UIKit
/**
 *현재 VC의 목적
 *아래의 세개 아울렛 변수
 * tfEmail, isUpdateSwitch, intervalStepper과 연결된 콘텐츠에
 *사용자가 입력한 값을 받아서, 다음 화면SecondVC에서 그 값을 전달 후 화면에 출력할 것이다. *
 *
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var tfEmail: UITextField!
    
    @IBOutlet var isUpdateSwitch: UISwitch!
    
    @IBOutlet var isUpdateText: UILabel!
    
    @IBAction func onSwitch(_ sender: Any) {
        if isUpdateSwitch.isOn {
            isUpdateText.text = "자동갱신"
        }else{
            isUpdateText.text = "자동갱신 안함"
        }
    }
    
    @IBOutlet var intervalStepper: UIStepper!
    
    @IBOutlet var intervalText: UILabel!
    
    @IBAction func onStepper(_ sender: Any) {
        let value = Int((sender as! UIStepper).value)
        self.intervalText.text = "\(value) 분 마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        var nextVC = "SecondVC"
        guard let SecondVC = self.storyboard?.instantiateViewController(withIdentifier:nextVC) as? SecondViewController else{
            NSLog("스토리보드에서 \(nextVC)를 찾을 수 없습니다.")
            return
        }
        SecondVC.paramEmail = tfEmail.text!
                
        SecondVC.paramUpdate = isUpdateSwitch.isOn ? true : false
        
        SecondVC.paramInterval = intervalStepper.isContinuous ? intervalStepper.value : intervalStepper.minimumValue
        
        SecondVC.modalTransitionStyle = .coverVertical
        
        present(SecondVC,animated: true)
    }
    
}

