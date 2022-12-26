import UIKit
/**
 TODO : sideVC의 tableViewCell의 이미지와 text
 
 - Param titles : Cell의 제목
 - Param icons : Cell의 image
 */
class SideBarCellData
{
    var title = [String]()
    var icon = [UIImage]()
    init() {
        setupData()
    }
    
    func setupData() {
        title = ["새글 작성하기","친구 새글","달력으로 보기","공지사항","통계","계정 관리"]
        let iconPath = ["icon01.png","icon02.png","icon03.png","icon04.png","icon05.png","icon06.png"]
        
        iconPath.forEach {
            guard let icon = UIImage(named:$0) else {
                NSLog("sideBarList's img path wrong.")
                return
            }
            self.icon.append(icon)
        }
    }
}


class SideBarService {
    
    func getSideBarCellData(completion: @escaping (([SideBarModel])->Void)) {
        let cellData = SideBarCellData()
        var dataList = [SideBarModel]()
        for i in 0..<cellData.title.count {
            let sideBarModel = SideBarModel(title: cellData.title[i], icon: cellData.icon[i])
            dataList.append(sideBarModel)
        }
        completion(dataList)
    }
}
