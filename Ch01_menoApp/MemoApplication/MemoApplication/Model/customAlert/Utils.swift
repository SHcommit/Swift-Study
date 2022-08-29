import UIKit
/*
    self.alertMainThread("하하"){completion 클로저 내용}으로 실행 가능
    Date : 22.08.28
    Model defaultAlert, WarningAlert를 구현했는데 extension으로 사용하기 쉽게 기능 추가 해보자.
 */
extension UIViewController{
    func alertMainThread(_ message: String, completion : (() -> Void)? = nil){
        //mainThread에서 실행 ( URLSession 알림 / 경고용 )
        DispatchQueue.main.async {
            let alertVO = customAlertVO(title: nil, message: message, style: .alert)
            alertVO.addBtn(title: "확인", style: .cancel){
                _ in
                //확인 버튼 이후에 실행할 액션
                completion?()
                
                NSLog("success completion")
            }
            self.present(alertVO.alert,animated: false)
        }
    }
}
