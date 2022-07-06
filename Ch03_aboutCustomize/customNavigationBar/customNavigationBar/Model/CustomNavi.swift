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
    init(_ navigation : inout UINavigationController)
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
    func setTopTitle(_ title : inout UILabel)
    {
        var flag = "ver2.0"
        switch flag
        {
        case "ver1.0":
            title.frame         = CGRect(x:0, y :0, width: 200 ,height: 18)
            title.font          = UIFont.systemFont(ofSize: 15)
            title.numberOfLines = 1
            title.text          = "58개 숙소"
            title.textColor     = .white
            title.textAlignment = .center
            break;
        case "ver2.0":
            let image  = UIImage(named:"swift_logo")
            let imageV = UIImageView(image: image)
            break;
        default:
            break;
        }
    }
    
    func setSubTitle(_ title : inout UILabel)
    {
        title.frame         = CGRect(x:0,y:18,width: 200 ,height: 18)
        title.numberOfLines = 1
        title.font          = UIFont.systemFont(ofSize: 15)
        title.textColor     = .white
        title.textAlignment = .center
        title.text          = "1박(1월 10일 ~ 1월 11일)"
        
    }
    func setNaviBackground(_ navigation : inout UINavigationController)
    {
        let color      = UIColor(red: 0.02, green: 0.22, blue: 0.49, alpha: 1)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigation.navigationBar.standardAppearance   = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        
    }
    func customNavigation(_ container : inout UIView,_ topTitle : inout UILabel, _ subTitle : inout UILabel, _ navigation : inout UINavigationController)
    {
        setTopTitle(&topTitle)
        setSubTitle(&subTitle)
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 36))
        container.addSubview(topTitle)
        container.addSubview(subTitle)
        
        //배경 색
        setNaviBackground(&navigation)

        
    }
}
