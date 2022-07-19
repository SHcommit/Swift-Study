import UIKit

/**
 TODO : 프론트 뷰 리어뷰 컨트롤하기 위한 컨트롤러
 
 # Document: #
 FrontViewController의 view와 SideBarView의 View를 다루는 뷰다.
 컨테이너 뷰라고도 할 수 있다.
 
 - Param contentVC : 컨텐츠 담을 VC
 - Param sideVC : 사이드 바 메뉴 담당 VC
 - Param isSideBarShowing : 현재 사이드 바가 동작 중인지?
 - Param SLIDE_TIME : duration open, close
 - Param SIDEBAR_WIDTH : 사이드 바 열리는 너비
 
 - func setUpView : 초기 화면 설정
 - func getSideView : 사이바 뷰 읽어옴
 - func setShadowEffect : 콘텐츠 뷰에 그림자 효과
 - func openSideBar : 사이드 바 열음
 - func closeSideBar : 사이드 바 닫음
 
 # Notes: #
 1. FrontViewController     : 사용자에게 보여질 첫 화면
 2. SideBarViewController : 왼쪽 옆에서 열일 사이드 바 화면
 
 */
class RevealViewController : UIViewController
{
    var contentVC  : UIViewController?
    var sideVC     : UIViewController?
    var isSideBarShowing = false
    
    let SLIDE_TIME = 0.3
    let SIDEBAR_WIDTH : CGFloat = 260
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpView()
    }
    func setUpView()
    {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController
        {
            self.contentVC = vc
            self.addChild(vc)
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
        }
    }
    func getSideView()
    {
        guard self.sideVC == nil else
        {
            return
        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear") else
        {
            return
        }
        
        self.sideVC = vc
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        guard let contentView = self.contentVC?.view else
        {
            NSLog("rearVC nil처리됨 확인 바람")
            return
        }
        //contentVC는 항상 나와있어야해 side는 특수 이벤트시만 보여지는 View니까
        self.view.bringSubviewToFront((contentView))
    }
    
    //sideBar의 layout에 shadow만 적용
    func setShadowEffect(_ shadow: Bool, offset: CGFloat)
    {
        if shadow
        {
            self.contentVC?.view.layer.masksToBounds = false
            self.contentVC?.view.layer.cornerRadius  = 10
            self.contentVC?.view.layer.shadowOpacity = 0.8
            self.contentVC?.view.layer.shadowColor   = UIColor.black.cgColor
            self.contentVC?.view.layer.shadowOffset  = CGSize(width: offset, height: offset)
        }
        else
        {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    /**
     사용자의 제스쳐가 주어지면 해당 함수를 실행함으로 써 sideBar를 보여줍니다.
     
     - parameter complete: 애니메이션 동작 후 해야 할 것은 없는지?.
     - returns: <#Return values#>
     
     - Param options: 애니메이션 옵션 2개.
            아 참고로 아래서 UIView.animate의 3번째 인자값으로 넣어주는데 왜 배열이냐?!!
            그야 set 타입을 쓸 수 있으니깨
     - Param UIView.animate: 애니메이션 실행.
     
     # Notes: #
     1. About UIView.animate(withDuration:delay:options:animations:completion:)
        # Document: #
            인자값으로 주어진 값들에 의해 한개 또는 여러개의 뷰의 애니메이션을 바꿔준다.
        - parameter withDuration: 애니메이션의 전체 기간.
        - parameter delay: 애니메이션 시작 전 대기 타임.
        - parameter options: 어떻게 애니메이션을 보여줄건지 효과들 설정.
        - parameter animations: 실행 애니메이션 내용.
        - parameter complete: 애니메이션을 동작한 후에 실행해야 할 추가사항이 있는가?.
                아 참고로 5번째 매개변수는 인자값으로 Bool타입 받는다. 근데 반환값은 없어.
                nil값 넣어도 되고. 옵셔널로 선언된 클로저 타입을 인자값으로 받으니까.
     */
    func openSideBar(_ complete: (() -> Void)?)
    {
        self.getSideView()
        self.setShadowEffect(true, offset: -2)
        
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration : TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations:
            {
                //애니에메이션 실행하면 음 table's View를 SIDEBAR_WIDTH만큼 옮겨주세욤 근데 크기 는 그냥 현재 뷰 frame 크기로 해주세요.
                self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH,y : 0, width: self.view.frame.width, height: self.view.frame.height)
            },
            completion:
            {
                //애니메이션 동작했는가?
            if $0
            {
                //와우 다섯번째 매개변수로 사이드 바가 보여지고 있다는걸 true체크후~ 추가 view의 상태 업데이트 할 내용이 있는가?
                //있다면 complete()로 실행할겜,, 크오오..
                self.isSideBarShowing = true
                complete?()
            }
        })
    }
    func closeSideBar(_ complete : (() -> Void)?)
    {
        
    }
    func afterComplete()
    {
        // TODO : sideBarView가 보여진 후에, 또는 가려진 후에 view의 업뎃 내용을 쓰면 됨
    }
}
