import UIKit

/**
 TODO : On Tap, When Keyboard Appears When Vertically Compat value true
 
 # Notes: #
 1. <#Notes if any#>
 
 */
class ProfileNavigationController : UINavigationController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBarsOnTap                 = true
        self.hidesBarsWhenKeyboardAppears   = true
        self.hidesBarsWhenVerticallyCompact = true
    }
}
