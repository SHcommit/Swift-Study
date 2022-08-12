import UIKit

/**
 TODO : Tutorial 컨텐츠를 담고있는 VC. PageViewControllerDataSource의 before, after 헨들러에 따라 title, image가 보여짐
 
 - Param pageIdx : 현재 보여지는 화면 index
 - Param titleText : 현재 화면 page
 - Param bgImageView : 백그라운드 이미지(Tutorial)
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class TutorialContentsVC : UIViewController
{
    @IBOutlet weak var titleLabel  : UILabel!
    @IBOutlet weak var bgImageView : UIImageView!
    
    var pageIdx : Int! , titleText : String! , iamgeFile : String!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupContents()
    }
    func setupContents()
    {
        self.bgImageView.contentMode = .scaleToFill
        self.bgImageView.image = UIImage(named:self.iamgeFile)
        
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
    }
}
