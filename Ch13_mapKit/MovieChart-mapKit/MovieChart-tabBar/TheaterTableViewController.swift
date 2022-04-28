//
//  TheaterTableViewController.swift
//  MovieChart-tabBar
//
//  Created by 양승현 on 2022/04/28.
//

import UIKit

class TheaterTableViewController : UITableViewController{
    lazy var list = [NSDictionary]()
    
    var startPoint = 0
    override func viewDidLoad() {
        self.tableView.rowHeight = 80
        _callRESTAPI()
    }
    
}
//MARK: - REST API로 json 데이터 받아서 파싱하는 과정까지
extension TheaterTableViewController{
    private func _callRESTAPI() {
        let url = "http://swiftapi.rubypaper.co.kr:2029/theater/list?s_page=1&s_list=100&type=json"
        let urlObject = URL(string: url)
        /*
         * String과 달리 NSString은 인코딩 지원한다. object-c를 빨리..공부해야..ㅠ
         * 0x80_000_422 EUC-kr (로 데이터의 일부 인코딩됨).
         */
        do{
            //인코딩 후
            let stringData = try NSString(contentsOf: urlObject!, encoding: 0x80_000_422)
            //data로 변환함.
            let encdata = stringData.data(using: String.Encoding.utf8.rawValue)
            
            do{
                //변환한 데이터를 .jsonObject를 통해 NSDictionary로 변환하기 위한 과정
                let apiArray = try JSONSerialization.jsonObject(with: encdata!, options: []) as? NSArray
                for obj in apiArray!{
                    self.list.append(obj as! NSDictionary)
                }
            }catch{
                self.present({
                    
                    let alert = UIAlertController(title: "실패 알림", message: "Failure Data parsing", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                    
                    return alert
                }(), animated: true)
            }
            self.startPoint += 100
        }catch{
            self.present({
                let alert = UIAlertController(title: "실패", message: "데이터 불러오는데 실패했습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                return alert
            }(), animated: true)
        }
    }
}
//MARK: - tableView , segue 구현
extension TheaterTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let temp = self.list[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "theaterCell") as! TheaterTableViewCell
        cell.name?.text = temp["상영관명"] as? String
        cell.tel?.text  = temp["연락처"] as? String
        cell.addr?.text = temp["소재지도로명주소"] as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_map" {
            let path = self.tableView.indexPath(for: sender as! UITableViewCell)
            let data = self.list[path!.row]
            
            /*
             * 안드로이드 시점에서는 인텐트를 통해 전달했는데,
             *
             * Swift는 segue를 통해 특정 segue identifier 를 찾고,
             * indexPath . row를 특정 클릭된 테이블 셀 행찾고,
             * segue.destination 의 형변환을 통해 도착지 VC 인스턴스 얻어서
             * 해당 맴버변수에 값을 전달한다!!
             */
            let dest = segue.destination as? TheaterViewController
            dest!.param = data
        }
    }
}


