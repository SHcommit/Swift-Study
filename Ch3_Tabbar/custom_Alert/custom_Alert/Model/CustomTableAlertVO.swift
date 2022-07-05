//
//  CustomAlert.swift
//  custom_Alert
//
//  Created by 양승현 on 2022/07/04.
//

import UIKit

/**
 * TODO :
 *  테이블 목록을 보여주는 알림창 customize
 */
class CustomTableAlertVO
{
    var tableAlert : callAlertButtonVO
    init()
    {
        tableAlert = callAlertButtonVO()
    }
}

extension CustomTableAlertVO
{
    //about tableView in tableViewAlert
    class ListView : UITableViewController
    {
        override func viewDidLoad() {
            super.viewDidLoad()
            self.preferredContentSize.height = 220
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell()
            cell.textLabel!.text = "\(indexPath.row) 번째 옵션 보이나용~~?"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            
            return cell
        }
    }
}



//MARK: - setAlertObject
extension CustomTableAlertVO
{
    func addTableAlert(_ title : String?, message : String?, _ preferredStyle : UIAlertController.Style)
    {
        tableAlert.alert = tableAlert.defaultAlert(title, message, preferredStyle)
    }
}

//MARK: - setAlertUI
extension CustomTableAlertVO
{
    //커스텀 테이블 알람 근데 여기서 화면전환 까지는 안해도 될듯,,
    func customTableAlertUI(_ alert : inout UIAlertController)
    {
        var centerVC = UIViewController()
        centerVC     = ListView()
        centerVC.preferredContentSize.height = 220
        alert.setValue(centerVC, forKey: "contentViewController")
    }
}

