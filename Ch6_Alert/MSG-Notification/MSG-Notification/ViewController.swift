//
//  ViewController.swift
//  MSG-Notification
//
//  Created by 양승현 on 2022/03/19.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var msg: UITextField!
    
    @IBOutlet var datepicker: UIDatePicker!
    @IBAction func save(_ sender: Any) {
        if #available(iOS 10.0, *){
            //UserNotification
            UNUserNotificationCenter.current().getNotificationSettings {
                if $0.authorizationStatus == .authorized {
                    // user가 allow 시 알림 객체 만들고 정의.
                    
                    //알림 컨텐츠 정의
                    let nContent = UNMutableNotificationContent()
                    nContent.body = (self.msg.text)!
                    nContent.title = "미리 알림"
                    nContent.sound = UNNotificationSound.default
                    
                    //오호.. 발송시각을 위치 현재시각이 아닌
                    // '지금으로부터 *초 형식' 으로 변환
                    let time = self.datepicker.date.timeIntervalSinceNow
                    
                    //발송 조건 정의
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                    
                    //위에서 정의한 알림 컨텐츠와 발송 시각을 토대로 식별자를 추가해 알림 객체로 만든다!!
                    let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) {
                        (_) in
                        DispatchQueue.main.async {
                            let date = self.datepicker.date.addingTimeInterval(9*60*60)
                            
                            let message = "알림이 등록됬습니다 \(date)에 발송됩니다."
                            let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "확인", style: .default))
                            
                            self.present(alert,animated: false)
                        }
                    }
                }else {
                    let alert = UIAlertController(title: "알림 등록", message: "알림 설정이 되지 않았습니다.", preferredStyle: .alert)
                    alert.addAction({
                        UIAlertAction(title: "확인", style: .default)
                    }())
                    self.present(alert, animated: false)
                    return
                }
            }
        }else{
            //iOS 9이하 UILocalNotification
        }
    }
}

