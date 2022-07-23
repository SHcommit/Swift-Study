//
//  SideBarViewContorller.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit
// 사용자의 panning이나 메뉴 클릭시 테이블 뷰가 호출되도록!!! 해야함
class SideBarViewController : UITableViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return 0
    }
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
    {
        let id = "SideBarMenuCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default ,reuseIdentifier: id)
        
        
        return cell
    }
    
    func tableHeaderUI()
    {
        let accountLabel   = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        
        let contentView   = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 90)
        contentView.backgroundColor = .brown
        contentView.addSubview(accountLabel)
        self.tableView.tableHeaderView = contentView
    }
}

