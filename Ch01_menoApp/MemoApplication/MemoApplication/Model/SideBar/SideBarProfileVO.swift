import UIKit

class SideBarProfileVO
{
    let nameLabel    : UILabel
    let emailLabel   : UILabel
    let profileImage : UIImageView
    let headerView   : UITableViewHeaderFooterView
    
    init(_ headerView : inout UITableViewHeaderFooterView, _ userName : String, _ userEmail : String,_ userImage : String)
    {
        nameLabel    = UILabel()
        emailLabel   = UILabel()
        profileImage = UIImageView()
        
        self.headerView = headerView
        
        nameLabelSetup(userName)
        emailLabelSetup(userEmail)
        profileImageSetup(userImage)
    }
    
    func nameLabelSetup(_ name: String)
    {
        nameLabel.frame           = CGRect(x:70,y:15,width:100,height:30)
        nameLabel.text            = name
        nameLabel.textColor       = .white
        nameLabel.font            = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.backgroundColor = .clear
        
        self.headerView.addSubview(nameLabel)
    }
    func emailLabelSetup(_ email : String)
    {
        emailLabel.frame           = CGRect(x: 70, y: 30, width: 100, height: 30)
        emailLabel.text            = email
        emailLabel.textColor       = .white
        emailLabel.font            = UIFont.systemFont(ofSize:11)
        emailLabel.backgroundColor = .clear
        
        self.headerView.addSubview(emailLabel)
    }
    func profileImageSetup(_ image : String)
    {
        profileImage.image               = UIImage(named:image)
        profileImage.frame               = CGRect(x:10,y:10,width:50,height:50)
        profileImage.layer.cornerRadius  = self.profileImage.frame.width / 2
        profileImage.layer.borderWidth   = 0
        profileImage.layer.masksToBounds = true
        
        self.headerView.addSubview(profileImage)
    }
}
