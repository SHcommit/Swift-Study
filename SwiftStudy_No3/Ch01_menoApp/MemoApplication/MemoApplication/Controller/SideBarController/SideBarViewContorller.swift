//
//  SideBarViewContorller.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit

class SideBarViewController : UITableViewController {
    
    private var sideBarListVM:  SideBarListViewModel? = setupSideBarCellData()
    var revealVC: RevealViewController?
    var profile  = SideBarProfileVO()
    let userInfo = UserInfoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableHeader()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableHeader()
    }
    
}

//MARK: - tableView delegate
extension SideBarViewController {
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        guard let sideBarListVM = sideBarListVM else {
            fatalError("Failure binding listVM instance")
        }
        return sideBarListVM.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        guard let listVM = sideBarListVM else {
            fatalError("Failure binding listVM instance")
        }
        let id    = "SideBarMenuCell"
        let cell  = tableView.dequeueReusableCell(withIdentifier:id) ?? UITableViewCell(style:.default,reuseIdentifier: id)
       
        return listVM.setupTableViewCellContents(cell: cell, indexPath: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            setupToPresentVCInstance()
            break;
        case 5:
            setupCloseSideBar()
            break;
        default:
            break;
        }
    }
}

//MARK: - setup
extension SideBarViewController {
    
    func setupTableHeader() {
        profile.headerViewSetup(self.tableView)
        profile.nameLabelSetup(self.userInfo.name ?? "Guest")
        profile.emailLabelSetup(self.userInfo.account ?? "")
        profile.profileImageSetup(self.userInfo.profile)
    }
    
    
    func setupToPresentVCInstance() {
        guard let memoFormVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm") else {
            NSLog("memoFormVC instance nil")
            return
        }
        guard let target = revealVC?.frontVC as? UINavigationController else {
            fatalError("Failure find reveal instance")
        }
        
        revealVC?.closeSideBar {
            target.pushViewController(memoFormVC, animated: true)
        }
    }
    
    func setupCloseSideBar() {
        guard let uv = self.storyboard?.instantiateViewController(withIdentifier:"_profile") else {
            return NSLog("_profile Scene can't find in SideBarViewController.swift")
        }
        //이걸 하지 않으면 일반적인 present시에 나타나는 화면 전환으로 됨 stack느낌으로 이전 view가 뒤에 존재함.
        uv.modalPresentationStyle = .fullScreen
        self.present(uv, animated: true) {
            self.revealVC?.closeSideBar(nil)
        }
    }
    
    static func setupSideBarCellData() -> SideBarListViewModel{
        var listVM = [SideBarViewModel]()
        SideBarService().getSideBarCellData{ sideBarModels in
            
            sideBarModels.forEach{
                listVM.append(SideBarViewModel($0))
            }
        }
        return SideBarListViewModel(list: listVM)
    }
    
}
