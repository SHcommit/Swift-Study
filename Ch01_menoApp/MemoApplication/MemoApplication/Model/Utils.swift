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
    /**
     TODO : 로그인시 키체인 다루기 위한 Utils
     
     - Param keyChainQuery : db로따지면 SQL문과같음 kSecClass 안에 -> Service, Account, ValueData타입이있음.
     
     # Notes: #
     1. 키 채인도 db처럼 저장(SecItemAdd), 읽기(SecItemCopyMatching), 수정(SecItemUpdate), 삭제(SecItemDelete) 기능을 통해 키 체인을 다룰 수있다.
     2. 키 체인 쿼리 (CFDictionary)타입의 데이터 집합을 인자값으로 받아 사용.... 읔 MFC기억이 스멀스멀 떠오르네
        kSecClassGenericPassword를 통해  사용자의 개인 소유 accessToken과 비번을 저장할 것임 kSecClassGenericPassword타입의 아이템클래스를 통해 저장 가능함.
        kSecClassGenericPassword타입에 가장 중요한 속성 두개가 있음
        kSecAttrService(공개키)와 kSecAttrAccount(개인키)임
     3. 한가지 주의할 점은 키체인은 덮어쓰기가 안되서 SecItemDelete를 한 이후 키체인 쿼리를 등록해야 한다는 사실!
     */
    func save(_ service: String, account: String, value: String){
        //키 체인에 값 저장하는 메소드 이 메소드를 통해 기존에 값 삭제 후 새로운 키 체인 값 등록!!
        let keyChainQuery : NSDictionary = [
            //아이템클래스
            kSecClass : kSecClassGenericPassword,
            kSecAttrService : service,
            kSecAttrAccount : account,
            //저장 값
            kSecValueData : value.data(using: .utf8, allowLossyConversion: false)!
        ]
        
        //현재 저장된 값 삭제
        SecItemDelete(keyChainQuery)
        //새로 키 체인 등록
        let status : OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, " 토큰 값 저장에 실패했습니다.")
        NSLog("status=\(status)")
    }
    
    /**
        저장된 값을 읽을 때는 AnyObject를 통해 원하는 타입으로 변환 하도록!
        kSecMatchLimit는 키체인 쿼리 조건에 일치하는 값 여러개있을 때 다 불러오기임.
        kSecMatchLimitOne은 일치하는 한개만 읽어오도록!!
     
        SecItemCopyMatching은 복사!! 근데 OSStatus타입으로 처리 결과 반환함.
     */
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
    /*
     
     삭제할 때는 SecItemDelete사용!!
     */
    func delete(_ service: String, account: String)
    {
        let keyChainQuery : NSDictionary = [
            kSecClass :  kSecClassGenericPassword,
            kSecAttrServer : service,
            kSecAttrAccount : account
        ]
        let status = SecItemDelete(keyChainQuery)

        assert(status == noErr, "토큰 값 삭제 실패")
        NSLog("status=\(status)")
    }
    /*
        서비스아이디!!
        OAuth에 등록할땐 앱 개발자의 클라이언트 아이디가 부여됨
        그후 OAuth API에서 accessToken과 refreshToken을 받아올 수 있음 By Authorization Server, Resource Server
        이젠 accessToken을 키 체인에 저장해야함. UserDefault.standard에 저장하면 털릴수있음.
        
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
