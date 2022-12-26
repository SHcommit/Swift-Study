//
//  newSceneDelegate.swift
//  customTabBar
//
//  Created by 양승현 on 2022/07/01.
//

import UIKit
/**
 * TODO : 직접 tabBarController 소환하기
 */
class NewSceneDelegate : UIResponder, UIWindowSceneDelegate
{
    var winodw : UIWindow?
    func scene(_ scene : UIScene, willConnectTo session : UISceneSession
               , options connectionOptions : UIScene.ConnectionOptions)
    {
        
        let tbC = UITabBarController()
        tbC.view.backgroundColor = .white
        
        self.winodw?.rootViewController = tbC
        
        let view01 = FirstViewController()
        let view02 = SecondViewController()
        let view03 = ThirdViewController()
        
        tbC.setViewControllers([view01,view02,view03], animated: false)
        view01.tabBarItem = UITabBarItem(title: "calendar", image: UIImage(named : "calendar"), selectedImage: nil)
        view02.tabBarItem =
        UITabBarItem(title: "file-tree", image: UIImage(named: "file-tree"), selectedImage: nil)
        view03.tabBarItem = UITabBarItem(title: "Photo", image: UIImage(named: "photo"), selectedImage: nil)
    }
}
