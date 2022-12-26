import UIKit

class FirstViewController : UIViewController
{
    override func viewDidLoad() {
        var button : UIButton
        super.viewDidLoad()
        button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y, width: 100, height: 30)
        button.setTitle("VC1 화면", for: .normal)
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth     = 2
        button.layer.cornerRadius    = 3
        button.layer.borderColor     = UIColor.brown.cgColor
        button.layer.backgroundColor = UIColor.brown.cgColor
        button.backgroundColor       = UIColor.brown
        
        self.view.addSubview(button)
        
    }
}
