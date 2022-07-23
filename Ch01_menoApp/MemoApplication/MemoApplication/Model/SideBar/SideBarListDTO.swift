import UIKit
/**
 TODO : sideVC의 tableViewCell의 이미지와 text
 
 - Param titles : Cell의 제목
 - Param icons : Cell의 image
 */
class SideBarListDTO
{
    var titles : [String]
    var icons  : [UIImage]
    init()
    {
        titles = [String]()
        icons  = [UIImage]()
        titles = ["새글 작성하기","친구 새글","달력으로 보기","공지사항","통계","계정 관리"]
        
        let iconPngNames = ["icon01.png","icon02.png","icon03.png","icon04.png","icon05.png","icon06.png"]
        iconPngNames.forEach
        {
            guard let icon = UIImage(named:$0) else
            {
                NSLog("sideBarList's img path wrong.")
                return
            }
            icons.append(icon)
        }
    }
}
