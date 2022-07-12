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
        let (width,height ) = (rawImg.size.width, rawImg.size.height)
        var content = UIView(frame: CGRect(x: 0, y: 0, width: width , height: height))
        content.addSubview(image)
        
    }
    func defaultAlert(_ title : String?, _ message : String?, _ preferredStyle : UIAlertController.Style ) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: "OK" , style: .default))
        return alert
    }
}
