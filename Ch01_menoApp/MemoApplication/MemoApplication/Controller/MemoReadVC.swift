//
//  MemoReadVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit
/**
 * TODO:
 * 특정 tableViewCell 이벤트가 발생했을 때
 *  해당 데이터의 값을 위젯으로 보여주는 작업을 한다.
 */
class MemoReadVC: UIViewController {
    //MARK: - variable
    var data : MemoData?
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var image : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appendData()
        appendTitle()
    }
    
    func appendData(){
        self.subject.text  = data?.title
        self.contents.text = data?.contents
        self.image.image   = data?.image
    }
    
    func appendTitle(){
        let formatter        = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString       = formatter.string(from: (data?.regdate)!)
        
        self.navigationItem.title = dateString
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
