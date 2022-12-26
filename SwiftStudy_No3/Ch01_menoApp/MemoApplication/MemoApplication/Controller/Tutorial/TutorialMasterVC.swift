import UIKit
/**
 TODO : 에셋 카탈로그에 등록된 이미지로 메모장 앱 Tutorial 만들기
 
 - Param contentTitles : Tutorial 페이지 제목
 - Param contentImages : Tutorial imageView path
 
 # Notes: #
 1. Date : 22.08.13
    --에러--
    지금 Tutorial 화면을 만들어 줬는데 데이터 개수만큼 안에서만 before, after 스와이프 이동이 가능하다.
    근데 시작하기 버튼으로 갈 수 없다. index == 데이터 개수가 되면 subView를 삭제하면 되는 것인지.. 방법이 없다.
    --해결--
    pageView의 Image높이를 -50으로 한 이유가 부모뷰의 시작하기 버튼이 놓여있을 자리인데 실습을 iphone 13 pro max로 하다보니 교재와  디스플레이 높이 차이가 있었다..
 
 */
class TutorialMasterVC : UIViewController, UIPageViewControllerDataSource {
    var pageVC        : UIPageViewController!
    var titles        = "STEP 1_STEP 2_STEP 3_STEP 4"
    var image         = "Page0 Page1 Page2 Page3"
    var contentTitles = [String]()
    var contentImages = [String]()
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true,forKey: UserInfoKeyDTO.tutorial)
        ud.synchronize()
        
        //RevealVC 의 FrontVC인 MemoListVC로 돌아가기.
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        contentTitles = titles.split{$0=="_"}.map{String($0)}
        contentImages = image.split{$0==" "}.map{String($0)}
        setupPageVC()
    }
    func setupPageVC() {
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        guard let startContentVC = self.getContentVC(atIndex: 0) else {
            return NSLog("getContentVC(atIndex:) 초기화 안됨.")
        }
        self.pageVC.setViewControllers([startContentVC],direction:.forward,animated: true)
            
        self.pageVC.view.frame.origin      = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width  = self.view.frame.width
        //시작하기 버튼 보여야함!!
        self.pageVC.view.frame.size.height = self.view.frame.height - 70
        
        //VC등록
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParent: self.pageVC)
    }
    func getContentVC(atIndex idx : Int)->UIViewController? {
        guard self.contentTitles.count > idx && idx > -1 else {
            return nil
        }
        guard let cVC = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        cVC.titleText = self.contentTitles[idx]
        cVC.iamgeFile = self.contentImages[idx]
        cVC.pageIdx   = idx
        return cVC
    }
    func presentationCount(for pageViewController : UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    //MARK: - pageViewControllerDataSource
    /*
        현재 VC보다 앞에 올 컨텐츠 뷰 컨트롤러.
        앞으로 스와이프 했을 때 보여줄 VC
     */
    func pageViewController(_ pageViewController : UIPageViewController, viewControllerBefore viewController : UIViewController) -> UIViewController? {
        guard var index = (viewController as? TutorialContentsVC)?.pageIdx else {
            NSLog("TurotialContentsVC's pageIdx nil")
            return nil
        }
        
        guard index > 0 else {
            return nil
        }
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    
    /*
        현재 VC보다 뒤에 올 컨텐츠 뷰 컨트롤러
        뒤로 스와이프 했을 때 보여질 VC
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard var index = (viewController as? TutorialContentsVC)?.pageIdx else {
            return nil
        }
        index += 1
        guard index < self.contentTitles.count else {
            return nil
        }
        return self.getContentVC(atIndex: index)
    }
}

