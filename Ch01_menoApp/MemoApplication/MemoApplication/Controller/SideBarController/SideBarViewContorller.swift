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
 1. Date : 22.07.30
    지금 sideBar의 tableView의 첫번째 cell의 터치시 FrontVC의 navigation에 barButtonItem을 통해 memoFormVC를 불러와야 한다.
    ----해결----
    FrontVC의 인스턴스는 RevealVC로 다룰 수있기에 해당 인스턴스를 얻어온 후에 FrontVC의 segue로 연결된 UINavigationController로 캐스팅 후 성공적으로 memoFormVC를 얻어왔다.
    ----문제----
    근데 지금 SideVC가 닫히지 않고  FrontVC의 자리에서 memoForm만 호출된다.. ㅋㅋ 여전히 sideVC는 남아있다.
 
 */
class SideBarViewController : UITableViewController
{
    let list    = SideBarListDTO()
    var profile = SideBarProfileVO()
    var revealVC : RevealViewController?
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
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath)
    {
        switch indexPath.row
        {
        case 0:
            guard let memoFormVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm") else
            {
                NSLog("memoFormVC instance nil")
                return
            }
            let target = revealVC?.frontVC as! UINavigationController
            revealVC?.closeSideBar
            {
                target.pushViewController(memoFormVC, animated: true)
            }
            break;
        default:
            break;
        }
    }

    
    func tableHeaderSetup()
    {
        profile.headerViewSetup(self.tableView)
        profile.nameLabelSetup( "ios새싹 승현이")
        profile.emailLabelSetup( "happysh_s2@naver.com")
        profile.profileImageSetup( "account.jpg")
    }
}

