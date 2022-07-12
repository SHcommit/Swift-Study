import UIKit

class warningAlert
{
    var alert = UIAlertController()
    init(_ title : String?, _ message : String?, _ preferredStyle : UIAlertController.Style)
    {
        alert = defaultAlert(title, message, preferredStyle
        )
        ContentUI()
    }
    
    func ContentUI()
    {
        guard let rawImg = UIImage(named: "warning-icon-60") else{
            return NSLog("no create img instance")
        }
        let image = UIImageView(image: rawImg)
        let (width,height) = (rawImg.size.width, rawImg.size.height)
        
        var content = UIViewController()
        content.view.addSubview(image)
        content.preferredContentSize = CGSize(width: width, height: height + 10)
        alert.setValue(content, forKey: "contentViewController")
    }
    func defaultAlert(_ title : String?, _ message : String?, _ preferredStyle : UIAlertController.Style ) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK" , style: .default))
        return alert
    }
}
