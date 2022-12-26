import UIKit

struct SideBarModel {
    var title: String
    var icon: UIImage
}

struct SideBarViewModel {
    
    private let data: SideBarModel
    
    init(_ sideBarModel: SideBarModel) {
        data = sideBarModel
    }
    
    var title: String {
        get {
            return data.title
        }
    }
    
    var icon: UIImage {
        get {
            return data.icon
        }
    }
}

struct SideBarListViewModel {
    
    private var list : [SideBarViewModel]
    
    init(list: [SideBarViewModel]) {
        self.list = list
    }
    
    mutating func append(data: SideBarViewModel) {
        list.append(data)
    }
}

//MARK: - setup tableView's delegate data
extension SideBarListViewModel {
    
    var numberOfSection : Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int = 1) -> Int {
        return list.count
    }
    
    func listAtIndex(_ index: Int) -> SideBarViewModel {
        let data = list[index]
        let sideBarModel = SideBarModel(title: data.title, icon: data.icon)
        return SideBarViewModel(sideBarModel)
    }
    
    func setupTableViewCellContents(cell: UITableViewCell, indexPath index: Int) -> UITableViewCell {
        let data = list[index]
        cell.imageView?.image = data.icon
        cell.textLabel?.text = data.title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return cell
    }
}
