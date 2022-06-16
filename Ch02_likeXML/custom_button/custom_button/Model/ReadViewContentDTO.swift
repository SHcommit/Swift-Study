//
//  ReadViewContentDTO.swift
//  custom_button
//
//  Created by 양승현 on 2022/06/16.
//

import UIKit

class ReadViewContentDTO
{
    var pEmail    : String?
    var pUpdate   : Bool?
    var pInterval : Double?
    var email     = UILabel()
    var update
    = UILabel()
    var interval  = UILabel()
    
    init(_ view : UIView)
    {
        setEmailUI(email: &email)
        setUpdateUI(update: &update)
        setIntervalUI(interval: &interval)
        view.addSubview(email)
        view.addSubview(update)
        view.addSubview(interval)
    }
        
    
}

//MARK: - setContentsUI
extension ReadViewContentDTO
{
    func setEmailUI(email : inout UILabel)
    {
        email = {
           var mail     = UILabel()
            email.frame = CGRect(x: 50, y: 100, width: 300, height: 30)
            email.text  = "전달받은 이메일 : \(self.pEmail!)"
            return mail
        }()
    }
    func setUpdateUI(update : inout UILabel)
    {
        update       = UILabel()
        update.frame = CGRect(x: 50, y: 150, width: 300, height: 30)
        update.text  = "업데이트 여부 : \(self.pUpdate == true ? "업데이트 함" : "업데이트 안함")"
        
    }
    func setIntervalUI(interval : inout UILabel)
    {
        interval       = UILabel()
        interval.frame = CGRect(x: 50, y: 200, width: 300, height: 30)
        interval.text  = "업데이트 주기 : \(self.pInterval!)분마다"
    }
}

//MARK: - set contents instance
extension ReadViewController
{
    
}
