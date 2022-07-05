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
    var tableButton : UIButton
    var tableAlert  : UIAlertController
    init()
    {
        tableButton = UIButton()
        tableAlert  = UIAlertController()

    }
    
    func addButtonObject(_ view : inout UIView, _ button : inout UIButton, _ buttonName : String, _ index : Int)
    {
        button.frame    = CGRect(x: 0, y: 100, width: 100, height: 30)
        button.setTitle(buttonName, for: .normal)
        button.center.x = view.frame.width / 2
        button.center.y = view.frame.height / 5 * CGFloat(index)
        button.layer.cornerRadius = 3
        button.layer.backgroundColor = UIColor.brown.cgColor
        
        view.addSubview(button)
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
    func addTableAlert(_ button : inout UIButton, _ title : String?, message : String?, _ preferredStyle : UIAlertController.Style)
    {
        tableAlert = defaultAlert(title, message, preferredStyle)
    }
}

//MARK: - setAlertUI
extension CustomTableAlertVO
{
    //초기 디폴트 알람
    func defaultAlert(_ title : String?, _ message : String?, _ preferredStyle : UIAlertController.Style ) -> UIAlertController
    {
        let alert = UIAlertController(title: title ?? nil, message: message ?? nil, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        alert.addAction(UIAlertAction(title: "Cancel", style:.cancel))
        
        return alert
    }
    
    //커스텀 테이블 알람 근데 여기서 화면전환 까지는 안해도 될듯,,
    func customTableAlertUI(_ alert : inout UIAlertController)
    {
        var centerVC = UIViewController()
        centerVC     = ListView()
        centerVC.preferredContentSize.height = 220
        alert.setValue(centerVC, forKey: "contentViewController")
    }
}

