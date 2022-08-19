import UIKit

class NaviBtnVO
{
    var EditBtn : UIBarButtonItem?
    var AddBtn  : UIBarButtonItem?
    func setupEditBtn(_ target : Any? , _ selector: Selector?)
    {
        self.EditBtn = UIBarButtonItem(title: "Edit", style: .plain, target: target, action: selector)
        self.EditBtn?.tintColor = .blue
        
    }
    func setupAddBtn(_ target: Any?, _ selector: Selector?)
    {
        self.AddBtn = UIBarButtonItem(barButtonSystemItem: .add, target: target, action: selector)
    }
}
