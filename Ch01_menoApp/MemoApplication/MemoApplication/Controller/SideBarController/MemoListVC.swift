import UIKit

/**
 TODO : First Scene View Controller
 

 # Notes: #
 1. 테이블 뷰 생성 ( AppDelegate에서 list.count 만큼 가져옴 )
 2. cellForRowAt로 Cell에 데이터 삽입
 3. didSelectRowAt로 특정 cell 클릭 시 pushView로 화면 전환 -> Detail show
 
 */
class MemoListVC: UITableViewController {
    var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated : Bool){
        self.tableView.reloadData()
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
    

}
