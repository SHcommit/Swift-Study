import UIKit
import Security
import Alamofire

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

class TokenUtils{
    func save(_ service: String, account: String, value: String){
        //키 체인에 값 저장하는 메소드 이 메소드를 통해 기존에 값 삭제 후 새로운 키 체인 값 등록!!
        let keyChainQuery : NSDictionary = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        //현재 저장된 값 삭제
        SecItemDelete(keyChainQuery)
        //새로 키 체인 등록
        let status : OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, " 토큰 값 저장에 실패했습니다.")
        NSLog("status=\(status)")
    }
    
    func load(_ service: String, account: String) -> String?
    {
        let keyChainQuery : NSDictionary = [
            kSecClass       : kSecClassGenericPassword,
            kSecAttrServer  : service,
            kSecAttrAccount : account,
            kSecReturnData  : kCFBooleanTrue!,
            kSecMatchLimit  : kSecMatchLimitOne
            
        ]
        
        var dataTypeRef : AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        if status == errSecSuccess{
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        }else{
            NSLog("Nothing was retrieved from the keyChain. Status code \(status)")
            return nil
        }
    }
    func delete(_ service: String, account: String)
    {
        let keyChainQuery : NSDictionary = [
            kSecClass :  kSecClassGenericPassword,
            kSecAttrServer : service,
            kSecAttrAccount : account
        ]
        let status = SecItemDelete(keyChainQuery)
        assert(status==noErr, "토큰 값 삭제 실패")
        NSLog("status=\(status)")
    }
    /*
        
     */
    func getAutohrizationHeader() -> HTTPHeaders?{
        let serviceID = "kr.co.rubypaper.MyMemory"
        if let accessToken = self.load(serviceID, account: "accessToken")
        {
            return ["Authorization":"Bearer \(accessToken)"] as HTTPHeaders
        }else{
            return nil
        }
    }
}
