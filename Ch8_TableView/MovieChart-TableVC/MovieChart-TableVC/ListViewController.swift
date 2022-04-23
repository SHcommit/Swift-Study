//  ListViewController.swift
//  Created by 양승현 on 2022/04/23.

import UIKit

class ListViewController : UITableViewController{
    
    override func viewDidLoad() {
        
    }
    
    
    var dataTuple = [
        ("다크나이트","영웅물에 철학에 음악까지 더해져 예술이됨","2008-09-04",8.95),
        ("호우시절","때를 알고 내리는 좋은 비","2009-10-08",7.31),
        ("말할 수 없는 비밀","여기서 너까지 다섯 걸음","2015-05-07",9.19)
    ]
    
    /**
     * 변수가 참조되는 시점에 맞추어 초기화됨. (DLL)
     * datalist배열에 클로저를 통해 초기화를 함.
     * lazy키워드를 붙임으로 dataTuple 배열이 초기화된 후 에 나중에 list가 초기화됨.
     */
    lazy var list :[MovieVO] = {
        
       var datalist = [MovieVO]()
        for _ in 0..<dataTuple.count{
            for (title,decs,opendate, rating) in self.dataTuple{
                var mvo = MovieVO()
                mvo.title = title
                mvo.description = decs
                mvo.opendate = opendate
                mvo.rating = rating
            
                datalist.append(mvo)
            }
            
        }
        return datalist
    }()
    
    
}

extension ListViewController {
    /**
     * 1. tableView(_:numberOfRowsInSection) 메서드를 활용해 테이블 뷰 행 개수를 반환
     * 2. 위에서 반환된 Int만큼의 tableView(_:cellForRowAt:)가 호출되는데
     *      이를 통해 테이블 뷰 셀 객체를 정의한다.
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        cell.textLabel?.text = row.title
        
        return cell
    }
    
    //콜백 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        NSLog("\(indexPath.row)번째 행이 선택되었다.")
    }
}
