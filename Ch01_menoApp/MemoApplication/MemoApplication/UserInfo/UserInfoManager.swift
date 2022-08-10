import UIKit

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
