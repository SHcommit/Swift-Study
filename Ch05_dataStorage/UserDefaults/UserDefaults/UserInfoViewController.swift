/*
 Date : 22.08.04
 Note
    1. 스토리보드에서 네비게이션 컨트롤러의 ID를 인스턴스로하는 객체를 생성하고 title과 오른쪽에 버튼을
    달아주었는데 왜 화면에선 안 보일까?..
    --해결--
    self로 navigationItem에서 정의하면 됬다. 근데 왜 위와같은 방식은 안됬던 것일까?..
 Date : 22.08.04
    2. alert에서 center영역에 UIView가 아닌 UIViewController를 적용시켜야 하는 이유는 뭘까.
 Date : 22.08.04
    3. 돌발상황 tf 수정후 label값이 계속 변했는데 갑자기 변하지 않음..
    그 이유는 내가 alert의 textField를 매번 만들면서 contents에 addSubview에 추가를 했다. 이유는 contents의 subview인 tf의 인스턴스 쉽게 얻을려고
    근데 처음은 label변경이 되는 데 두번째부터 계속 같은 값을 label(name)에 대입을 했는데 그 이유가 subview가 계속해서 추가되기 때문이었다.
    그래서 그냥 alert호출 될 때마다 contents를 초기화 해줬다.
 */
import UIKit

class UserInfoViewController : UITableViewController
{
    //MARK: - @IB variables
    @IBOutlet var name   : UILabel!
    @IBOutlet var gender : UISegmentedControl!
    @IBOutlet var married: UISwitch!
    var contents : UIViewController?
    
    // tap Gesture Recognizer's IBAction func
//    @IBAction func edit(_ sender: UITapGestureRecognizer) {
//        let alert             = UIAlertController(title:"input user's name :)", message: nil, preferredStyle: .alert)
//
//        let tf                = UITextField()
//        tf.frame              = CGRect(x: 0, y: 0, width: alert.view.frame.width / 2, height: 30)
//        tf.text               = self.name.text
//        tf.textAlignment      = .center
//        tf.backgroundColor    = .white
//        tf.layer.cornerRadius = 3
//        tf.layer.borderColor  = UIColor.lightGray.cgColor
//        tf.layer.borderWidth  = 0.3
//        contents.view.addSubview(tf)
//        contents.preferredContentSize = CGSize(width: tf.frame.width, height: tf.frame.height)
//        alert.view.addSubview(contents.view)
//        alert.setValue(contents, forKey: "contentViewController")
//        alert.addAction(
//            UIAlertAction(title: "OK", style: .default)
//            { (_) in
//                guard let tf = self.contents.view.subviews[0] as? UITextField else
//                {
//                    return NSLog("contents's subview tf nil in UserInfoViewController.swift")
//                }
//                self.name.text = tf.text
//                let pList      = UserDefaults.standard
//                pList.setValue(tf.text,forKey: "userName")
//
//                pList.synchronize()
//        })
//        self.present(alert,animated: true)
//    }
    @IBAction func changeGender(_ sender: UISegmentedControl)
    {
        let pList = UserDefaults.standard
        let value = sender.selectedSegmentIndex
        switch value
        {
        case 0:
            pList.set(value,forKey:"userGender")
            break;
        case 1:
            pList.set(value,forKey:"userGender")
            break;
        default:
            break;
        }
        pList.synchronize()
    }
    @IBAction func changeMarried(_ sender: UISwitch)
    {
        let pList = UserDefaults.standard
        let value = sender.isOn
        switch value
        {
        case true:
            pList.set(value,forKey:"userMarried")
            break;
        case false:
            pList.set(value,forKey: "userMarried")
            break;
        default:
            break;
        }
        pList.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        let pList = UserDefaults.standard
        self.name.text = pList.string(forKey: "userName")
        self.married.isOn = pList.bool(forKey: "userMarried")
        self.gender.selectedSegmentIndex = pList.integer(forKey: "userGender")
    }
    override func viewWillAppear(_ animated: Bool) {
        let pList = UserDefaults.standard
        self.name.text = pList.string(forKey: "userName")
        self.married.isOn = pList.bool(forKey: "userMarried")
        self.gender.selectedSegmentIndex = pList.integer(forKey: "userGender")
    }
    //MARK: - event Handler
    @objc func save(_ sender : Any)
    {
        
    }
    
    //MARK: - setup contents
    func setupNavigationBar()
    {
        
        let rightBtn = UIBarButtonItem(title:"저장",style:.plain,target: self,action:#selector(save(_:)))
        self.navigationItem.title = "사용자 정보"
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath)
    {
        switch indexPath.row
        {
        case 0:
            let alert = UIAlertController(title:"input user's name :)", message: nil, preferredStyle: .alert)
            contents = UIViewController()
            guard let centerVC = contents else
            {
                return NSLog("contents instance is nil in UserInfoViewController.swift")
            }
//            let tf           = UITextField()
//            tf.frame         = CGRect(x: 0, y: 0, width: alert.view.frame.width / 2, height: 30)
//            tf.text          = self.name.text
//            tf.textAlignment = .center
//            tf.backgroundColor    = .white
//            tf.layer.cornerRadius = 3
//            tf.layer.borderColor  = UIColor.lightGray.cgColor
//            tf.layer.borderWidth  = 0.3
//            centerVC.view.addSubview(tf)
//            centerVC.preferredContentSize = CGSize(width: tf.frame.width, height: tf.frame.height)
//            alert.view.addSubview(centerVC.view)
            
//            alert.setValue(centerVC, forKey: "contentViewController")
            let centerView = UIView()
            let tf = UITextField()
            tf.frame = CGRect(x:0,y:0,width:alert.view.frame.width/2,height:30)
           
            tf.text          = self.name.text
            centerView.addSubview(tf)
            centerView.leftAnchor.constraint(equalTo: alert.view.leftAnchor).isActive = true
            centerView.rightAnchor.constraint(equalTo: alert.view.rightAnchor).isActive = true
            centerView.heightAnchor.constraint(equalTo: alert.view.heightAnchor).isActive = true
            
            centerView.bottomAnchor.constraint(equalTo:alert.view.bottomAnchor).isActive = true
            NSLayoutConstraint.activate(
                [
                    centerView.leftAnchor.constraint(equalTo: alert.view.leftAnchor),
                    centerView.rightAnchor.constraint(equalTo: alert.view.rightAnchor),
                    centerView.heightAnchor.constraint(equalTo: alert.view.heightAnchor),
                    
                    centerView.bottomAnchor.constraint(equalTo:alert.view.bottomAnchor)])
            
            
            
            alert.view.addSubview(centerView)
            alert.addAction(
                UIAlertAction(title: "OK", style: .default)
                { (_) in
                    guard let tf = self.contents?.view.subviews[0] as? UITextField else
                    {
                        return NSLog("contents's subview tf nil in UserInfoViewController.swift")
                    }
                    self.name.text = tf.text
                    let pList      = UserDefaults.standard
                    pList.setValue(tf.text,forKey: "userName")
                    pList.synchronize()
            })
            self.present(alert,animated: true)
            break;
        case 1:
            break;
        default:
            break;
        }
    }
}


