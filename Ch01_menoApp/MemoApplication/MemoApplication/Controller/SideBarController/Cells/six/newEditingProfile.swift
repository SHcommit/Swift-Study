import UIKit

class newEditingProfile : UIViewController
{
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func submit(_ Sender: Any?){
        
    }
    
    //tableView
    var fieldAccount: UITextField!
    var fieldPassword: UITextField!
    var fieldName: UITextField!
    
    override func viewDidLoad() {
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        
        setupProfileUI()
        addProfileGesture()
    }
    func addProfileGesture()
    {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedProfile(_:)))
        self.profile.addGestureRecognizer(gesture)
    }
    func setupProfileUI()
    {
        self.profile.layer.cornerRadius  = self.profile.frame.width/2
        self.profile.layer.masksToBounds = true
    }
}
extension newEditingProfile : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tv: UITableView, numberOfRowsInSection section : Int)->Int
    {
        return 3
    }
    func tableView(_ tv : UITableView, cellForRowAt indexPath : IndexPath)-> UITableViewCell
    {
        var cell = tv.dequeueReusableCell(withIdentifier: "newProfileCell") ?? UITableViewCell(style: .default, reuseIdentifier: "newProfileCell")

        let tfFrame = CGRect(x: 20, y: 0, width: cell.bounds.width-20, height: 37)
        switch indexPath.row
        {
        case 0:
            drawFieldAccount(frame: tfFrame, cell: &cell)
        case 1:
            drawFieldPassword(frame: tfFrame, cell: &cell)
        case 2:
            drawFieldName(frame: tfFrame, cell: &cell)
        default:
            ()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func drawFieldAccount(frame: CGRect, cell: inout UITableViewCell)
    {
        self.fieldAccount = UITextField(frame: frame)
        self.fieldAccount.placeholder = "계정(이메일)"
        self.fieldAccount.borderStyle = .none
        self.fieldAccount.autocapitalizationType = .none
        self.fieldAccount.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(self.fieldAccount)
    }
    func drawFieldPassword(frame: CGRect, cell: inout UITableViewCell)
    {
        self.fieldPassword = UITextField(frame: frame)
        self.fieldPassword.placeholder = "비밀번호"
        self.fieldPassword.borderStyle = .none
        self.fieldPassword.isSecureTextEntry = true
        self.fieldPassword.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(self.fieldPassword)
    }
    func drawFieldName(frame: CGRect, cell: inout UITableViewCell)
    {
        self.fieldName = UITextField(frame: frame)
        self.fieldName.placeholder = "이름"
        self.fieldName.font = UIFont.systemFont(ofSize: 14)
        cell.addSubview(self.fieldName)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let rawValue = UIImagePickerController.InfoKey.originalImage.rawValue
        if let img = info[UIImagePickerController.InfoKey(rawValue: rawValue)] as? UIImage{
            self.profile.image = img
        }
        self.dismiss(animated: true)
    }
}

extension newEditingProfile : UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    @objc func tappedProfile(_ sender: Any)
    {
        func selectLibrary(src: UIImagePickerController.SourceType)
        {
            if UIImagePickerController.isSourceTypeAvailable(src)
            {
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = src
                self.present(picker,animated:true)
            }else{
                self.alertMainThread("사용할 수 없는 타입입니다.")
            }
        }
        
        let msg = "프로필 이미지 읽어올 곳 선택하세요."
        let sheetVO = customAlertVO(title: msg, message: nil, style: .actionSheet)
        sheetVO.addBtn(title: "취소", style: .cancel)
        sheetVO.addBtn(title: "지정된 엘범", style: .default){ (_) in
            selectLibrary(src: .savedPhotosAlbum)
        }
        sheetVO.addBtn(title: "포토 라이브러리", style: .default){ (_) in
            selectLibrary(src: .photoLibrary)
        }
        sheetVO.addBtn(title: "카메라", style: .default) { (_) in
            selectLibrary(src: .camera)
        }
        self.present(sheetVO.alert, animated: true)
    }
}
