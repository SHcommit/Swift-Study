import UIKit
/*
 Date : 20.08.10
 오늘도 마주한 오류..ㅋㅋ 커스텀 plist나 UserDefaults.standard에 account 변수 type : UITextField를 저장할 때
 text를 저장해야한느데 텍스트 필드 인스턴스 자체를 저장해버려서 오류가 발생함. (Attempt to insert non-property list object < UITextField ...
 */
class ViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - IB variables
    var accountList :[String] = []
    let pL       = UserDefaults.standard
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var name   : UILabel!
    @IBOutlet weak var gender : UISegmentedControl!
    @IBOutlet weak var married: UISwitch!
    
    @IBAction func changeGender(_ sender: Any)
    {
        guard let sender = sender as? UISegmentedControl else
        {
            return NSLog("casting nil in changeGender(_:)")
        }
        let value = sender.selectedSegmentIndex
        //pList.set(value,forKey:"userGender")
        //pList.synchronize()
        
        let customPlist = "\(self.name.text).plist"
        let paths       = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)
        let path        = paths[0] as NSString
        let plist       = path.strings(byAppendingPaths: [customPlist]).first!
        let data        = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        data.setValue(value, forKey: "userGender")
        data.write(toFile: plist, atomically: true)
    }
    @IBAction func changeMarried(_ sender: Any) {
        guard let sender = sender as? UISwitch else {return}
        let value  = sender.isOn
        //pL.set(value,forKey:"userMarried")
        //pL.synchronize()
        let customPlistPath = "\(self.account.text!).plist"
        let paths           = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)
        let path            = paths[0] as NSString
        let plist           = path.strings(byAppendingPaths:[customPlistPath]).first!
        let data            = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
        data.setValue(value,forKey: "userMarried")
        data.write(toFile: plist,atomically: true)
        //경로 확인하기
        NSLog("custom plist=\(plist)")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addPickerViewInTextField()
        setToolBar()
        setupCellsValue()
        setupNavigationBarButton()
        let accountList = pL.array(forKey:"accountList") as? [String] ?? [String]()
        self.accountList = accountList
        if let account = pL.string(forKey:"selectedAccount")
        {
            setupUserInfo(account)
        }
        if (self.account.text?.isEmpty)!
        {
            self.account.placeholder = "등록된 계정이 없습니다."
            self.gender.isEnabled    = false
            self.married.isEnabled   = false
        }
    }
    func setupNavigationBarButton()
    {
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newAccount(_:)))
        self.navigationItem.rightBarButtonItems = [addBtn]
    }
    func setupUserInfo(_ account : String)
    {
        self.account.text = account
        let customPlist = "\(account).plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)
        let path  = paths[0] as NSString
        let clist = path.strings(byAppendingPaths:[customPlist]).first!
        //초기 커스텀 plist에서 데이터를가져올때는 Mutable을 할 필요가 없다.
        let data  = NSDictionary(contentsOfFile:clist)
        self.name.text = data?["userName"] as? String
        self.gender.selectedSegmentIndex = data?["userGender"] as? Int ?? 0
        self.married.isOn = data?["userMarried"] as? Bool ?? false
    }
    func addPickerViewInTextField()
    {
        let picker = UIPickerView()
        picker.delegate = self
        self.account.inputView = picker
    }
    func setupCellsValue()
    {
        self.name.text    = pL.string(forKey:"userName")
        self.married.isOn = pL.bool(forKey: "userMarried")
        self.gender.selectedSegmentIndex = pL.integer(forKey:"userGender")
    }
    func setToolBar()
    {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x:0,y:0,width:0,height:32)
        toolbar.barTintColor = .lightGray
        self.account.inputAccessoryView = toolbar
        
        let done  = UIBarButtonItem()
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        
        done.title  = "Done"
        done.target = self
        done.action = #selector(pickerDone(_:))
        
        let new     = UIBarButtonItem()
        new.title   = "New"
        new.target  = self
        new.action  = #selector(newAccount(_:))
        
        toolbar.setItems([new,space,done], animated: true)
        
    }
    //MARK: - eventHandler
    @objc func pickerDone(_ sender: Any)
    {

        if let _account = self.account.text
        {
            let customPlist = "\(_account).plist"
            let paths       = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true)
            let path        = paths[0] as NSString
            let cList       = path.strings(byAppendingPaths: [customPlist]).first!
            let data        = NSMutableDictionary(contentsOfFile: cList)
            
            self.name.text                   = data?["userName"] as? String ?? ""
            self.married.isOn                = data?["userMarried"] as? Bool ?? false
            self.gender.selectedSegmentIndex = data?["userGender"] as? Int ?? 0
        }
        self.view.endEditing(true)
    }
    @objc func newAccount(_ sender: Any)
    {
        let alert = UIAlertController(title:nil,message:"새 계정을 입력하세요",preferredStyle: .alert)
        let center = UIViewController()
        let tf     = UITextField()
        tf.frame   = CGRect(x: 0, y: 0, width: alert.view.frame.width/2 + 10, height: 30)
        tf.placeholder        =  "ex) abc@gmail.com"
        tf.backgroundColor    = .white
        tf.layer.cornerRadius = 3
        tf.layer.borderWidth  = 0.3
        tf.layer.borderColor  = UIColor.lightGray.cgColor
        center.view.addSubview(tf)
        center.preferredContentSize = CGSize(width: tf.frame.width, height: tf.frame.height)
        alert.view.addSubview(center.view)
        alert.setValue(center,forKey:"contentViewController")
        
        alert.addAction(UIAlertAction(title: "OK", style: .default)
                        {
            (_) in
            
            self.accountList.append(tf.text!)
            self.account.text = tf.text
            //계정 목록과 마지막으로 선택한 계정 정보를 저장한다
            self.pL.set(self.accountList,forKey:"accountList")
            self.pL.set(self.account.text,forKey: "selectedAccount")
            self.pL.synchronize()
            self.name.text    = ""
            self.married.isOn = false
            self.gender.selectedSegmentIndex = 0
        })
        present(alert,animated: true)
        self.gender.isEnabled  = true
        self.married.isEnabled  = true
    }
}

//MARK: - PickerViewDelegate
extension ViewController
{
    //피커뷰 몇개의 컴포넌트로 구성될건가?!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //몇개의 list로 구성될 것인가?
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component : Int)->Int
    {
        
        return accountList.count
    }
    //특정 피커뷰의 컴포넌트 주제는 String으로
    func pickerView(_ pickerView: UIPickerView, titleForRow row : Int, forComponent component : Int)-> String?
    {
        return accountList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row : Int, inComponent component : Int)
    {
        let list          = self.accountList[row]
        self.account.text = list
        pL.set(account.text,forKey:"selectedAccount")
        pL.synchronize()
    }
    
}

//MARK: - TableViewDelegate
extension ViewController
{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
        case 1:
            if !(self.account.text?.isEmpty)!
            {
                let alert = UIAlertController(title:nil,message:"이름 입력하세요.",preferredStyle: .alert)
                alert.addTextField()
                {
                    $0.text = self.name.text
                }
                alert.addAction(UIAlertAction(title:"OK",style:.default)
                                {
                    (_) in
                    let value       = alert.textFields?[0].text
                    //use custom pList
                    let customPList = "\(self.account.text!).plist"
                    let paths       = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                    let path        = paths[0] as NSString
                    let plist       = path.strings(byAppendingPaths: [customPList]).first!
                    let data        = NSMutableDictionary(contentsOfFile: plist) ?? NSMutableDictionary()
                    data.setValue(value, forKey: "userName")
                    data.write(toFile: plist, atomically: true)
                    
                    self.name.text  = value
                })
                present(alert,animated: true)
            }else
            {
                let alert = UIAlertController(title: nil, message: "계정 이메일부터 입력해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
            
            break;
        default:
            break;
        }
    }
}
