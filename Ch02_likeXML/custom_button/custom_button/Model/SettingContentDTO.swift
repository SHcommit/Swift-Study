//
//  settingContentDTO.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/11.
//

import UIKit

class SettingContentDTO
{
    /**
     *이메일
     *이메일 입력받는 tf
     *
     *자동갱신
     *자동갱신Switch
     *자동 갱신 여부
     *
     *갱신주기
     *갱신주기 stepper
     */
    var email         = UILabel()
    var inputEmail    = UITextField()
    
    var autoUpdate    = UILabel()
    var updateSwitch  = UISwitch()
    var updateValue   = UILabel()
    
    var updateWeek    = UILabel()
    var weekStepper   = UIStepper()
    var weekValue     = UILabel()
    
    init(view : inout UIView){
        setContentsUI()
        setContentsInstance(view: &view)
    }
}

//MARK: - set contentsUI
extension SettingContentDTO
{
    func setEmailUI(email : inout UILabel)
    {
        email               = UILabel()
        email.text          = "이메일"
        email.frame         = CGRect(x: 30, y: 100, width: 100, height: 30)
        email.textAlignment = .left
        email.font          = UIFont.systemFont(ofSize: 14)
    }
    func setInputEmailUI(emailTF : inout UITextField)
    {
        emailTF               = UITextField()
        emailTF.frame         = CGRect(x: 120, y: 100, width: 220, height: 30)
        emailTF.placeholder   = "이메일을 입력해주세요."
        emailTF.font          = UIFont.systemFont(ofSize: 13)
        emailTF.borderStyle   = .roundedRect
        emailTF.textAlignment = NSTextAlignment.left
        
        emailTF.autocapitalizationType = .none
    }
    
    func setAutoUpdateUI(autoUpdate : inout UILabel)
    {
        autoUpdate       = UILabel()
        autoUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
        autoUpdate.text  = "자동갱신"
        autoUpdate.font  = UIFont.systemFont(ofSize: 14)
    }
    func setUpdateSwitchUI(updateSwitch : inout UISwitch)
    {
        updateSwitch       = UISwitch()
        updateSwitch.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
        updateSwitch.setOn(true, animated: true)
    }
    func setUpdateValueUI(updateVale : inout UILabel)
    {
        updateVale           = UILabel()
        updateVale.frame     = CGRect(x: 250, y: 150, width: 100, height: 30)
        updateVale.font      = UIFont.systemFont(ofSize: 12)
        updateVale.textColor = UIColor.orange
        updateVale.text      = "갱신함"
    }
    
    func setUpdateWeekUI(updateWeek : inout UILabel)
    {
        updateWeek       = UILabel()
        updateWeek.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
        updateWeek.text  = "갱신주기"
        updateWeek.font  = UIFont.systemFont(ofSize: 14)
    }
    func setWeekStepperUI(weekStepper : inout UIStepper)
    {
        weekStepper              = UIStepper()
        weekStepper.frame        = CGRect(x: 120, y: 200, width: 50, height: 30)
        weekStepper.minimumValue = 0
        weekStepper.maximumValue = 100
        weekStepper.stepValue    = 1
        weekStepper.value        = 0
    }
    func setWeekValueUI(weekValue : inout UILabel)
    {
        weekValue           = UILabel()
        weekValue.frame     = CGRect(x: 250, y: 200, width: 100, height: 30)
        weekValue.text      = "0분마다"
        weekValue.font      = UIFont.systemFont(ofSize: 12)
        weekValue.textColor = UIColor.red
    }
}

//MARK: - set contents instance
extension SettingContentDTO {
    func setContentsUI(){
        setEmailUI(email: &email)
        setInputEmailUI(emailTF: &inputEmail)
        setAutoUpdateUI(autoUpdate: &autoUpdate)
        setUpdateSwitchUI(updateSwitch: &updateSwitch)
        setUpdateValueUI(updateVale: &updateValue)
        setUpdateWeekUI(updateWeek: &updateWeek)
        setWeekStepperUI(weekStepper: &weekStepper)
        setWeekValueUI(weekValue: &weekValue)
    }
    func setContentsInstance(view : inout UIView){
        view.addSubview(email)
        view.addSubview(inputEmail)
        
        view.addSubview(autoUpdate)
        view.addSubview(updateSwitch)
        view.addSubview(updateValue)
        
        view.addSubview(updateWeek)
        view.addSubview(weekStepper)
        view.addSubview(weekValue)
    }
}
