import UIKit

/**
 * TODO :
 * UIStepper 상속 받지 않고
 * 깡으로 구현!
 */
class CSStepper : UIView
{
    
    //MARK: - property
    public var stepper = myStepper()
    
    
    //MARK: - initializer
    //아 참고로 required 는 자손클래스에서 오버라이딩할때 override 키워드 안붙여도됨
    // 아 참고로 init?은 실패 가능성이 있는 초기자임
    // 참고로 이건 storyboard에서 사용하려고 만든 초기자.
    public required init?(coder aDecoder : NSCoder)
    {
        super.init(coder: aDecoder)
        stepperAddSubView()
    }
    
    //이건 storyboard말고 클래스에서 인스턴스 만들 수 있도록 부모 프레임 지정하기위한 지정 초기자임
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        stepperAddSubView()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        //너비와 높이는 항상 일치?!
        let btnWidth = self.frame.height
        let lblWidth = self.frame.width - (btnWidth * 2)
        
        self.stepper.leftBtn.frame     = CGRect(x: 0, y: 0, width: btnWidth, height: btnWidth)
        self.stepper.centerLabel.frame = CGRect(x: btnWidth, y: 0, width: lblWidth, height: btnWidth)
        self.stepper.rightBtn.frame    = CGRect(x: btnWidth + lblWidth, y: 0, width: btnWidth, height: btnWidth)
        
    }
    
    func stepperAddSubView()
    {
        self.addSubview(stepper.leftBtn)
        self.addSubview(stepper.centerLabel)
        self.addSubview(stepper.rightBtn)

        
    }
}

//MARK: - property class
extension CSStepper
{
    class myStepper
    {
        public var leftBtn     = UIButton(type: .system)
        public var rightBtn    = UIButton(type: .system)
        public var centerLabel = UILabel()
        
        @IBInspectable
        public var leftTitle   = "⬇︎"
        {
            didSet
            {
                self.leftBtn.setTitle(leftTitle, for: .normal)
            }
        }
        @IBInspectable
        public var rightTitle  = "⬆︎"
        {
            didSet
            {
                self.rightBtn.setTitle(rightTitle, for: .normal)
            }
        }
        @IBInspectable
        public var bgColor     = UIColor.cyan
        {
            didSet
            {
                self.centerLabel.backgroundColor = bgColor
            }
        }
        
        public var count       = 0
        {
            didSet
            {
                self.centerLabel.text = String(count)
            }
        }
        
        let borderWidth : CGFloat = 0.5
        let borderColor           = UIColor.blue.cgColor
        
        init()
        {
            setupLeftBtn()
            setupCenterLabel()
            setupRightBtn()
        }
        
        //MARK: - setupUI
        private func setupLeftBtn()
        {
            //tag : Identifying the View at Runtime
            //          So this is an integer that you can use to identify view objects in your application.
            self.leftBtn.tag = -1
            self.leftBtn.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 20)
            
            self.leftBtn.layer.borderWidth = borderWidth
            self.leftBtn.layer.borderColor = borderColor
        }
        private func setupRightBtn()
        {
            self.rightBtn.tag = 1
            self.rightBtn.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 20)
            
            self.rightBtn.layer.borderWidth = borderWidth
            self.rightBtn.layer.borderColor = borderColor
        }
        private func setupCenterLabel()
        {
            self.centerLabel.text              = String(count)
            self.centerLabel.font              = UIFont.systemFont(ofSize: 16)
            self.centerLabel.textAlignment     = .center
            self.centerLabel.backgroundColor   = .cyan
            self.centerLabel.layer.borderWidth = borderWidth
            self.centerLabel.layer.borderColor = borderColor
        }
    }
}
