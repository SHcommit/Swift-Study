import UIKit

//오 이렇게 하니까 좋다 굳이 coord 설정 안 해도 되고
class customFirstBtn : UIButton
{
    var style : CSButtonType = .rect
    {
        didSet
        {
            switch style
            {
            case .rect :
                self.backgroundColor = .cyan
                self.layer.borderColor = UIColor.cyan.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 0
                self.setTitle("rect Btn", for: .normal)
                self.setTitleColor(.white, for: .normal)
            case .circle  :
                self.backgroundColor    = .red
                self.layer.borderWidth  = 2
                self.layer.borderColor  = UIColor.red.cgColor
                self.layer.cornerRadius = 50
                self.setTitleColor(.white, for: .normal)
                self.setTitle("circle Btn", for: .normal)
            }
        }
    }
    init()
    {
        super.init(frame: CGRect.zero)
    }
    
    //스토리보드에서 쓰일때
    required init(coder aDecorder : NSCoder)
    {
        super.init(coder: aDecorder)!
        
        initialButtonUI("버튼")
    }
    
    //이건 VC에서도 쓰일 수 있도록.
    //추가적으로 init(frame:) 를 사용할 때는 이미 부모클래스에 존재해서 override 키워드
    //써야하는데 지금은 괜찮다. 부모 클래스에 없는 걸 내가 새로 만들었거든 그래도 부모 생성자 함수 호출해줘야해
    init(frame: CGRect, title : String) {
        super.init(frame: frame)
        initialButtonUI(title)
        //self.addTarget(self, action: #selector(clickBtnEvent(_:)), for: .touchUpInside)
    }
    
    
    convenience init(type: CSButtonType)
    {
        self.init()
        
        switch type {
        case .rect:
            self.backgroundColor    = .blue
            self.layer.borderColor  = UIColor.blue.cgColor
            self.layer.borderWidth  = 2
            self.layer.cornerRadius = 2
            self.setTitleColor(.white, for: .normal)
            self.setTitle("rect Btn", for: .normal)
        case .circle:
            self.backgroundColor    = .red
            self.layer.borderWidth  = 2
            self.layer.borderColor  = UIColor.red.cgColor
            self.layer.cornerRadius = 50
            self.setTitleColor(.white, for: .normal)
            self.setTitle("circle Btn", for: .normal)
        }
        self.addTarget(self, action: #selector(clickBtnEvent(_:)), for: .touchUpInside)
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
    @objc func clickBtnEvent(_ sender : UIButton)
    {
        sender.tag += 1
        sender.setTitle("\(sender.tag) 번째 클릭", for: .normal)
    }
}

public enum CSButtonType
{
    case rect
    case circle
    
}
