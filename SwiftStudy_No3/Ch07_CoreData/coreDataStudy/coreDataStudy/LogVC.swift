import UIKit
public enum LogType : Int16
{
    case create = 0
    case edit   = 1
    case delete = 2
}
extension Int16
{
    func toLogType() -> String
    {
        switch self
        {
        case 0: return "생성"
        case 1: return "수정"
        case 2: return "삭제"
        default : return ""
        }
    }
}
class LogVC : UITableViewController
{
    var board: BoardMO!
    lazy var list : [LogMO]! =
    {
        return self.board.logs?.array as! [LogMO]
    }()
    override func viewDidLoad() {
        self.navigationItem.title = self.board.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "logcell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "logcell")
        cell.textLabel?.text = "\(data.regdate!)에 \(data.type.toLogType())되었습니다."
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return cell
    }
}
