import UIKit

class CustomTabBarController : UITabBarController
{
    let csView    = UIView()
    let tabItem01 = UIButton(type: .system)
    let tabItem02 = UIButton(type: .system)
    let tabItem03 = UIButton(type: .system)
    override func viewDidLoad() {
        self.tabBar.isHidden = true
    }
}
