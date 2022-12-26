//
//  SettingController.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/11.
//

import UIKit

class SettingController : UIViewController{
    
    var contents : SettingContentVO?
    
    override func viewDidLoad() {
        contents = SettingContentVO(view: &self.view)
        setNavigationTitle()
        
        self.storyboard?.instantiateViewController(identifier: "SettingController")
        
        //액션 메서드
        self.contents?.updateSwitch?.addTarget(self, action: #selector(presentUpdateValue(_:)), for: .valueChanged)
        self.contents?.weekStepper?.addTarget(self, action: #selector(presentIntervalValue(_:)), for: .valueChanged)
        
        /**
         * navigationoBarButton 은 신기하네..
         * 바 버튼 달고 이벤트 헨들러도 달아줌
         */
        self.contents?.submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = contents?.submitBtn
        
        
        //한번 addSubView로만 추가해봤어
        self.view.addSubview({
            var transScene : UIButton = {
                var transScene = UIButton()
                transScene.frame = CGRect(x: self.view.frame.width/2, y: 250, width: 150, height: 50)
                transScene.setTitle("다른 화면", for: .normal)
                transScene.backgroundColor = UIColor.orange
                return transScene
            }()
            transScene.addTarget(self, action: #selector(presentViewController(_:)), for: .touchDown)
            return transScene
        }())
        
    }
}

//MARK: - event Handler
extension SettingController {
    @objc
    func presentUpdateValue(_ sender : UISwitch)
    {
        self.contents?.updateValue?.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    @objc
    func presentIntervalValue(_ sender : UIStepper)
    {
        self.contents?.weekValue?.text = ("\(Int(sender.value))분 마다")
    }
    @objc
    func presentViewController(_ sender: UIButton)
    {
        if let SController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
        {
            self.navigationController?.pushViewController(SController, animated: true)
        }
    }
    @objc
    func submit(_ sender : Any)
    {
        let rvc = ReadViewController()
        rvc.pInterval = self.contents?.weekStepper?.value
        rvc.pEmail = self.contents?.inputEmail?.text
        rvc.pUpdate   = self.contents?.updateSwitch?.isOn
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
}

//MARK: - design contents
extension SettingController{
    func setNavigationTitle()
    {
        self.navigationItem.title = "설정"
    }
}
