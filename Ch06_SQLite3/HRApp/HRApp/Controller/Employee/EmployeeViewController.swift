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
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }    
}
extension EmployeeViewController
{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell
    {
        return UITableViewCell()
    }
}
