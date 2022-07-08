import UIKit

//오 이렇게 하니까 좋다 굳이 coord 설정 안 해도 되고
class customFirstBtn : UIButton
{
    //스토리보드에서 쓰일때
    required init(coder aDecorder : NSCoder)
    {
        super.init(coder: aDecorder)!
        
        initialButtonUI("버튼")
    }
    
    //이건 VC에서도 쓰일 수 있도록.
    init(frame: CGRect, title : String) {
        super.init(frame: frame)
        initialButtonUI(title)
        self.addTarget(self, action: #selector(btnEvent(_:)), for: .touchUpInside)
    }
}
extension customFirstBtn
{
    func initialButtonUI( _ title : String)
    {
        self.backgroundColor = .brown
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 3
        self.setTitleColor(UIColor.black, for: .normal)
        self.setTitle(title, for: .normal)
    }
}
extension customFirstBtn
{
    @objc func btnEvent(_ sender : Any)
    {
        
    }
}
