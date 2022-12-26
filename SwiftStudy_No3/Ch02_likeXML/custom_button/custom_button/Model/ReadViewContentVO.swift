//
//  ReadViewContentDTO.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/16.
//

import UIKit

class ReadViewContentVO
{
    var email     : UILabel?
    var update    : UILabel?
    var interval  : UILabel?
    
    init(_ view : inout UIView, _ rvc : ReadViewController)
    {
        self.email    = UILabel()
        self.update   = UILabel()
        self.interval = UILabel()
    
        setEmailUI(email: &email,rvc: rvc, view: &view)
        setUpdateUI(update: &update,rvc: rvc, view: &view)
        setIntervalUI(interval: &interval, rvc: rvc, view :&view)
    }
        
    
}

//MARK: - setContentsUI
extension ReadViewContentVO
{
    func setEmailUI(email : inout UILabel?, rvc : ReadViewController, view : inout UIView)
    {
        if let testEmail = email
        {
            testEmail.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
            testEmail.text  = "전달 받은 이메일 : \(String(rvc.pEmail ?? ""))"
            email           = testEmail
            
            view.addSubview(testEmail)
        }else
        {
            NSLog("email 변수 에러")
        }
    }
    
    func setUpdateUI(update : inout UILabel?, rvc : ReadViewController, view : inout UIView)
    {
        if let testUpdate = update
        {
            testUpdate.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
            testUpdate.text  = "업데이트 여부 : \(rvc.pUpdate == true ? "업데이트 함" : "업데이트 안함")"
            update           = testUpdate
            
            view.addSubview(testUpdate)
        }else
        {
            NSLog("update 변수는 nil 값입니다.")
        }
    }
    
    func setIntervalUI(interval : inout UILabel?, rvc : ReadViewController, view : inout UIView)
    {
        if var testInterval = interval
        {
            testInterval.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
            testInterval.text  = "업데이트 주기 : \(Double(rvc.pInterval ?? 0))분마다"
            interval           = testInterval
            
            view.addSubview(testInterval)
        }else
        {
            NSLog("interval 변수 에러")
        }
    }
}

