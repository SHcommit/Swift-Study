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
    //메뉴얼 Segue를 통한 데이터 전송
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSegue", sender: self)
    }
    
    //Segue는 세그웨이가 시작될 때 VC1, VC2 인스턴스가 만들어지기 때문에
    //prepare(for:sender:)메소드를 통해 데이터를 전송해야한다.
    //prepare(for:sender:)는 onPerformSegue가 실행되기 전에 호출해주는 메서드이다.
    //여기서 목적지 인스턴스(VC2)를 얻어 값을 전달해주자!!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        
        guard let SecondVC = dest as? SecondViewController else{
            return
        }
        
        SecondVC.paramEmail = tfEmail.text!
        SecondVC.paramUpdate = isUpdateSwitch.isOn
        SecondVC.paramInterval = intervalStepper.value
    }
    
}

