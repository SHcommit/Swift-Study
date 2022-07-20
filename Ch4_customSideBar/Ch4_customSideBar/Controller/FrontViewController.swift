import UIKit

class FrontViewController : UIViewController
{
    /*
     이렇게 델리게이트를 사용한다. 근데
     단점이 있다.
     클래스 타입이다.
     상속을 받아서 사용해야 할 수도 있다. 그러면 기능 확장이 no good 그래서 보통은 프로토타입으로 델리게이트를 구현해준다.
     
     RevealViewController에서 특정 권한을 위임하려고 델리게이션 씀. 짬처리 느낌? 근데 또 신기한게 신기하네..
     그러니까 RevealViewController는 관심을 안줘 그냥 sw_front만 일단 출력하는데,
     언제??
     RevealView가 아니라 FrontView에서 버튼을 클릭할 때!!!!
     RevealView의 함수가 필요해 근데 이 함수 구성은 RevealView에 split View를 해줌으로써 side Bar가 열리는 것이지..
     이 과정에서 필요한게 RevealView 의 openSideBar인데.
     이미 RevealView에서 FrontView의 대리자한테 위임했어(self)로 그래서 언제든지 !!
     대리자를 통해서 함수들을 사용하고, 즉시 갱신? 할수 있게되는것임 ..
     캬 갱신?업데이트가 좀 대박인데..
     */
    var delegate : RevealViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let btnSideBar =
        {
            UIBarButtonItem(image:UIImage(named:"sidemenu.png"),style: UIBarButtonItem.Style.plain, target: self,action:#selector(self.moveSide(_:)))
        }()
        self.navigationItem.leftBarButtonItem = btnSideBar
    }
    
    //액션에 따라 델리게이트 메소드 호출
    @objc func moveSide(_ sender: Any)
    {
        if self.delegate?.isSideBarShowing == false
        {
            self.delegate?.openSideBar(nil)
        }
        else
        {
            self.delegate?.closeSideBar(nil)
        }
    }
}
