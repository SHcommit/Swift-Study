import UIKit

/**
 TODO : front에서 버튼 누르거나 옆으로 슬라이드 제스쳐 시 이 화면으로 넘어옴.
 
 - Param menuInfo : tableView Cell의 정보를 저장
 
 # Notes: #
 1. 재사용 큐를 사용해 id가 존재하지 않을 경우 새로 추가.
 1-1. dequeueReusableCell(withIdentifier:) 재사용 큐에 있는 id값이 존재하면 해당 cell을 꺼냄.
 1-2. 없을 경우 UITableViewCell(style:reuseIdentifier:)를 통해 id값 부여.
 1-3. 애초에 인스팩터 창에서 Id선언처럼 하려면
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id) 를 해야함.
 2. 이후의 cell은 재사용 큐에서 캐싱됨.
 
 4. 없을 경우
 
 */
class SideBarViewController : UITableViewController
{
    var menuInfo = MenuDTO()
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int)-> Int
    {
        return menuInfo.titles.count
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath)-> UITableViewCell
    {
        let id   = "menucell"
        var cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
//        if cell == nil
//        {
//            cell = UITableViewCell(style: .default, reuseIdentifier: id)
//        }
        
        cell.textLabel?.text  = self.menuInfo.titles[indexPath.row]
        cell.imageView?.image = self.menuInfo.icons[indexPath.row]
        
        cell.textLabel?.font  = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
}
