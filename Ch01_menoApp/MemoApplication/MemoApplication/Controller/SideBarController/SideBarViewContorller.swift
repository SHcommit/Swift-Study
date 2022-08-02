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
    근데 지금 SideVC가 닫히지 않고  FrontVC의 자리에서 memoForm만 호출된다.. ㅋㅋ 여전히 sideVC는 남아있다.-> 해결
 2. Date : 22.08.02
    스토리보드에서 profileVC와 rootviewController 로 navigationController가 있는데 profileVC의 storyboard 인스턴스를 얻었는데 화면 전환으로 해당 뷰를 호출 했을 때 rootView의 컨트롤러가 적용이 안된다.
    profileVC의 내용물은 보이는데 navigationController가 적용이 안되는 상황.
    ----해결----
    rootViewController(navigaitonController)는 독립적으로 뭔가 표시할 수없기에 profileVC를 루트뷰로 등록한것.
    따라서 rootViewController의 스토리보드id를 인스턴스로 생성한 후 호출하면 성공적으로 navigationController 까지 적용이 된다.
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
        case 5:
            
            guard let uv = self.storyboard?.instantiateViewController(withIdentifier:"_profile") else
            {
                return NSLog("_profile Scene can't find in SideBarViewController.swift")
            }
            //이걸 하지 않으면 일반적인 present시에 나타나는 화면 전환으로 됨 stack느낌으로 이전 view가 뒤에 존재함.
            uv.modalPresentationStyle = .fullScreen
            self.present(uv, animated: true)
            {
                self.revealVC?.closeSideBar(nil)
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

