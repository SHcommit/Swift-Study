import UIKit
import Alamofire
/**
 TODO : UserDefaults.standard를 통해 User의 정보를 관리하는 클래스.
 
 - Param plist : UserDefaults.standard
 - Param loginID : UserDefaults.standard에 id값을 부여해서 저장하거나 꺼내옴
 - Param account : plist에 account를 저장하거나 꺼내옴
 - Param name : plist에 이름을 저장하거나 꺼내온다.
 - Param profile : plist에 data형식으로 UIImage를 저장하거나 꺼내온다.
 - Param isLogin : plist의 UserInfoKeyDTO.loginID 값이나 UserInfoKeyDTO.account값이 존재한다면 로그인됨.
 
 - login(_:_: ) func의 첫번째, 두번째 매개변수를 통해 사용자 기록한 로그인 정보가 맞는 정보인지 체크
 - logout() plist에 저장됬던 UserInfoKeyDTO 키값들 전부 삭제.
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class UserInfoManager
{
    var plist   = UserDefaults.standard
    var loginID : Int
    {
        get
        {
            return plist.integer(forKey:UserInfoKeyDTO.loginID)
        }
        set(value)
        {
            
            plist.set(value, forKey: UserInfoKeyDTO.loginID)
            plist.synchronize()
        }
    }
    var account : String?
    {
        get { return plist.string(forKey:UserInfoKeyDTO.account)}
        set(value)
        {
            plist.set(value, forKey:UserInfoKeyDTO.account)
            plist.synchronize()
        }
    }
    var name : String?
    {
        get
        {
            return plist.string(forKey: UserInfoKeyDTO.name)
        }
        set(value)
        {
            plist.set(value,forKey: UserInfoKeyDTO.name)
            plist.synchronize()
        }
    }
    var profile : UIImage?
    {
        get
        {
            if let _profile = plist.data(forKey: UserInfoKeyDTO.profile)
            {
                return UIImage(data: _profile)
            }
            else
            {
                return UIImage(named:"account.jpg")
            }
        }
        set(value)
        {
            if value != nil
            {
                plist.set(value?.pngData(),forKey: UserInfoKeyDTO.profile)
                plist.synchronize()
            }
        }
    }
    var isLogin : Bool
    {
        if self.loginID == 0 || self.account == nil
        {
            return false
        }
        return true
    }
}


extension UserInfoManager
{
    /*
        기존의 로그인 저장 처리 방식은 프로퍼티 리스트를 사용해 true, false 처리에 따른 동기 방식으로 사용했다.
        이전에 NewEditingProfile에서 서버에 저장했던 계정 정보를 이용해
        계정과 비번 입력받아 사용자 정보, 인증 토큰을 발급!!
     */
    func login(_ account: String, _ password: String, success: (()->Void)? = nil, fail : ((String)->Void)? = nil)
    {
        let url = "http://swiftapi.rubypaper.co.kr:2029/userAccount/login"
        let param : Parameters = [
            "account" : account,
            "passwd"  : password
        ]
        
        let afCall = AF.request(url,method: .post, parameters: param, encoding: JSONEncoding.default)
        afCall.responseJSON { res in
            let res = try! res.result.get()
            guard let jsonObj = res as? NSDictionary else{
                fail?("잘못된 응답 형식:\(res)")
                return
            }
            
            let resCode = jsonObj["result_code"] as! Int
            if resCode == 0
            {
                //로그인 성공 -> 이제 userDefaults에도 저장해서 SideBarVC의 헤더뷰에도 출력되게 하자!!!
                let user     = jsonObj["user_info"] as! NSDictionary
                
                self.loginID = user["user_id"] as! Int
                self.account = user["account"] as? String
                self.name    = user["name"] as? String
                
                if let path = user["profile_path"] as? String{
                    if let imageData = try? Data(contentsOf: URL(string: path)!){
                        self.profile = UIImage(data: imageData)
                    }
                }
            }else{
                fail?((jsonObj["error_msg"] as? String) ?? "로그인 실패했습니다.")
            }
        }
    }
    func logout() -> Bool
    {
        plist.removeObject(forKey: UserInfoKeyDTO.loginID)
        plist.removeObject(forKey: UserInfoKeyDTO.account)
        plist.removeObject(forKey: UserInfoKeyDTO.name)
        plist.removeObject(forKey: UserInfoKeyDTO.profile)
        plist.synchronize()
        return true
    }
}
