//
//  MemoDataListViewModel.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/09/24.
//

import UIKit


enum removeError: Error {
    case notDeleteElement
}

struct MemoDataListViewModel {
    lazy var dao = MemoDAO()
    var appDelegate : AppDelegate!
    
    private var list: [MemoDataViewModel]?
    
    var getList: [MemoDataViewModel] {
        get {
            return list ?? [MemoDataViewModel]()
        }
    }
    
    init() {
        initialAppDelegate()
        initialList()
    }
    
}

extension MemoDataListViewModel {
    
    mutating func initialAppDelegate() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Failure bind apDelegate instance")
        }
        self.appDelegate = appDelegate
    }
    
    mutating func initialList() {
        appDelegate.memoList = dao.fetch()
        list = [MemoDataViewModel]()
        appDelegate.memoList.forEach{
            list?.append(MemoDataViewModel(memoData: $0))
        }
    }
    
    mutating func append(index: Int) {
        let data = appDelegate.memoList[index]
        let memoDataVM = MemoDataViewModel(memoData: data)
        list?.append(memoDataVM)
    }
    
    mutating func append(contentsOf data: [MemoData]) {
        data.forEach{
            list?.append(MemoDataViewModel(memoData: $0))
        }
    }
    
    mutating func append(data: MemoDataViewModel) {
        list?.append(data)
    }
    
    func peek(index: Int) -> MemoData {
        return appDelegate.memoList[index]
    }
    
    mutating func remove(index: Int) {
        guard var list = list else {
            return
        }
        list.remove(at: index)
    }
    
}

//MARK: - TableView data
extension MemoDataListViewModel {
    
    func numberOfRowsInSection() -> Int {
        guard let list = list else {
            fatalError("Failure bind list instance")
        }
        return list.count
    }
    
    func getListViewModelData(index: Int) -> MemoDataViewModel {
        guard let list = list else {
            fatalError("Failure bind list instance")
        }
        return list[index]
    }
    // callback에 따라 성공시 tableView.deleteRows해줘야함.
    // guard 이거 맞나? 맨 아래 dao. 확인해야함
    mutating func removeListViewModelData(index: Int, callback: (Result<String,removeError>)->Void) {
        guard var list = list else {
            fatalError("Failure bind list instance")
        }
        let data = list[index]
        guard let objID = data.objectID else {
            fatalError("data.objID nil")
        }
        guard dao.delete(objID) else {
            callback(.failure(removeError.notDeleteElement))
            return
        }
        list.remove(at: index)
        callback(.success("true"))
    }
}
