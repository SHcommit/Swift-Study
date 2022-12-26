import UIKit

/**
 * TODO:
 *
 * 초기  기존 탭 바 Item과 background를 다 hide한다.
 * 1. 탭바의 크기를 보여줄 UIView객체를 만들고 tabBar를 나타낼 적당한 frame설정을 한다.
 *   이때 self.view frame을 이용한다.
 *   이는 추후 상속 될 ViewController의 UIView 속성이다.
 * 2. 각각 tabBarItem을 정의한다.
 * 대박 신기
 *
 * 3. storyboard에서 우리가정의한 customTabBarContorller한테 (tabBar Item 붙은 IB VC위젯 한테 세그로 연결해주면 된다.. +_+ 대박
 * 근데 여기서 이제    특정 Scene다룰려면 커스텀 VC만들어서 하면 된다..키야..
 */
class CustomTabBarController : UITabBarController
{
    let csView    = UIView()
    var tabItem01 = UIButton(type: .system)
    var tabItem02 = UIButton(type: .system)
    var tabItem03 = UIButton(type: .system)
    override func viewDidLoad() {
        self.tabBar.isHidden = true
        
        addTabBarLayout()
        
        addTabBarItem(0)
        addTabBarItem(1)
        addTabBarItem(2)
        
        addTabBarBtn(&self.tabItem01, "탭1", tag: 0)
        addTabBarBtn(&self.tabItem02, "탭2", tag: 1)
        addTabBarBtn(&self.tabItem03, "탭3", tag: 2)
        
        //이렇게 하면 초기에 탭1을 누른상태로 앱이 켜진다..
        self.onTabBarItemClick(self.tabItem01)
        
    }
}

extension CustomTabBarController
{
    /**
     * 탭바 디폴트 설정 없앤 후
     * UIView로 새로 백그라운드 설정
     */
    func addTabBarLayout()
    {
        let width  = self.view.frame.width
        let height : CGFloat = 80
        let x      : CGFloat = 0
        let y      = self.view.frame.height - height
        
        self.csView.frame = CGRect(x: x, y: y, width: width, height: height)
        self.csView.backgroundColor = .brown
        
        self.view.addSubview(self.csView)
    }
    
    //탭바 frame 지정
    func addTabBarItem(_ index : Int)
    {
        let tabBtnWidth  = self.csView.frame.size.width / 3
        let tabBtnHeight = self.csView.layer.frame.height
        
        switch index
        {
        case 0:
            self.tabItem01.frame = CGRect(x:0, y: 0, width: tabBtnWidth, height : tabBtnHeight)
        case 1:
            self.tabItem02.frame = CGRect(x: tabBtnWidth, y : 0, width: tabBtnWidth, height : tabBtnHeight)
        case 2:
            self.tabItem03.frame = CGRect(x: tabBtnWidth * 2, y : 0 , width: tabBtnWidth, height : tabBtnHeight)
        default:
            NSLog("item 변수부터 추가해주세요")
        }
    }
    
    func addTabBarBtn(_ btn: inout UIButton, _ title : String, tag : Int)
    {
        btn.setTitle(title, for: .normal)
        btn.tag = tag
        
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.setTitleColor(UIColor.yellow, for: .selected)
        
        btn.addTarget(self, action: #selector(onTabBarItemClick(_ :)), for: .touchUpInside)
        
        self.csView.addSubview(btn)
    }
    
}
//MARK: - event Handler
extension CustomTabBarController
{
    @objc func onTabBarItemClick(_ sender : UIButton)
    {
        self.tabItem01.isSelected = false
        self.tabItem02.isSelected = false
        self.tabItem03.isSelected = false
        
        sender.isSelected         = true
        
        self.selectedIndex        = sender.tag
    }
}

