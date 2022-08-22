import UIKit
//employee 네비관련 setup UI
/*
 Date 22.08.23
    후...지금 계속 alert로 사원 정보 추가했는데도 table Cell reloadData가 안된다.
    계속해봤더니 문제는 empDAO.find가 반영이 되지 않는다.
    create함수를 통해 데이터를 db에추가했는데 empList가반영이되지않는다.....ㅠㅠㅠㅠ
 */
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
        alert.addPickerView(list:departList)
        alert.alert.addTextField() {$0.placeholder = "사원명"}
        alert.setupBtn("취소", .cancel, .left)
        {
            (_) in
            
        }
        alert.setupBtn("확인", .default, .right)
        {
            (_) in
            let tf        = alert.alert.textFields?[0]
            var datas      = EmployeeVO()
            datas.departCd = alert.selected ?? 0
            datas.empName  = (tf?.text)!
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            datas.joinDate = df.string(from: Date())
            datas.stateCd  = EmpStateType.ING
            self.empList.append(datas)
            
            if self.empDAO.create(param: datas)
            {
                //self.empList = self.empDAO.find()
//                self.tableView.reloadData()

                if let navTitle = self.navigationItem.titleView as? UILabel
                {
                    navTitle.text = "사원 목록 \n" + " 총 \(self.empList.count) 명"
                }
            }
            self.tableView.reloadData()
        }
        
        self.present(alert.alert, animated: true)

    }
}
