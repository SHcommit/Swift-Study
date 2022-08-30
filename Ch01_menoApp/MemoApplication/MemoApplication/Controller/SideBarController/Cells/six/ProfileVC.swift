import UIKit

/**
 TODO : 사이드 바 상단의 프로필 영역 detail Scene. 사이드 바 메뉴 6번째 Cell인 계정관리와 연결됨.
       계정 정보나 입력, 수정도 가능하다.
  
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. ProfileVC는 ViewCotnroller이다.
    ProfileVC안에 구현된 TableView의 인스턴스를 얻는 방법은
    tableView 인스턴스를 생성하고 dataSource, delegate를 self로 하면 된다.
    //참고로 테이블 뷰를 갱신하고 싶을 때는 reloadData( )
 
 
 */
class ProfileVC : UIViewController
{
    let profileImage = UIImageView()
    let tableView    = UITableView()
    let userInfo     = UserInfoManager()
    var isCalling    = false
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    @IBAction func backProfile(_ sender: UIStoryboardSegue)
    {
        
        //unwind segue 사용하기위해 예를들어 네비 -> scene1 -> scene2 ->scene3
        //scene3에서 scene1가기위해서
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationUI()
        setupProfileUI()
        setupTableViewUI()
        drawBtn()
        addTapGestrueInProfileImage()
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(indicatorView)
        
        
    }
    //MARK: - setupUI
    func setupNavigationUI()
    {
        //뒤로가기
        let backBtn               = UIBarButtonItem(title : "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.title = "프로필"
        let newBtn                = UIBarButtonItem(title: "새 계정", style: .plain, target: self, action: #selector(new(_:)))
        
        self.navigationItem.rightBarButtonItem = newBtn
        self.navigationItem.leftBarButtonItem  = backBtn
        
    }
    
    func setupProfileUI()
    {
        let img = self.userInfo.profile
        self.profileImage.image      = img
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center     = CGPoint(x:self.view.frame.width / 2, y : 270)
        
        self.profileImage.layer.cornerRadius  = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth   = 0
        self.profileImage.layer.masksToBounds = true
        guard let backgroundImg = UIImage(named:"profile-bg") else
        {
            return NSLog("backgroundImg nil in ProfileVC.swift setupProfileUI()")
        }
        let bgImageView                 = UIImageView(image: backgroundImg)
        bgImageView.frame.size          = CGSize(width:backgroundImg.size.width ,height: backgroundImg.size.height)
        bgImageView.center              = CGPoint(x:self.view.frame.width / 2, y : 40)
        bgImageView.layer.cornerRadius  = bgImageView.frame.size.width / 2
        bgImageView.layer.borderWidth   = 0
        bgImageView.layer.masksToBounds = true
        self.view.addSubview(profileImage)
        self.view.addSubview(bgImageView)
    }
    
    func drawBtn()
    {
        let v = UIView()
        v.frame.size.width  = self.view.frame.width
        v.frame.size.height = 40
        v.frame.origin.x    = 0
        v.frame.origin.y    = self.tableView.frame.origin.y + self.tableView.frame.height + 10
        v.backgroundColor   = UIColor(red:0.98,green:0.98,blue:0.98,alpha:1.0)
        self.view.addSubview(v)
        
        let btn        = UIButton(type: .system)
        btn.frame.size = CGSize(width: 100, height: 30)
        btn.center     = CGPoint(x: v.frame.size.width/2, y: v.frame.size.height/2)
        
        if self.userInfo.isLogin
        {
            btn.setTitle("로그아웃", for: .normal)
            btn.addTarget(self, action: #selector(doLogout(_:)), for: .touchUpInside)
        }
        else
        {
            btn.setTitle("로그인", for: .normal)
            btn.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
        v.addSubview(btn)
    }
    //MARK: - event Handler
    @objc func close(_ sender: Any)
    {
        self.presentingViewController?.dismiss(animated: true)
    }
    @objc func new(_ sender: Any)
    {
        self.performSegue(withIdentifier: "editingProfile", sender: sender)
        
    }
    @objc func doLogin(_ sender: Any)
    {
        if self.isCalling
        {
            self.alertMainThread("응답 기다리는 중입니다.\n잠시만 기다려주세요")
            return
        }
        else
        {
            self.isCalling = true
        }
        self.indicatorView.startAnimating()
        let alertVO = customAlertVO(title: "LOGIN", message: nil, style: .alert)
        alertVO.alert.addTextField()
        {
            $0.placeholder = "Your Account : )"
        }
        alertVO.alert.addTextField()
        {
            $0.placeholder = "Password"
        }
        alertVO.addBtn(title: "cancel", style: .cancel){ _ in
            self.isCalling = false
        }
        alertVO.addBtn(title:"OK",style:.destructive)
        {
            (_) in
            let account  = alertVO.alert.textFields?[0].text ?? ""
            let password = alertVO.alert.textFields?[1].text ?? ""
            
            self.userInfo.login(account, password, success: {
                self.indicatorView.stopAnimating();
                self.isCalling = false;
                self.tableView.reloadData();
                self.profileImage.image = self.userInfo.profile;
                self.drawBtn()
                
            }){ msg in
                self.indicatorView.stopAnimating()
                self.isCalling = false
                self.alertMainThread(msg)
            }
            
        }
        present(alertVO.alert,animated: true)
        
    }
    @objc func doLogout(_ sender: Any)
    {
        let alertVO = customAlertVO(title: nil, message: "로그아웃하시겠습니까?", style: .alert)
        alertVO.addBtn(title: "cancel", style: .cancel, completion: nil)
        alertVO.addBtn(title: "OK",style: .destructive){ _ in
            self.indicatorView.startAnimating()
            //와..비동기 잘만드네,,클로저로.. 아직 난. 짬이 안되나봄.
            self.userInfo.logout()
            {
                self.indicatorView.stopAnimating()
                self.tableView.reloadData()
                self.profileImage.image = self.userInfo.profile
                self.drawBtn()
            }
        }
        self.present(alertVO.alert,animated:false)
    }

}

