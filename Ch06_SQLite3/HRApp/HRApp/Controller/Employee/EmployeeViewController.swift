import UIKit

class EmployeeViewController : UITableViewController
{
    var empList   : [EmployeeVO]!
    var empDAO    = EmployeeDAO()
    var naviBtnVO = NaviBtnVO()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.empList = self.empDAO.find()
        initUI()
        let tf        = "alert.alert.textFields?[0]"
        var datas      = EmployeeVO()
        datas.departCd = 0
        datas.empName  = "Ss"
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        datas.joinDate = df.string(from: Date())
        datas.stateCd  = EmpStateType.ING
        empList.append(datas)
        //self.tableView.allowsSelectionDuringEditing = true
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.empList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell
    {
        let data = self.empList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "emp_Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "emp_Cell")
        cell.accessoryType         = .disclosureIndicator
        cell.textLabel?.text       = data.empName + "\(data.stateCd.desc())"
        cell.textLabel?.font       = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.text = data.departTitle
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        let empCd = empList[indexPath.row].departCd
        if editingStyle == .delete && empDAO.remove(cd: empCd)
        {
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
}
