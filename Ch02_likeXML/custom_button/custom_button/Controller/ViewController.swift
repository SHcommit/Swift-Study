import UIKit

class ViewController: UIViewController
{
    var btn  : UIButton = {UIButton()}()
    var flag : Bool     = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // TODO : 버튼 인스턴스화 이후 이벤트 헨들러 부여
        addTestButton(button: &btn)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
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
    func addTestButton(button : inout UIButton)
    {
        button       = UIButton(type: .system)
        button.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        
        button.setTitle("테스트 버튼", for: .normal)
        button.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
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
    
}
