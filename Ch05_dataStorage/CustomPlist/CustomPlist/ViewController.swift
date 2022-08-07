import UIKit

class ViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var accountList = [
    "A@naver.com",
    "B@naver.com",
    "C@gmail.com",
    "D@gmail.com"
    ]
    @IBOutlet weak var account: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let picker = UIPickerView()
        picker.delegate = self

        self.account.inputView = picker
        setToolBar()
    }
    
    //MARK: - PickerViewDelegate
    
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
        let list = self.accountList[row]
        self.account.text = list
    }
    
    func setToolBar()
    {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x:0,y:0,width:0,height:34)
        toolbar.barTintColor = .lightGray
        self.account.inputAccessoryView = toolbar
        
        let done = UIBarButtonItem()
        let space = UIBarButtonItem(systemItem: .flexibleSpace)
        
        done.title  = "Done"
        done.target = self
        done.action = #selector(pickerDone(_:))
        
        let new = UIBarButtonItem()
        new.title = "New"
        new.target = self
        new.action = #selector(newAccount(_:))
        
        toolbar.setItems([new,space,done], animated: true)
        
    }
    @objc func pickerDone(_ sender: Any)
    {
        self.view.endEditing(true)
    }
    @objc func newAccount(_ sender: Any)
    {
        let alert = UIAlertController(title:nil,message:"새 계정을 입력하세요",preferredStyle: .alert)
        let center = UIViewController()
        let tf     = UITextField()
        tf.frame   = CGRect(x: 0, y: 0, width: alert.view.frame.width/2 + 10, height: 30)
        tf.placeholder =  "ex) abc@gmail.com"
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 3
        tf.layer.borderWidth = 0.3
        tf.layer.borderColor = UIColor.lightGray.cgColor
        center.view.addSubview(tf)
        center.preferredContentSize = CGSize(width: tf.frame.width, height: tf.frame.height)
        alert.view.addSubview(center.view)
        alert.setValue(center,forKey:"contentViewController")
        alert.addAction(UIAlertAction(title: "OK", style: .default)
                        {
            (_) in
            self.accountList.append(tf.text!)
            self.account.text = tf.text
            self.account.endEditing(true)
        })
        present(alert, animated: true)
    }
}

