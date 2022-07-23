//
//  MemoListVCExtension.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/07/22.
//

import UIKit

extension MemoListVC
{
    @objc func moveSide(_ sender : Any)
    {
        if self.sideBarDelegate?.isSideBarShowing == false
        {
            self.sideBarDelegate?.openSideBar(nil)
        }
        else
        {
            self.sideBarDelegate?.closeSideBar(nil)
        }
    }
}
