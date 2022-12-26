//
//  CallAlertButtonVO.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/05.
//

import UIKit

class callAlertButtonVO
{
    var callAlertButton : UIButton
    var alert           : UIAlertController
    init()
    {
        callAlertButton = UIButton()
        alert           = UIAlertController()
    }
    //디폴트 버튼
    func addButtonObject(_ view : inout UIView, _ button : inout UIButton, _ title : String, _ color : UIColor , _ index : Int)
    {
        button.frame              = CGRect(x: 0, y: 100, width: 100, height: 30)
        button.layer.cornerRadius = 2
        button.backgroundColor    = color
        button.center.x           = view.frame.width  / 2 
        button.center.y           = view.frame.height / 10 * CGFloat(index)
        button.setTitle(title, for: .normal)
        
        view.addSubview(button)
    }
    //초기 디폴트 알람
    //액션시트와 alert 두가지 방식있어서 두개다 구현해봄 액션시트일땐 취소있으면 별로여서 확인만 했음
    func defaultAlert(_ title : String?, _ message : String?, _ preferredStyle : UIAlertController.Style ) -> UIAlertController
    {
        let alert = UIAlertController(title: title ?? nil, message: message ?? nil, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        switch preferredStyle
        {
        case .alert :
            alert.addAction(UIAlertAction(title: "Cancel", style:.cancel))
            break;
        case .actionSheet :
            break;
        default :
            break;
        }
        
        return alert
    }
}
