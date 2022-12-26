import UIKit

class DepartTabBarItem : UITabBarItem
{
    convenience override init()
    {
        self.init()
        setupItem()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupItem()
    }
    
    func setupItem()
    {
        self.isEnabled = true
        self.title = "부서목록"
        self.image = UIImage(named:"depart.png")
    }
}
