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
        self.view.bringSubviewToFront((contentView))
    }
    func setShadowEffect(_ shadow: Bool, offset: CGFloat)
    {
        
    }
    func openSideBar(_ complete: (() -> Void)?)
    {
        
    }
    func closeSideBar(_ complete : (() -> Void)?)
    {
        
    }
}
