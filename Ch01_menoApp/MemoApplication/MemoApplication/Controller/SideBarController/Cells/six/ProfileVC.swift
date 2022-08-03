import UIKit

/**
 TODO : 사이드 바 상단의 프로필 영역 detail Scene. 사이드 바 메뉴 6번째 Cell인 계정관리와 연결됨.
       계정 정보나 입력, 수정도 가능하다.
  
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class ProfileVC : UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let profileImage = UIImageView()
    let tableView    = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupProfileUI()
        self.profileImage.center = CGPoint(x:self.view.frame.width / 2, y : 270)
        self.tableView.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y+self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tableView.dataSource = self
        self.tableView.delegate   = self
        self.view.addSubview(tableView)
        self.view.bringSubviewToFront(self.tableView)
        self.view.bringSubviewToFront(self.profileImage)

        self.navigationController?.navigationBar.isHidden = true
    }
    
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
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row
        {
        case 0:
            cell.textLabel?.text       = "이름"
            cell.detailTextLabel?.text = "승현이"
        case 1:
            cell.textLabel?.text       = "계정"
            cell.detailTextLabel?.text = "happysh_s2@naver.com"
        default:
            ()
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        let detail = cell?.detailTextLabel
//        switch indexPath.row
//        {
//        case 0:
//            NotificationCenter.default.addObserver(cell,selector: #selector(keyboardWillShow(notification:)),name: UIResponder.keyboardWillShowNotification,object: nil)
//            NotificationCenter.default.addObserver(cell,selector:#selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillShowNotification,object: nil)
//            break;
//        case 1:
//            NotificationCenter.default.addObserver(cell,selector: #selector(keyboardWillShow(notification:)),name: UIResponder.keyboardWillShowNotification,object: nil)
//            NotificationCenter.default.addObserver(cell,selector:#selector(keyboardWillHide(notification:)),name: UIResponder.keyboardWillShowNotification,object: nil)
//            break;
//        default:
//            break;
//        }
//    }
//
    
    //MARK: - setupUI
    func setupNavigationUI()
    {
        //뒤로가기
        let backBtn               = UIBarButtonItem(title : "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.title = "프로필"
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    func setupProfileUI()
    {
        let img = UIImage(named:"account.jpg")
        self.profileImage.image      = img
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center     = CGPoint(x: self.view.frame.width/2 , y:130)
        
        self.profileImage.layer.cornerRadius  = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth   = 0
        self.profileImage.layer.masksToBounds = true
        guard let backgroundImg = UIImage(named:"profile-bg") else
        {
            return NSLog("backgroundImg nil in ProfileVC.swift setupProfileUI()")
        }
        let bgImageView   = UIImageView(image: backgroundImg)
        
        bgImageView.frame.size = CGSize(width:backgroundImg.size.width ,height: backgroundImg.size.height)
        bgImageView.center = CGPoint(x:self.view.frame.width / 2, y : 40)
        bgImageView.layer.cornerRadius = bgImageView.frame.size.width / 2
        bgImageView.layer.borderWidth  = 0
        bgImageView.layer.masksToBounds = true
        self.view.addSubview(profileImage)
        self.view.addSubview(bgImageView)
    }
    //MARK: - event Handler
    @objc func close(_ sender: Any)
    {
        self.presentingViewController?.dismiss(animated: true)
    }
    @objc func keyboardWillShow(notification: NSNotification)
    {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue     )?.cgRectValue else
        {
            return
        }
        UIView.animate(withDuration: TimeInterval(0.3),delay:TimeInterval(0),options:[.curveEaseInOut, .beginFromCurrentState],animations:{
            self.view.frame.origin.y = 0 - keyboardSize.height
            
        },completion: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification)
    {
        UIView.animate(withDuration: TimeInterval(0.3), delay: TimeInterval(0),options:[.curveEaseInOut , .beginFromCurrentState],animations: {
            self.view.frame.origin.y = 0
        },completion: nil)
    }
    override func touchesBegan(_ touches : Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
}
