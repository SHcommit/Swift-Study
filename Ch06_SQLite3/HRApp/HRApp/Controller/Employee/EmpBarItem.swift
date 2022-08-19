import UIKit

class EmpBarItem : UITabBarItem
{
    override convenience init()
    {
        self.init()
        setupItem()
    }
    override required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        setupItem()
    }
    func setupItem()
    {
        self.isEnabled = true
        self.title     = "사원목록"
        self.image     = UIImage(named:"employee.png")
    }
}
