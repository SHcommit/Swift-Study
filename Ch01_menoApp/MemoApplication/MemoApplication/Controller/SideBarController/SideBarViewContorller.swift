//
//  SideBarViewContorller.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit

/**
 TODO : 사용자의 panning 제스쳐나 메뉴 클릭 시 SideVC의 view에 테이블 뷰가 호출되야함.
 
 - Param list : 사이드 바 목록
 - Param profile : 사이드 바에서 정의된 user's profile
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class SideBarViewController : UITableViewController
{
    let list    = SideBarListDTO()
    var profile = SideBarProfileVO()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableHeaderSetup()
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int
    {
        return list.titles.count
    }
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell
    {
        let id    = "SideBarMenuCell"
        let cell  = tableView.dequeueReusableCell(withIdentifier:"id") ?? UITableViewCell(style:.default,reuseIdentifier: id)
        let title = list.titles[indexPath.row]
        let icon  = list.icons[indexPath.row]
        
        cell.imageView?.image  = icon
        cell.textLabel?.text   = title
        cell.textLabel?.font   = UIFont.systemFont(ofSize:14)
        
        return cell
    }
    
    func tableHeaderSetup()
    {
        profile.headerViewSetup(self.tableView)
        profile.nameLabelSetup( "ios새싹 승현이")
        profile.emailLabelSetup( "happysh_s2@naver.com")
        profile.profileImageSetup( "account.jpg")
    }
}

