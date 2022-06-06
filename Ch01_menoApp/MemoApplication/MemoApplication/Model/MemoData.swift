//
//  MemoData.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

class MemoData {
    /**
     * @param memoIndex : 데이터 식별값
     * @param title              : 메모 제목
     * @param contents      : 메모 내용
     * @param image          : 이미지
     * @param regdate        : 작성일
     */
    var memoIndex : Int?
    var title     : String?
    var contents  : String?
    var image     : UIImage?
    var regdate   : Date?
}
