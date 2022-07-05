//
//  CustomCenterAlertVO.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/05.
//

import UIKit

/**
 * 알람 커스텀 방법?!
 * 음
 * 1. title, message 처리 ?? nil
 *  이때 nil처리하면 좀 더 깔끔해짐. 알림창같지 않아 부분 프래그먼트같이됨 굿!
 * 2. 알림 창의 초기 class를 구현해 놓으면 재사용성이 쉬워짐
 * 3. 메인은 center! 즉 알림창의 title, message와 버튼 사이 공간이 존재하는데 이 곳을 꾸미는 것임!!
 *      하다보면 익숙해짐
 *      재은씨는 주로 UIViewController를 통해서 특정 UI위젯을 구현하고 반환
 * 4. alert.setValue(_:forkey:) 를 이용해서 alert에 추가해야함. 이거 안하면 말짱 도로묵!!
 */
class CustomCenterAlertVO
{
    var centerAlert : callAlertButtonVO
    init() { centerAlert = callAlertButtonVO() }
    
}

//MARK: - customCenterAlertUI
extension CustomCenterAlertVO
{
    //setAlertUI
    //간단하게
    func customCenterAlertUI(_ alert : inout UIAlertController)
    {
        let centerSection = UIViewController()
        centerSection.view.backgroundColor = .brown
        centerSection.preferredContentSize.height = 150
        
        alert.setValue(centerSection, forKey: "contentViewController")
    }
}
