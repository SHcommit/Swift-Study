//  ListViewController.swift
//  Created by 양승현 on 2022/04/23.

import UIKit

class ListViewController : UITableViewController{
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.rowHeight = 92
    }
    override func viewDidLoad() {
        
    }
    
    
    var dataTuple = [
        ("다크나이트","영웅물에 철학에 음악까지 더해져 예술이됨","2008-09-04",8.95,"darknight.jpg"),
        ("호우시절","때를 알고 내리는 좋은 비","2009-10-08",7.31,"rain.jpg"),
        ("말할 수 없는 비밀","여기서 너까지 다섯 걸음","2015-05-07",9.19,"secret.jpg")
    ]
    
    /**
     * 변수가 참조되는 시점에 맞추어 초기화됨. (DLL)
     * datalist배열에 클로저를 통해 초기화를 함.
     * lazy키워드를 붙임으로 dataTuple 배열이 초기화된 후 에 나중에 list가 초기화됨.
     */
    lazy var list :[MovieVO] = {
        
       var datalist = [MovieVO]()
        for _ in 0..<dataTuple.count{
            for (title,decs,opendate, rating,thumbnail) in self.dataTuple{
                var mvo = MovieVO()
                mvo.title = title
                mvo.description = decs
                mvo.opendate = opendate
                mvo.rating = rating
                mvo.thumbnail = thumbnail
            
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
        //UITableViewCell을 클래스로하는 커스텀 클래스를 구현했기에 MovieCell 으로 다운캐스팅한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // MovieCell에서 정의한 멤버변수 다룰 수 있음
        cell.title?.text = row.title
        cell.decs?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        
        /**
         * 이미지 처리 방법
         * UIImage 객체 생성시 init값을 파일 경로로 설정하고,
         * UIImageView객체의 .image속성에 대입 해야 한다.
         * 이때 "캐싱"방식을 사용한다
         * ex) 프린터의 스풀링, 버퍼링과 같은 개념
         * 한 번 읽은 이미지를 메모리에 저장한 후 메모리에 저장된 이미지 가져온다.
         * UIImage(named:) 캐싱 지원
         * UIImage(contentsOfFile:) 캐싱x (이미지 매번 읽어와야함)
         */
        cell.thumbnail.image = UIImage(named:row.thumbnail!)
        
        
        return cell
    }
    
    
    //콜백 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        NSLog("\(indexPath.row)번째 행이 선택되었다.")
    }
}
