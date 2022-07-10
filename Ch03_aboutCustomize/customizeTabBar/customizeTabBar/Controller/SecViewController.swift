import UIKit

class SecViewController : UIViewController
{
    var button = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        button.setTitle("두번째 VC", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.frame = CGRect(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2, width: 100, height: 30)
        
        button.layer.borderColor  = UIColor.brown.cgColor
        button.layer.borderWidth  = 2
        button.layer.cornerRadius = 3
        button.backgroundColor    = UIColor.brown
        
        self.view.addSubview(button)
        
    }
}
