import UIKit

/**
 TODO : First Scene View Controller
 

 # Notes: #
 1. 테이블 뷰 생성 ( AppDelegate에서 list.count 만큼 가져옴 )
 2. cellForRowAt로 Cell에 데이터 삽입
 3. didSelectRowAt로 특정 cell 클릭 시 pushView로 화면 전환 -> Detail show
 
 4. Date : 22.08.26
    컨텍스트를 통해 메모장 delete 기능 추가
    스와이프 delete 기능 추가
 */
class MemoListVC: UITableViewController ,UISearchBarDelegate{
    //MARK: - property
    var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    var sideBarDelegate : RevealViewController?
    lazy var dao = MemoDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.enablesReturnKeyAutomatically = false
        let btnSideBar = UIBarButtonItem(image:UIImage(named:"sidemenu.png"),style:UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        self.navigationItem.leftBarButtonItem = btnSideBar
        openSideBarByGuesturing()
        
    }
    override func viewWillAppear(_ animated : Bool){
        self.appDelegate.memoList = self.dao.fetch()
        self.tableView.reloadData()
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

    // MARK: - Table view data source

    /**
     * 테이블 뷰 cell 몇개로 할건지?
     * TODO : AppDelegate의 멤버변수 가져와서 count 반환
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return appDelegate.memoList.count
    }

    /**
     * 테이블 셀 레이블에 데이터 지정
     * TODO :
     *  1. 재사용 큐에서 특정 cell 인스턴스 가져옴
     *  2. AppDelelgate에 있는 memoList에서 데이터를 cell의 레이블에 삽입
     *  3. 데이터 받은 cell 반환
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let rowData = self.appDelegate.memoList[indexPath.row]
        let cellId  = rowData.image == nil ? "memoCell" : "memoCellWithImage"
        let cell    = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        cell.subject?.text  = rowData.title
        cell.contents?.text = rowData.contents
        cell.img?.image     = rowData.image
        
        let formatter       = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text  = formatter.string(from: rowData.regdate!)
        return cell
    }

    /**
     * 특정 Cell 터치 이벤트 발생하면
     * 스토리보드에서 해당 interfaceBuilder를 찾아서 객체화 한다.
     * 그리고 해당 VC의 프로퍼티한테 값 지정해준다~
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowData = (UIApplication.shared.delegate as! AppDelegate).memoList[indexPath.row]
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else{
            return
        }
        vc.data = rowData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tv : UITableView, editingStyleForRowAt indexPath : IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    override func tableView(_ tv: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath : IndexPath)
    {
        let data = self.appDelegate.memoList[indexPath.row]
        guard let _objID = data.objectID else {NSLog("data.objID nil in MemoListVC's tableView(_:commit:forRowAt:)"); return}
        if dao.delete(_objID)
        {
            self.appDelegate.memoList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //MARK: - PANNING, SWIPE GESTURE
    func openSideBarByGuesturing()
    {
        let dragLeft = UIScreenEdgePanGestureRecognizer(target:self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left
        self.view.addGestureRecognizer(dragLeft)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
    }
    
    //MARK: - SearchBar Event Handler
    
    /**
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
    
}
