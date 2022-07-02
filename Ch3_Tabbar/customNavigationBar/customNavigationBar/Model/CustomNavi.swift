//
//  CustomNavi.swift
//  customNavigationBar
//
//  Created by 양승현 on 2022/07/02.
//

import UIKit

class CustomNavi
{
    var topTitle      : UILabel
    var subTitle      : UILabel
    var containerView : UIView
    init(_ navigation : inout UINavigationController )
    {
        containerView = UIView()
        topTitle      = UILabel()
        subTitle      = UILabel()
        customNavigation(&containerView,&topTitle, &subTitle, &navigation)
        
    }
}

//MARK: - set NavigationUI
extension CustomNavi
{
    func customNavigation(_ container : inout UIView,_ topTitle : inout UILabel, _ subTitle : inout UILabel, _ navigation : inout UINavigationController)
    {
        container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        
        
        topTitle.frame = CGRect(x: 0, y: 0, width: 200, height: 18)
        topTitle.numberOfLines = 1
        topTitle.textColor     = .white
        topTitle.textAlignment = .center
        topTitle.text          = "58개 숙소"
        topTitle.font          = UIFont.systemFont(ofSize: 15)
        
        subTitle.frame         = CGRect(x: 0, y: 18, width: 200, height: 18)
        subTitle.numberOfLines = 1
        subTitle.textAlignment = .center
        subTitle.textColor     = .white
        subTitle.font          = UIFont.systemFont(ofSize: 15)
        subTitle.text          = "1박(1월 10일 ~ 1월 11일)"
        container.addSubview(topTitle)
        container.addSubview(subTitle)
        
        //배경 색
        let color = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1.0)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance

        
    }
}
