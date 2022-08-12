import UIKit
/*
    TODO : 화면에 사용자의 데이터 tableView로 나타냄. 이벤트 헨들러도 부여
 */
extension ProfileVC : UITableViewDataSource, UITableViewDelegate
{
    //MARK: - UITableViewDataSource implement
    func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int)-> Int
    {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath)-> UITableViewCell
    {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "profileCell")
        
        cell.textLabel?.font       = UIFont.systemFont(ofSize:14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType         = .disclosureIndicator
        
        switch indexPath.row
        {
        case 0:
            cell.textLabel?.text       = "이름"
            cell.detailTextLabel?.text = self.userInfo.name ?? "Login please"
        case 1:
            cell.textLabel?.text       = "계정"
            cell.detailTextLabel?.text = self.userInfo.account ?? "LoginPlease"
        default:
            ()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(self.userInfo.isLogin)
        {
            self.doLogin(self.tableView)
        }
    }
    func setupTableViewUI()
    {
        self.tableView.frame      = CGRect(x: 0, y: self.profileImage.frame.origin.y+self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.view.addSubview(tableView)
        self.view.bringSubviewToFront(self.tableView)
        self.view.bringSubviewToFront(self.profileImage)
    }
}
