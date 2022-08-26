//
//  MemoData.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit
import CoreData

/*
 TODO : 메모 데이터 in table Cell
 
    - Param memoIndex : 데이터 식별 값
    - Param title     : 메모 제목
    - Param contents  : 메모 내용
    - Param image     : 이미지
    - Param regdate   : 작성일
    - Param objectID  : 코어데이터 MemoMO 객체
 # Notes: #
    1. Date : 22.08.26
        코어 데이터 MemoMO entity 추가
        여기서 문제는 MemoData는 tv cell의 내용을 반영하는 Model인데 코어데이터 또한 그렇다는 것이다.
        영구 저장소에 기록하기 위해선 코어 데이터 MemoMO 활용도 좋다는 생각이 든다.
        UI에 MemoData를 반영할 때는 MemoMO에서 값을 건내줄 수 있지만,
        **메모를 수정하거나 삭제할 때**
        컨텍스트에 저장된 MemoMO를 찾아 처리해야 한다.
 
 */
class MemoData {
    var memoIndex : Int?
    var title     : String?
    var contents  : String?
    var image     : UIImage?
    var regdate   : Date?
    var objectID  : NSManagedObjectID?
}
