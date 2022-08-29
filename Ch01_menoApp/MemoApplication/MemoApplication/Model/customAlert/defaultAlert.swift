import UIKit

class customAlertVO
{
    var alert      : UIAlertController!
    var centerView : UIViewController!
    
    init(title: String?, message : String?, style: UIAlertController.Style)
    {
        alert = UIAlertController(title: title, message: message, preferredStyle: style)
    }
    func addBtn(title : String, style : UIAlertAction.Style, completion : ((UIAlertAction) -> Void)? = nil)
    {
        let btn = UIAlertAction(title: title, style: style,handler: completion )
        alert.addAction(btn)
    }
    func addCenterVC()
    {
        centerView = UIViewController()
        alert.view.addSubview(centerView.view)
        alert.setValue(centerView,forKey: "contentViewController")
    }
}
