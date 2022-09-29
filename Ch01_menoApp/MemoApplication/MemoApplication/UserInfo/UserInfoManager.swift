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
class UserInfoManager {
    
    var plist = UserDefaults.standard
    
    var loginID: Int {
        get {
            return plist.integer(forKey:UserInfoKeyDTO.loginID)
        }
        set(value) {
            plist.set(value, forKey: UserInfoKeyDTO.loginID)
            plist.synchronize()
        }
    }
    
    var account: String? {
        get {
            return plist.string(forKey:UserInfoKeyDTO.account)
        }
        set(value){
            plist.set(value, forKey:UserInfoKeyDTO.account)
            plist.synchronize()
        }
    }
    
    var name: String? {
        get {
            return plist.string(forKey: UserInfoKeyDTO.name)
        }
        set(value) {
            plist.set(value,forKey: UserInfoKeyDTO.name)
            plist.synchronize()
        }
    }
    
    var profile: UIImage? {
        get {
            if let _profile = plist.data(forKey: UserInfoKeyDTO.profile) {
                return UIImage(data: _profile)
            }else {
                return UIImage(named:"account.jpg")
            }
        }
        set(value) {
            if value != nil {
                plist.set(value?.pngData(),forKey: UserInfoKeyDTO.profile)
                plist.synchronize()
            }
        }
    }
    
    var isLogin: Bool {
        if self.loginID == 0 || self.account == nil {
            return false
        }
        return true
    }
    
}

/*
    기존의 로그인 저장 처리 방식은 프로퍼티 리스트를 사용해 true, false 처리에 따른 동기 방식으로 사용했다.
    이전에 NewEditingProfile에서 서버에 저장했던 계정 정보를 이용해
    계정과 비번 입력받아 사용자 정보, 인증 토큰을 발급!!
    ----
    API에는 사용자 정보 데이터 등 다양한 정보가 있다.
    그중에서 외부에서 로그인 처리 기능을 해주는 정보도 들어있다. accessToken과 refreshToken이다.
    얘내는 OAuth 프로토콜을 통해서 받을 수 있다.
    간략하게는 Authorization Server를 통해 Authorization Code를 부여 받고 Resource Server를 통해 토큰을 넘겨주면
    Resource Server회사에 등록된 사용자의 정보를 클라이언트 단으로 받아올 수 있다.
    ----
    이때 URLRequest와 URLSession을 래핑한 오픈소스를 사용함 Alamofire.
    
    Date: 22.09.21
        Model Codable로 적용하기
 */
extension UserInfoManager {
    func login(_ account: String, _ password: String, success: (()->Void)? = nil, fail : ((String)->Void)? = nil) {
        let param : Parameters = [
            "account" : account,
            "passwd"  : password]
        
        let afCall = AF.request(UserInfoPrivate().LoginURL, method: .post, parameters: param, encoding: JSONEncoding.default)
        afCall.responseJSON { res in
            guard let res = try? res.result.get() else {
                fatalError("파싱 형식 다시 확인해야함.")
            }
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
                
                
                //로그인 토큰 추가
                let accessToken = jsonObj["access_token"] as! String
                let refreshToken = jsonObj["refresh_token"] as! String
                
                let tkUtils = TokenUtils()
                if let accTok = tkUtils.load("kr.co.rubypaper.MyMemory", account: "accessToken") {
                    NSLog("accessToken=\(accTok)")
                }else{
                    NSLog("accessToken is nil")
                }
                if let refTok = tkUtils.load("kr.co.rubypaper.MyMemory", account: "refreshToken") {
                    NSLog("refreshToken =\(refTok)")
                }else {
                    NSLog("refreshToken is nil")
                }
                success?()
            }else {
                fail?((jsonObj["error_msg"] as? String) ?? "로그인 실패했습니다.")
            }
        }
    }
    
    func logout(completion: (()->Void)? = nil) {
        let tokUtils = TokenUtils()
        let header   = tokUtils.getAutohrizationHeader()
        let call     = AF.request(UserInfoPrivate().LogoutURL, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        call.responseJSON(){ _ in
            //서버로 응답 온 후 처리할 로그아웃 동작
            self.deviceLogout()
            completion?()
        }
    }
    
    func deviceLogout(){
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKeyDTO.loginID)
        ud.removeObject(forKey: UserInfoKeyDTO.account)
        ud.removeObject(forKey: UserInfoKeyDTO.name)
        ud.removeObject(forKey: UserInfoKeyDTO.profile)
        ud.synchronize()
        
        let tokenUtils = TokenUtils()
        tokenUtils.delete("kr.co.rubypaper.MyMemory", account: "refreshToken")
        tokenUtils.delete("kr.co.rubypaper.MyMemory", account: "accessToken")
    }
    
    /*
     서버에 프로필 정보도 전송
     */
    func newProfile(_ profile: UIImage?, success: (()->Void)? = nil, fail: ((String)->Void)?=nil){

        let tk  = TokenUtils()
        let header = tk.getAutohrizationHeader()
        guard let profileData = profile!.pngData()?.base64EncodedString() else{ NSLog("프로필 nil임 in UserInfoManager");return}
        let param: Parameters = ["profile_image":profileData]
        let call = AF.request(UserInfoPrivate().postProfileURL, method: .post,parameters: param, encoding: JSONEncoding.default, headers: header)
        call.responseJSON{ res in
            guard let jsonObj = try! res.result.get() as? NSDictionary else{
                fail?("올바른 값이 아닙니다.")
                return
            }
             
            guard let resCode = jsonObj["result_code"] as? Int else {NSLog("result코드 잘못됨. 값이 잘 안받아져왔나?"); return }
            if resCode == 0
            {
                self.profile = profile
                success?()
            }else{
                let msg = (jsonObj["error_msg"] as? String) ?? "이미지 프로필 변경이 실패했습니다."
                fail?(msg)
            }
        }
    }
}
