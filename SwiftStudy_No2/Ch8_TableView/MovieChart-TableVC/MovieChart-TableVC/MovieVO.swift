//  MovieVO.swift
//  MovieChart-TableVC
//  Created by 양승현 on 2022/04/23.

import UIKit
//<a href ="https://github.com/SHcommit/SwiftStudy_No2/blob/master/%EA%B6%81%EA%B8%88%ED%96%88%EB%8D%98%EA%B2%83%EB%93%A4/ValueObjectPattern.md" alt="ViewObject의미"/>

class MovieVO{
    /**
     * 섬네일 이미지 주소
     * 제목
     * 설명
     * 상세정보
     * 개봉일
     * 평점*
     */
    var thumbnail :String?
    var title: String?
    var description: String?
    var detail : String?
    var opendate : String?
    var rating : Double?
}
