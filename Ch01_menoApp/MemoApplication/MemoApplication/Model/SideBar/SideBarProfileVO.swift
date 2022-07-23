import UIKit

/**
 TODO : sideBarProfile에 필요한 위젯 프로파일
 
 - Param headerView : 테이블 뷰의 상단 뷰 영역 instance
 - Param nameLabel : user's name
 - Param emailLabel : user's email
 - Param profileImage : user's proflie
 
 # Notes: #
 1. SideBarProfileVO를 사용할 때는 해당 tableView를 인자값으로 주어야 한다.
 
 */
class SideBarProfileVO
{
    let headerView   : UIView
    let nameLabel    : UILabel
    let emailLabel   : UILabel
    let profileImage : UIImageView
    
    init()
    {
        headerView   = UIView()
        nameLabel    = UILabel()
        emailLabel   = UILabel()
        profileImage = UIImageView()
    }
    func headerViewSetup(_ tableView : UITableView)
    {
        headerView.frame           = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70)
        headerView.backgroundColor = .brown
        tableView.tableHeaderView  = headerView
    }
    func nameLabelSetup(_ name: String)
    {
        nameLabel.frame           = CGRect(x:70,y:15,width:100,height:30)
        nameLabel.text            = name
        nameLabel.textColor       = .white
        nameLabel.font            = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.backgroundColor = .clear
        
        headerView.addSubview(nameLabel)
    }
    func emailLabelSetup(_ email : String)
    {
        emailLabel.frame           = CGRect(x: 70, y: 30, width: 100, height: 30)
        emailLabel.text            = email
        emailLabel.textColor       = .white
        emailLabel.font            = UIFont.systemFont(ofSize:11)
        emailLabel.backgroundColor = .clear
        
        headerView.addSubview(emailLabel)
    }
    func profileImageSetup(_ image : String)
    {
        profileImage.image               = UIImage(named:image)
        profileImage.frame               = CGRect(x:10,y:10,width:50,height:50)
        profileImage.layer.cornerRadius  = self.profileImage.frame.width / 2
        profileImage.layer.borderWidth   = 0
        profileImage.layer.masksToBounds = true
        
        headerView.addSubview(profileImage)
    }
}
