import UIKit

class ViewController: UIViewController
{
    var subject   : UILabel?
    var btn       : UIButton?
    lazy var flag = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // TODO : 버튼 인스턴스화 이후 이벤트 헨들러 부여
        subject = UILabel()
        btn     = UIButton(type: .system)
        
        self.storyboard?.instantiateViewController(identifier: "ViewController")

        addTestButton(button: &btn)
        btn?.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
        // UILabel
        addHelloLabel(label: &subject)
    }
}



// MARK: - 커스텀 버튼 구현 함수
extension ViewController{
    
    /**
     * 버튼 인스 턴스 생성 시 2가지 방법 p239
     * - .custom
     *      : 이 경우 사용자가 모든 것을 구현해야함.
     * - .system
     *      : 버튼 클래스가 제공하는 기본 속성을 디폴트로 한다.
     *       그러나 테두리x, 투명 사각형에 title 제공.
     * - .detailDisclosure
     *      : 인포메이션 마크추가됨
     * - .contactAdd
     *      : 주소록 추가용. + 마크 추가됨
     *
     * 타이틀 등 text를 삽입할 경우 .set~ 키워드 사용.
     */
    func addTestButton(button : inout UIButton?)
    {
        if var testButton = button
        {
            testButton.frame        = CGRect(x: 50, y: 100, width: 150, height: 30)
            testButton.backgroundColor    = UIColor.cyan
            testButton.layer.cornerRadius = CGFloat(3.0)
            testButton.center             = CGPoint(x: self.view.frame.size.width/2, y: 100)
            testButton.setTitle("테스트 버튼", for: .normal)
            testButton.setTitleColor(UIColor.orange, for: .normal)
            //버튼에 쉐도우 한번?
            addShadowInButotn(button: &testButton)
            
            button = testButton
            self.view.addSubview(testButton)

        }
    }
    func addHelloLabel(label : inout UILabel?)
    {
        if var testLabel = label
        {
            testLabel.text          = "hello! xml 좀 연습 해야겠어!!"
            testLabel.frame         = CGRect(x: 50, y: 100, width: 100, height: 30)
            //Wrap content
            testLabel.sizeToFit()
            testLabel.textAlignment = .center
            testLabel.textColor     = UIColor.lightGray
            testLabel.center        = CGPoint(x: self.view.frame.width/2, y: 200)
            //음 쉐도우 한번 써볼까잇~
            addShadowInLabel(label: &testLabel)
            label = testLabel
            
            self.view.addSubview(testLabel)
        }
    }
}

// MARK: - 이벤트 헨들러
extension ViewController{
    @objc func btnOnClick ( _ sender: Any)
    {
        if let btn = sender as? UIButton
        {
            if flag == false {
                flag = true
                btn.setTitle("클릭되었습니다.", for: .normal)
                present({
                    let alert = UIAlertController(title: nil, message: "버튼 클릭했네~ 다 알고 있지롱?",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "돌아가기", style: .default))
                    return alert
                }(), animated: true)
            }else{
                flag = false
                btn.setTitle("테스트 버튼", for: .normal)
                present({
                    let alert = UIAlertController(title: nil, message: "버튼 클릭했네요. 원래 버튼 속성으로 돌아갈게요",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "돌아가기", style: .default))
                    return alert
                }(), animated: true)
            }
        }
    }
    
    @objc func sayHello(_ sender : Any)
    {
        self.subject?.text = "GoodBye~, IB!"
    }
}

//MARK: - contents design :)
extension ViewController{
    func addShadowInLabel(label la : inout UILabel)
    {
        la.layer.shadowOffset  = CGSize(width: 3, height: 3)
        la.layer.shadowOpacity = 0.7
        la.layer.shadowRadius  = 2
        la.layer.shadowColor   = CGColor.init(srgbRed: 1, green: 0, blue: 0, alpha: 1)
    }
    func addShadowInButotn(button b : inout UIButton)
    {
        
        b.layer.shadowOffset = CGSize(width: 0, height: 4)
        b.layer.masksToBounds = false
        b.layer.shadowRadius = 4
        b.layer.shadowOpacity = 0.3
        b.layer.shadowColor = UIColor.black.cgColor
    }
}
