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
    let profile: Data?
    
    enum CodingKeys: String, CodingKey {
        case loginID = "user_id"
        case account
        case name
        case profile = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        loginID = try container.decode(Int.self, forKey: .loginID)
        account = try container.decode(String.self, forKey: .account)
        name = try container.decode(String.self, forKey: .name)
        
        guard let imagePath = try? container.decode(String.self, forKey: .profile),
            let imgURL = URL(string: imagePath),
            let imgData = try? Data(contentsOf: imgURL) else {
            profile = nil
            return
        }
        
        profile = imgData
    }
}

//struct profileImage: Codable {
//
//    public let imgData: Data?
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let imagePath = try container.decodeIfPresent(String.self, forKey: .imgData) ?? nil
//        guard let imagePath = imagePath, let imgURL = URL(string: imagePath) else {
//            imgData = nil
//            return
//        }
//
//        guard let imgData = try? Data(contentsOf: imgURL) else {
//            self.imgData = nil
//            return
//        }
//        self.imgData = imgData
//    }
//
//    init() {
//        imgData = nil
//    }
//}
