import UIKit

class MenuDTO
{
    var titles : [String]
    var icons  : [UIImage]
    init()
    {
        let str  = "메뉴 01,메뉴 02,메뉴 03,메뉴 04,메뉴 05"
        let path = "icon01.png icon02.png icon03.png icon04.png icon05.png"
        let name = path.split(separator: " ").map{String($0)}
        titles   = [String]()
        icons    = [UIImage]()
        titles   = str.split(separator: ",").map{String($0)}
        
        name.forEach
        {
            icons.append(UIImage(named: $0)!)
        }
    }
}
