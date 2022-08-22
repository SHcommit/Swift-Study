import UIKit
//employee 네비관련 setup UI
extension EmployeeViewController
{
    func initUI()
    {
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        title.numberOfLines = 1
        title.text = "사원 목록"
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize:14)
        
        self.navigationItem.titleView = title
        
        setupNaviLeftBtn()
        setupNaviRightBtn()
    }
    func setupNaviLeftBtn()
    {
        naviBtnVO.setupEditBtn(self, #selector(edit(_:)))
        self.navigationItem.leftBarButtonItem = naviBtnVO.EditBtn
    }
    func setupNaviRightBtn()
    {
        naviBtnVO.setupAddBtn(self, #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = naviBtnVO.AddBtn
    }
    @objc func edit(_ sender : Any?)
    {
        if self.isEditing
        {
            self.setEditing(false, animated: true)
            return
        }
        self.setEditing(true, animated: true)
    }
    @objc func add(_ sender: Any?)
    {
        let vc        = self.storyboard?.instantiateViewController(withIdentifier: "departScene") as? DepartmentViewController
        let departDAO = vc?.departDAO
        guard let _departDAO = departDAO else
        {
            NSLog("vc's departDAO instance nil")
            return
        }
        let departList = _departDAO.find()
        let alert      = CustomAlert()
        
        alert.setupAlert("사원 등록", "등록할 사원 정보를 입력해 주세요", .alert)
        alert.setupBtn("취소", .cancel, .left)
        {
            (_) in
            
        }
        alert.setupBtn("확인", .default, .right)
        {
            (_) in
        }
        alert.addPickerView(list:departList)
        alert.alert.addTextField() {$0.placeholder = "사원명"}
        
        self.present(alert.alert, animated: true)

    }
}
