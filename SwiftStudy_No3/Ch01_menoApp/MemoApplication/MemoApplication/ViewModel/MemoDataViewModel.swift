//
//  MemoDataViewModel.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/09/24.
//

import UIKit
import CoreData

struct MemoDataViewModel {
    private var memoData: MemoData?
    
    init(memoData: MemoData? = nil) {
        self.memoData = memoData
    }
    
}

//MARK: - get Properties data
extension MemoDataViewModel {
    var memoIndex: Int? {
        get {
            return memoData?.memoIndex
        }
    }
    
    var title: String? {
        get {
            return memoData?.title
        }
    }
    
    var contents: String? {
        get {
            return memoData?.contents
        }
    }
    
    var image: UIImage? {
        get {
            return memoData?.image
        }
    }
    
    var regdate: Date? {
        get {
            return memoData?.regdate
        }
    }
    
    var objectID: NSManagedObjectID? {
        get {
            return memoData?.objectID
        }
    }
}
