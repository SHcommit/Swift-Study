import UIKit

struct UserInfoManagerLoginModel: Codable {
    let resultCode: Int
    let accessToken: String
    let refreshToken: String
    let userInfo: UserInfoModel
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userInfo = "user_info"
        case errorMessage = "error_msg"
    }
}

struct UserInfoModel: Codable {
    let loginID: Int
    let account: String
    let name: String
    let profileData: Data?
    
    enum CodingKeys: String, CodingKey {
        case loginID = "user_id"
        case account
        case name
        case profileData = "profile_path"
    }
    
    
    
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            loginID = try container.decode(Int.self, forKey: .loginID)
            account = try container.decode(String.self, forKey: .account)
            name = try container.decode(String.self, forKey: .name)
            
            guard let imagePath = try? container.decode(String.self, forKey: .profileData),
                let imgURL = URL(string: imagePath),
                let imgData = try? Data(contentsOf: imgURL) else {
                profileData = nil
                return
            }
            profileData = imgData
        }
}
