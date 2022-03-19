//
//  AppDelegate.swift
//  MSG-Notification
//
//  Created by 양승현 on 2022/03/19.
//

import UIKit
import UserNotifications

/**
 * 로컬 알림 구현하기 앞서 p391
 * 1. application(_:didFinishLaunchingWithOptions:)를 통해 알림 설정환경 등록하고,
 * 2. UNUserNotificationCenter.current().getNotificationSettings { $0.authorizationStatus 상태가 .authorized인지 확인한다.}
 * 3. 로컬 알림에 대한 콘텐츠를
 *  nContent = UNMutableNotificationContent() 인스턴스를 생성하고, 정의한다.
 *  ( 알람 떳을때 앱 아이콘 (빨간)+1 표시, 알람 제목(title) 내용(body), sound 등등.
 *
 * 4. 이 알람 객체가 언제 호출 될 것인지 UNTimeIntervalNotificationTrigger를 통해 생성한다.
 * 5. UNNotificationRequest 를 통해 알림 요청 객체를 생성한다.
 *  -> 3에서 정의한 알림 인스턴스를 좀더 명확하게 하는 느낌 (식별자 부여랑, 언제 호출될 것인지 등)
 * 6. 이렇게 5에서 생성한 진짜 알림 요청 객체를 UNUserNotificationCenter.current().add(알림요청 객체)
 *  등록한다!
 *    이는 노피티케이션 센터에 알림 요청 객체가 추가되어, 추후 노피티케이션 센터는 iOS 스케줄링에 값 등록하고, 알림을 정해진시간에 발송시켜준다.
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {


    /**
     **앱 시작시 사용자에게 승인 받아야함.
     *
     * 로컬 알림, 푸시알림 사용하기 위해서는 UNUserNotificationCenter객체를 이용해
     * 미리 알림설정 환경을 정의 해야 한다.
     * -> 사용자에게 추후 이 알림을 받을 건지 동의 여부를 구해야한다.
     *
     * UNUserNotificationCenter는 싱글톤 패턴으로 정의 되어있다.
     * -> 시스템에서 만들어진 인스턴스를 UNUserNotificationCenter.current( ) 메서드를 통해 참조받아야한다.*
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 10.0 , *){
            let notiCenter = UNUserNotificationCenter.current()
            
            //첫번째 인자값 : 배열타입(알림메시지에 포함될 항목들)
            notiCenter.requestAuthorization(options: [.alert,.badge,.sound]){(didAllow,e) in }
            
            /*
             로컬알림을. 사용자가 클릭했을 때 감지하는 방법
              - 이로써 앱 델리게이트 클래스는 사용자의 알림 메시지 클릭 이벤트를 전달 받을 수 있다.
            */
            notiCenter.delegate = self
            
            
        }else{
            //iOS 9 이하는 UILocalNotification 사용해야함.
            //UILocationNotification 을 통한 로컬 알림 (iOS 9 이하)
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting)
            
            // UILocalNotification 사용자가 클릭했을 때 알림 처리 방법
            // 실행중에? 종료중에?? 이 정보는 매개변수 launchOptions를 통하 알 수 있다.
            if let localNoti = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification {
                print((localNoti.userInfo?["name"])!)
            }
        }

        return true
        
    }
    /**
     * 위의 application(_:didFinishLaunchingWithOptions:)를 통해 알림 설정 환경을 정의 했다면,
     *
     * #available(iOS 10.0 , *) 에서만 작동하는 if문에서,
     * UNUserNotificationCenter.cuttner().getNotificaitonSettings에서 인자값.authorizationStatus를 통해
     * 사용자가 허락했으면 .authorized 의 값을 갖는다.
     * 이 경우에만 이제 개발자가 원하는 알림을 정의하고, UNUserNotificationCenter에 추가한다!!!!
     */
    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings{
                settings in
                // 사용자가 동의 했다면
                if settings.authorizationStatus ==  UNAuthorizationStatus.authorized {
                    /**
                     * UNMutableNotificationCenter()를 통해 우선 알림 내용 정의하자.
                     * 여기서 title과 body 속성은 거의 항상 사용되는 중요한 속성이다.
                     *  -> 때에 따라서 subtitle은 생략될 수 있다.
                     *
                     * 딕셔너리형태로 이 알림의 userInfo를 저장했다.
                     *   추후 이 키 값을 통해 <앱 델리게이트 메소드>에서 참조할 수 있다.
                     */
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "아직 앱의 3%밖에 체험을 하지 못했습니다 ㅜㅜ"
                    nContent.body = "다시들어오세요~"
                    nContent.sound = UNNotificationSound.default
                    //딕셔너리에 사용자 정보 저장 [String:String]형태
                    nContent.userInfo = ["name":"가나다"]
                    
                    //알림 발송 조건 객체
                    //5초 후에 발송, 반복 x
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    //알림 요청 객체
                    //첫번째 인자값 : 해당 알림객체 식별자 정의.
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    
                    //노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                }else{
                    NSLog("사용자 동의하지 않았습니다")
                }
            }
        }else{
            //iOS 9 이하는 UILocalNotification 사용해야함.
            //UILocationNotification 을 통한 로컬 알림 (iOS 9 이하)
            let setting = application.currentUserNotificationSettings
            
            guard setting?.types != .none else{
                print("스케줄러 등록 안됨")
                return
            }
            
            let noti = UILocalNotification()
            //10초후 발송 예약
            noti.fireDate = Date(timeIntervalSinceNow : 10)
            
            /**
             *타임존은 발송될 시각에 대한 시간대를 설정함.
             *.autoupdatingCurrnet 값은 현재 위치를 바탕으로 시간대 자동 업데이트!! 오호,,*
             */
            noti.timeZone = TimeZone.autoupdatingCurrent // 타임존?
            noti.alertBody = "다시 접속해주세요 (아직 빙산의 일각만 보셨어요)"
            //잠금상태일 때
            noti.alertAction = "학습하기"
            
            //앱 모서리 뱃지 표시될 알림 갯수
            noti.applicationIconBadgeNumber = 1
            noti.soundName = UILocalNotificationDefaultSoundName
            noti.userInfo = ["name" : "가나다"]
            
            // 알림 객체를 스케줄러에 등록
            application.scheduleLocalNotification(noti)
            
        }
        
    }
    // MARK: Implement UNUserNotificationCenterDelegate prototype
    
    @available(iOS 10.0 , *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler : @escaping () -> Void){
        
        if response.notification.request.identifier == "wakeup" {
            let userInfo = response.notification.request.content.userInfo
            NSLog(userInfo["name"]! as! String)
            
        }
        completionHandler()
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

