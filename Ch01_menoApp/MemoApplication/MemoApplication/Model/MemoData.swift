//
//  MemoData.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

/**
 TODO : 메모 데이터 in table Cell
 
    - Param memoIndex : 데이터 식별 값
    - Param title              : 메모 제목
    - Param contents      : 메모 내용
    - Param image          : 이미지
    - Param regdate       : 작성일
 */
class MemoData {
    var memoIndex : Int?
    var title     : String?
    var contents  : String?
    var image     : UIImage?
    var regdate   : Date?
}
