//
//  AppDelegate.swift
//  myProject
//
//  Created by 양승현 on 2022/01/08.
//
//AppleDelegate.swift
/*
    앱 전체의 실행 흐름을 컨트롤하는 객체
 */
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    //20.01.09
    //아래의 메서드는 앱이 처음 실행될 때 필요한 시스템 적 처리를 모두 끝내고,
    //메인 화면을 표시하기 직전에 이 메서드가 호출됨.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(5)//c와는 다르게 input/1000초가 아니라 말 그대로 5 초임.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

