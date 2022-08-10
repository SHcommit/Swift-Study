import UIKit

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
                plist.set(value,forKey: UserInfoKeyDTO.profile)
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
    func login(_ account: String, _ password: String) -> Bool
    {
        if account == "happysh_s2@naver.com" && password == "1234"
        {
            plist.set(100,forKey: UserInfoKeyDTO.loginID)
            plist.set(account, forKey: UserInfoKeyDTO.account)
            plist.set("승현이",forKey: UserInfoKeyDTO.name)
            plist.synchronize()
            return true
        }
        return false
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
