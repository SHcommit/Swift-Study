import UIKit
/**
 TODO : 부서관리, + 키와 -키로 부서 추가 삭제 가능하다.
 
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class DepartmentViewController : UITableViewController
{
    var arr = ["1","2","3","4"]
    var naviBtnVO = NaviBtnVO()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviBtnVO.setupEditBtn(self, #selector(editDepartInfo(_:)))
        self.navigationItem.leftBarButtonItem = naviBtnVO.EditBtn
        naviBtnVO.setupAddBtn(self, #selector(addDepartInfo(_:)))
        self.navigationItem.rightBarButtonItem = naviBtnVO.AddBtn
    }
    
    //MARK: - tableViewDelegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return arr.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier:"departCell") ?? UITableViewCell(style: .default, reuseIdentifier: "departCell")
        cell.textLabel?.text = arr[indexPath.row]
        //cell.detailTextLabel?.text // aanj2
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
            arr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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
        alert.alert?.addTextField()
        alert.alert?.addTextField()
        alert.alert?.textFields?[0].placeholder = "부서명"
        alert.alert?.textFields?[1].placeholder = "주소"
        alert.setupBtn("취소", .cancel,.left, nil)
        alert.setupBtn("확인", .default,.right)
        {
            _ in
            //여기에 이제 부소를 거기따주는거지 디비에따가
            self.arr.append((alert.alert?.textFields?[0].text)! )
            self.tableView.reloadData()
        }
        self.present(alert.alert, animated: true )
    }
}
