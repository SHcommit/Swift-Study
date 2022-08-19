import UIKit

class CustomAlert
{
    enum arrow
    {
        case left , right
    }
    var alert    : UIAlertController?
    var leftBtn  : UIAlertAction?
    var rightBtn : UIAlertAction?
    var contentVC : UIViewController?
    func setupAlert(_ title : String?, _ message: String? , _ style : UIAlertController.Style)
    {
        alert = UIAlertController(title: title, message: message, preferredStyle: style)
    }
    func setupContent()
    {
        let vc = UIViewController()
        contentVC = vc
        alert?.view.addSubview(vc.view)
        alert?.setValue(vc, forKey: "contentViewController")
    }
    func setupBtn(_ title : String?, _ style: UIAlertAction.Style,_ arrow: arrow, _ handler : ((UIAlertAction)->())?)
    {
        switch arrow
        {
        case .left:
            leftBtn = UIAlertAction(title: title, style: style, handler: handler)
            break;
        case .right:
            rightBtn = UIAlertAction(title: title, style: style, handler: handler)
            break;
        default:
            ()
            break;
        }
    }
}
