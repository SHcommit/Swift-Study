//
//  RevealViewController.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit

/**
 TODO : MemoListVC와 SideBarVC를 다루는 Controller
 
 - Param frontVC : MemoListVC instance
 - Param sideVC : SideBarViewController instance
 - Param isSideBarShowing : SideBar's instance의 value or nil
 - Param (SLIDE_TIEM,SLIDEBAR_WIDTH) : (화면 열리는 ainmation시간 ,열릴 x 위치)
 
 # Notes: #
 1. setUpFrontView()
    frontVC인스턴스를 RevealVC의 자식으로 등록한다.
    frontVC의 대리자에게 위임한다.
 2. getSideView()
    sideVC 인스턴스를 RevealVC의 자식으로 등록한다.
    frontVC가 초기 화면에 보여짐으로 bringSubviewToFront()를 적용한다.
 3. setShadowEffect(_: offset:)
    frontVC의 layout에 shadow를 적용시킨다.
 4. openSideBar(_:)
    사용자의 barButton클릭이나 panning제스쳐 동작 시 SideVC의 인스턴스를 생성하고 animation을 통해 보여진다.
 5. closeSideBar(_:)
    사용자의 barBtn 클릭이나 swipe 제스쳐 동작 시 SideVC의 인스턴스 해제랑 frontVC의 layer shadow를 해제한다.
 */
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
        self.frontVC            = vc
        let frontViewController = vc.viewControllers[0] as? MemoListVC
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
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
            self.frontVC?.view.layer.cornerRadius  = 0.0
            self.frontVC?.view.layer.shadowOffset  = CGSize(width:0,height:0)
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
                self.frontVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: Int(self.view.frame.width), height: Int(self.view.frame.height))
            },
            completion:
            {
                //성공적으로 animation이 실행됬는가?
                if $0
                {
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
