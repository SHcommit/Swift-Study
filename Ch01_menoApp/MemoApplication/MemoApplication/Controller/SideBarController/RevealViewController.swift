//
//  RevealViewController.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit

class RevealViewController : UIViewController
{
    var frontVC : UIViewController?
    var sideVC  : UITableViewController?
    var isSideBarShowing = false
    let (SLIDE_TIME, SIDEBAR_WIDTH) = (0.3, 260)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpFrontView()
    }
    //MARK: - selected frontVC, sideVC from RevealVC
    func setUpFrontView()
    {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"Reveal_FrontView") as? UINavigationController else
        {
            NSLog("Reveal's FrontVC value == nil")
            return
        }
        self.frontVC = vc
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        //대리자한테 위임함. by using getSideView()..
        let frontViewController = vc.viewControllers[0] as? MemoListVC
        frontViewController?.sideBarDelegate = self
    }
    func getSideView()
    {
        guard self.sideVC == nil else
        {
            return
        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier:"Reveal_SideView") as? UITableViewController else
        {
            NSLog("Reveal's SideVC == nil")
            return
        }
        self.sideVC = vc
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent:self)
        guard let frontViewController = self.frontVC else
        {
            NSLog("Reveal's FrontVC == nil.\n check setUpFrontView()")
            return
        }
        self.view.bringSubviewToFront(frontViewController.view)
    }
    //MARK: - setFrontView's layer's shadow style :)
    func setShadowEffect(_ shadow:Bool,offset:CGFloat)
    {
        if shadow
        {
            self.frontVC?.view.layer.masksToBounds = false
            self.frontVC?.view.layer.cornerRadius  = 10
            self.frontVC?.view.layer.shadowOpacity = 0.8
            self.frontVC?.view.layer.shadowColor   = UIColor.black.cgColor
            self.frontVC?.view.layer.shadowOffset  = CGSize(width:offset,height:offset)
        }
        else
        {
            self.frontVC?.view.layer.cornerRadius = 0.0
            self.frontVC?.view.layer.shadowOffset = CGSize(width:0,height:0)
        }
    }
    func openSideBar(_ complete: (()->Void)?)
    {
        self.getSideView()
        self.setShadowEffect(true, offset: -0.2)
        let options = UIView.AnimationOptions([.curveEaseInOut, .beginFromCurrentState])
        
        UIView.animate(
            withDuration : TimeInterval(SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations:
            {
                //frontVC는 뷰 컨트롤러니까.
                self.frontVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: Int(self.view.frame.width), height: Int(self.view.frame.height))
            },
            completion:
            {
                if $0
                {
                    //에니메이션 실행이 됬는가?
                    self.isSideBarShowing = true
                    complete?()
                }
            }
        )
    }
    func closeSideBar(_ complete : (()->Void)?)
    {
        let options = UIView.AnimationOptions([.curveEaseInOut,.beginFromCurrentState])
        UIView.animate(
            withDuration : TimeInterval(SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations:
            {
                self.frontVC?.view.frame = CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: Int(self.view.frame.height))
            },
            completion:
            {
                //성공적으로 닫혔는가?
                if $0
                {
                    self.sideVC?.view.removeFromSuperview()
                    self.sideVC = nil
                    
                    self.isSideBarShowing = false
                    self.setShadowEffect(false, offset: 0)
                    complete?()
                }
            }
        )
    }
}
