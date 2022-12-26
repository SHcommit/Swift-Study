import UIKit

class MemoListVC: UIViewController ,UISearchBarDelegate{
    
    //MARK: - Property
    var listVM = MemoDataListViewModel()
    var sideBarDelegate : RevealViewController?
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        openSideBarByGuesturing()
        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.cellId)
    }
    
    override func viewWillAppear(_ animated : Bool){
        tableView.reloadData()
        tutorial()
    }
    
    
}

// MARK: - TableView data source
extension MemoListVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listVM.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listVM.getListViewModelData(index: indexPath.row)
        guard let cell    = tableView.dequeueReusableCell(withIdentifier: MemoCell.cellId) as? MemoCell else {
            fatalError("Failure cast cell as MemoCelll")
        }
        cell.initialProperties(data: data)
        cell.setupSubviewConstriants()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else{
            return
        }
        vc.data = listVM.getList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tv : UITableView, editingStyleForRowAt indexPath : IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tv: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath : IndexPath) {
        let data = listVM.peek(index: indexPath.row)
        guard let _objID = data.objectID else {
            NSLog("data.objID nil in MemoListVC's tableView(_:commit:forRowAt:)");
            return
        }
        listVM.removeListViewModelData(index: indexPath.row) { res in
            switch res {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
                break
            case .failure(_):
                print("Failure delete list data")
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    func tableView(_ tableView: UITableView, height section: Int) -> CGFloat {
        return 150
    }
    
    func setupTableViewDataSourceAndDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: - Setup subviews
extension MemoListVC {
    
    func setupSubviews() {
        let searchVC = UISearchController()
        let moreBtn = CSLogBtn(frame: .zero)
        
        initialSearchBar(searchVC: searchVC)
        initialNavigationBarLeftItem()
        initialNavigationBarRightItem()
        initialTableView()
        initialMoreBtn(more: moreBtn)
        
        setupTableViewConstraints()
        setupMoreBtnConstraints(more: moreBtn)
    }
    
    func initialSearchBar(searchVC: UISearchController) {
        searchVC.searchBar.enablesReturnKeyAutomatically = false
        navigationItem.searchController = searchVC
    }
    
    func initialTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        setupTableViewDataSourceAndDelegate()
        view.addSubview(tableView)
    }
    func initialMoreBtn(more btn: CSLogBtn) {
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setupButton()
        btn.setTitle("더보기", for: .normal)
    }
    
    func initialNavigationBarLeftItem() {
        let openSideBar = UIBarButtonItem(image:UIImage(named:"sidemenu.png"),style:UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        navigationItem.leftBarButtonItem = openSideBar
    }
    
    func initialNavigationBarRightItem() {
        let addMemoListBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openMemoForm(_:)))
        navigationItem.rightBarButtonItem = addMemoListBtn
    }
    
}

//MARK: - SetupSubviewConstriants
extension MemoListVC {

    func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func setupMoreBtnConstraints(more btn: CSLogBtn) {
        let content = UIView(frame: .zero)
        content.addSubview(btn)
        tableView.tableFooterView = content
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: content.topAnchor, constant: 8),
            btn.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            btn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)])
    }
    
}


//MARK: - SetupEventHandler
extension MemoListVC {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        let keyword = searchBar.text
        listVM.appDelegate.memoList = listVM.dao.fetch(keyword: keyword)
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
    
    @objc func moveSide(_ sender : Any) {
        
        if sender is UIBarButtonItem {
            if self.sideBarDelegate?.isSideBarShowing == false {
                self.sideBarDelegate?.openSideBar(nil)
            }
            else {
                self.sideBarDelegate?.closeSideBar(nil)
            }
        }else if sender is UIScreenEdgePanGestureRecognizer {
            self.sideBarDelegate?.openSideBar(nil)
        }else if sender is UISwipeGestureRecognizer {
            self.sideBarDelegate?.closeSideBar(nil)
        }
    }
    
    @objc func openMemoForm(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoForm") as? MemoFormVC else {
            print("Failure bind MemoFormVC instance")
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MemoListVC {
    func tutorial() {
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
