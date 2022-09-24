import UIKit

class MemoListVC: UITableViewController ,UISearchBarDelegate{
    //MARK: - property
    var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    var sideBarDelegate : RevealViewController?
    lazy var dao = MemoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        openSideBarByGuesturing()
    }
    override func viewWillAppear(_ animated : Bool){
        self.appDelegate.memoList = self.dao.fetch()
        self.tableView.reloadData()
        setupSubviews()
        let ud = UserDefaults.standard
        if ud.bool(forKey: UserInfoKeyDTO.tutorial) == false
        {
            guard let vc = self.instanceTutorialVC(name:"MasterVC") else
            {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc,animated: false)
            return
        }
    }
    
}

// MARK: - TableView data source
extension MemoListVC {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        return appDelegate.memoList.count
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let rowData = self.appDelegate.memoList[indexPath.row]
        let cell    = tableView.dequeueReusableCell(withIdentifier: MemoCell.cellId) ?? UITableViewCell(style: .default, reuseIdentifier: MemoCell.cellId)
        
        guard let customCell = cell as? MemoCell else {
            fatalError("Failure cast cell as MemoCelll")
        }
            
        customCell.setupSubviews(memoData: rowData)
//        cell.subject?.text  = rowData.title
//        cell.contents?.text = rowData.contents
//        cell.img?.image     = rowData.image
//
//        let formatter       = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        cell.regdate?.text  = formatter.string(from: rowData.regdate!)
        return customCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowData = (UIApplication.shared.delegate as! AppDelegate).memoList[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else{
            return
        }
        vc.data = rowData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tv : UITableView, editingStyleForRowAt indexPath : IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tv: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath : IndexPath) {
        let data = self.appDelegate.memoList[indexPath.row]
        guard let _objID = data.objectID else {
            NSLog("data.objID nil in MemoListVC's tableView(_:commit:forRowAt:)");
            return
        }
        if dao.delete(_objID) {
            self.appDelegate.memoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - setupSubviews
extension MemoListVC {
    
    func setupSubviews() {
        let searchBar = UISearchBar()
        initialSearchBar(searchBar: searchBar)
        setupSearchBarConstraints(searchBar: searchBar)
        setupNavigationBarLeftItem()
        
        
    }
    
    func initialSearchBar(searchBar: UISearchBar) {
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        var contentView = UIView()
        contentView.addSubview(searchBar)
        navigationItem.titleView = contentView
    }
    func setupSearchBarConstraints(searchBar: UISearchBar) {
        guard let titleView = navigationItem.titleView else {
            print("Failure bind titleView")
            return
        }
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: titleView.trailingAnchor)])
    }
    
    func setupNavigationBarLeftItem() {
        let btnSideBar = UIBarButtonItem(image:UIImage(named:"sidemenu.png"),style:UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        navigationItem.leftBarButtonItem = btnSideBar
    }
}


//MARK: - setupEventHandler
extension MemoListVC {
    
    /*
        특정 키워드에 맞는 entity 데이터를 tableview에 불러온다. (memoList 특정 NSPredicate 문자열로 갱신해서)
        
        이럴경우 문제는 이제 글자를 다 지우게 됬을때도 tableView는 특정 조건에 의해 cell이 구성된다.
        그렇다면 다시 다 지우고 검색버튼을 누르면 되지 않을까?
        검색 버튼을 강제로 활성화 시키면서 dao의 fetch에 다시 원래 memoList 를 불러올 수 있도록 추가 로직을 구현해야한다.
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let keyword = searchBar.text
        self.appDelegate.memoList = self.dao.fetch(keyword : keyword)
        self.tableView.reloadData()
    }
    
    // PANNING, SWIPE GESTURE
    func openSideBarByGuesturing()
    {
        let dragLeft = UIScreenEdgePanGestureRecognizer(target:self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
    }
}
