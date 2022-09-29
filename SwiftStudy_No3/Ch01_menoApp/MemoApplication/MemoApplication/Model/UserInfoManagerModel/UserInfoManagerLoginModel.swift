import UIKit

struct UserInfoManagerLoginModel: Codable {
    let resultCode: Int
    let accessToken: String
    let refreshToken: String
    let userInfo: UserInfoModel
    
    enum CodingKeys: String, CodingKey {
        case resultCode = "result_code"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userInfo = "user_info"
    }
}

struct UserInfoModel: Codable {
    let loginID: Int
    let account: String
    let name: String
    let profile: profileImage
    
    enum CodingKeys: String, CodingKey {
        case loginID = "user_id"
        case account
        case name
        case profile = "profile_path"
    }
}

struct profileImage: Codable {
    public let imgData: Data?
    
    init(imgPath: String?) {
        guard let imgPath = imgPath else {
            imgData = nil
            return
        }
        if let imgData = try? Data(contentsOf: URL(string: imgPath)!) {
            guard let data = UIImage(data: imgData)?.pngData() else {
                fatalError()
            }
            self.imgData = data
            return
        }
        imgData = nil
    }
}
