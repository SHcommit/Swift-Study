//
//  settingContentDTO.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/11.
//

import UIKit

class SettingContentVO
{
    /**
     *@param : email              = 이메일
     *@param : inputEmail      = 이메일 입력받는 tf
     *
     *@param : autoUpdate    = 자동갱신
     *@param : updateSwitch = 자동갱신Switch
     *@param : updateValue   = 자동 갱신 여부
     *
     *@param : updateWeek   = 갱신주기
     *@param : weekStepper  = 갱신주기 stepper
     *@param : weekValue      = 갱신주기 stepper 값
     *
     *@param : submitBtn      = ReadViewController로 전환하기 위한 버튼
     */
    var email        : UILabel?
    var inputEmail   : UITextField?
    
    var autoUpdate   : UILabel?
    var updateSwitch : UISwitch?
    var updateValue  : UILabel?
    
    var updateWeek   : UILabel?
    var weekStepper  : UIStepper?
    var weekValue    : UILabel?
    
    var submitBtn    : UIBarButtonItem?
    
    init(view : inout UIView){
        email        = UILabel()
        inputEmail   = UITextField()
        autoUpdate   = UILabel()
        updateSwitch = UISwitch()
        updateValue  = UILabel()
        updateWeek   = UILabel()
        weekStepper  = UIStepper()
        weekValue    = UILabel()
        submitBtn    = UIBarButtonItem()
        
        setContentsUI(&view)
    }
}

//MARK: - set contentsUI
extension SettingContentVO
{
    func setEmailUI(email : inout UILabel?, view : inout UIView)
    {
        if var testEmail = email
        {
            testEmail.text          = "이메일"
            testEmail.frame         = CGRect(x: 30, y: 100, width: 100, height: 30)
            testEmail.textAlignment = .left
            testEmail.font          = UIFont.systemFont(ofSize: 14)
            email                   = testEmail
            
            view.addSubview(testEmail)
        }else{
            return NSLog("email 인스턴스 생성 x")
        }
    }
    func setInputEmailUI(emailTF : inout UITextField?, view : inout UIView)
    {
        if var testEmailTF = emailTF
        {
            testEmailTF               = UITextField()
            testEmailTF.frame         = CGRect(x: 120, y: 100, width: 220, height: 30)
            testEmailTF.placeholder   = "이메일을 입력해주세요."
            testEmailTF.font          = UIFont.systemFont(ofSize: 13)
            testEmailTF.borderStyle   = .roundedRect
            testEmailTF.textAlignment = NSTextAlignment.left
            
            testEmailTF.autocapitalizationType = .none
            
            emailTF = testEmailTF
            view.addSubview(testEmailTF)
        }
        
    }
    
    func setAutoUpdateUI(autoUpdate : inout UILabel?, view : inout UIView)
    {
        if var testAutoUpdate = autoUpdate
        {
            testAutoUpdate       = UILabel()
            testAutoUpdate.frame = CGRect(x: 30, y: 150, width: 100, height: 30)
            testAutoUpdate.text  = "자동갱신"
            testAutoUpdate.font  = UIFont.systemFont(ofSize: 14)
            autoUpdate           = testAutoUpdate
            
            view.addSubview(testAutoUpdate)
        }
    }
    func setUpdateSwitchUI(updateSwitch : inout UISwitch?, view : inout UIView)
    {
        if var testUpdateSwitch = updateSwitch
        {
            testUpdateSwitch       = UISwitch()
            testUpdateSwitch.frame = CGRect(x: 120, y: 150, width: 50, height: 30)
            testUpdateSwitch.setOn(true, animated: true)
            updateSwitch           = testUpdateSwitch
            
            view.addSubview(testUpdateSwitch)
        }

    }
    func setUpdateValueUI(updateValue : inout UILabel?, view : inout UIView)
    {
        if var testUpdateValue = updateValue
        {
            testUpdateValue           = UILabel()
            testUpdateValue.frame     = CGRect(x: 250, y: 150, width: 100, height: 30)
            testUpdateValue.font      = UIFont.systemFont(ofSize: 12)
            testUpdateValue.textColor = UIColor.orange
            testUpdateValue.text      = "갱신함"
            updateValue               = testUpdateValue
            
            view.addSubview(testUpdateValue)
        }
    }
    
    func setUpdateWeekUI(updateWeek : inout UILabel?, view : inout UIView)
    {
        if var testUpdateWeek = updateWeek
        {
            testUpdateWeek       = UILabel()
            testUpdateWeek.frame = CGRect(x: 30, y: 200, width: 100, height: 30)
            testUpdateWeek.text  = "갱신주기"
            testUpdateWeek.font  = UIFont.systemFont(ofSize: 14)
            updateWeek           = testUpdateWeek
            
            view.addSubview(testUpdateWeek)
        }
    }
    func setWeekStepperUI(weekStepper : inout UIStepper?, view : inout UIView)
    {
        if var testWeekStepper = weekStepper
        {
            testWeekStepper              = UIStepper()
            testWeekStepper.frame        = CGRect(x: 120, y: 200, width: 50, height: 30)
            testWeekStepper.minimumValue = 0
            testWeekStepper.maximumValue = 100
            testWeekStepper.stepValue    = 1
            testWeekStepper.value        = 0
            weekStepper                  = testWeekStepper
            
            view.addSubview(testWeekStepper)
        }
    }
    func setWeekValueUI(weekValue : inout UILabel?, view : inout UIView)
    {
        if var testWeekValue = weekValue
        {
            testWeekValue           = UILabel()
            testWeekValue.frame     = CGRect(x: 250, y: 200, width: 100, height: 30)
            testWeekValue.text      = "0분마다"
            testWeekValue.font      = UIFont.systemFont(ofSize: 12)
            testWeekValue.textColor = UIColor.red
            weekValue               = testWeekValue
            
            view.addSubview(testWeekValue)
        }
    }
}

//MARK: - set contents instance
extension SettingContentVO {
    func setContentsUI(_ view : inout UIView){
        setEmailUI(email: &email,view: &view)
        setInputEmailUI(emailTF: &inputEmail,view: &view)
        setAutoUpdateUI(autoUpdate: &autoUpdate,view: &view)
        setUpdateSwitchUI(updateSwitch: &updateSwitch,view: &view)
        setUpdateValueUI(updateValue: &updateValue,view: &view)
        setUpdateWeekUI(updateWeek: &updateWeek,view: &view)
        setWeekStepperUI(weekStepper: &weekStepper,view: &view)
        setWeekValueUI(weekValue: &weekValue,view: &view)
    }
    
}
