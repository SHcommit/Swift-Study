//
//  Foo.swift
//  MovieChart_webView
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit

class Foo: UIViewController{
    var extraValue = NSMutableDictionary()
    
    func saveInfo(){
        self.extraValue["title"] = "호빵맨"
        self.extraValue["description"] = "외계인이 사실은 없었다는 사실~"
        self.extraValue["rating"] = 3.8
    }
}
