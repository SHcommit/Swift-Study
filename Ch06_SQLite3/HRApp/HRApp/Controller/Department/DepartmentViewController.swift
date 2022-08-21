import UIKit
/**
 TODO : 부서관리, + 키와 -키로 부서 추가 삭제 가능하다.
 
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. 앗ㅋㅋㅋ list edit모드 버튼 직접 구현했는데 원래 left바버튼아이템 = self.editButtonItem으로하면 편집기능을 지원한다..
 
 */
class DepartmentViewController : UITableViewController
{
    //var arr        = ["1","2","3","4"]
    var departList : [DepartRecord]!
    let departDAO  = DepartmentDAO()
    var naviBtnVO  = NaviBtnVO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //db에서 정보 가져온다.
        self.departList = self.departDAO.find()
        initUI()
    }
    
    //MARK: - tableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return self.departList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
    {
        let cell             = tableView.dequeueReusableCell(withIdentifier:"departCell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "departCell")
        cell.accessoryType   = .disclosureIndicator
        cell.textLabel?.text = self.departList[indexPath.row].departTitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = self.departList[indexPath.row].departAddr
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView.isEditing else
        {
            return
        }
        //에디팅일때
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let departCd = self.departList[indexPath.row].departCd
            if departDAO.remove(cd: departCd)
            {
                departList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    //MARK: - setupUI
    func initUI()
    {
        let navTitle = UILabel(frame:CGRect(x: 0, y: 0, width: 200, height: 60))
        navTitle.numberOfLines = 2
        navTitle.textAlignment = .center
        navTitle.font = UIFont.systemFont(ofSize: 14)
        navTitle.text = "부서 목록 \n" + " 총 \(self.departList?.count ?? 0) 개"
        
        self.navigationItem.titleView = navTitle
        
        naviBtnVO.setupEditBtn(self, #selector(editDepartInfo(_:)))
        self.navigationItem.leftBarButtonItem = naviBtnVO.EditBtn
        naviBtnVO.setupAddBtn(self, #selector(addDepartInfo(_:)))
        self.navigationItem.rightBarButtonItem = naviBtnVO.AddBtn
        
        //셀 스와이프 시 편집모드
        self.tableView.allowsSelectionDuringEditing = true
    }
}

//MARK: - EventHandler
extension DepartmentViewController
{
    @objc func editDepartInfo(_ sender: Any?)
    {
        guard self.tableView.isEditing else
        {
            self.tableView.setEditing(true, animated: true)
            return
        }
        self.tableView.setEditing(false, animated: true)
    }
    @objc func addDepartInfo(_ sender: Any?)
    {
        var alert = CustomAlert()
        alert.setupAlert("신규 부서 등록", "신규 부서를 등록해주세요", .alert)
        alert.alert?.addTextField() { $0.placeholder = "부서명" }
        alert.alert?.addTextField() { $0.placeholder = "주소" }
        
        alert.setupBtn("취소", .cancel,.left, nil)
        alert.setupBtn("확인", .default,.right)
        {
            _ in
            
            guard let title = alert.alert.textFields?[0].text , let addr = alert.alert.textFields?[1].text else
            {
                NSLog("사용자의 입력 잘못됨")
                return
            }
            
            if self.departDAO.create(title: title, addr: addr)
            {
                self.departList = self.departDAO.find()
                self.tableView.reloadData()
                
                let navTitle = self.navigationItem.titleView as? UILabel
                guard let _navTitle = navTitle else
                {
                    NSLog("네비타이틀 캐스팅 안됨")
                    return
                }
                _navTitle.text = "부서 목록\n" + "총 \(self.departList.count) 개"
            }
            self.tableView.reloadData()
        }
        self.present(alert.alert, animated: true )
    }
}
