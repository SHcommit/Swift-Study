//
//  ViewController.swift
//  MSG-AlertController
//
//  Created by 양승현 on 2022/03/19.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var result: UILabel!
    /**
     *열거형 타입으로 변수, 상수가 이미 정의 되어있다면, 열거형 객체의 이름은 생략하고 " .값 " 으로만 열거형을 호출할 수 있다.
     *이때 열거형임을 표현하고자 . dot을 사용한다.*
     */
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "선택", message: "항목을 입력해주세요", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel){ (_) in
            self.result.text = "취소 버튼을 클릭했다."
        }
        
        let exec = UIAlertAction(title: "실행", style: .destructive){ (_) in
            self.result.text = "실행 버튼 클릭했습니다."
        }
        
        let stop = UIAlertAction(title: "중지", style: .default){(_) in self.result.text = "중지 버튼을 클릭했습니다."}
        

        alert.addAction(cancel)
        
        //익명 클래스로 작성해봄.
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        alert.addAction(exec)
        
        alert.addAction(stop)
        
        self.present(alert, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        let title = "ITunes Store에 로그인"
        let subTitle = "사용자의 애플 ID 의 암호를 입력하시오."
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        let ok = UIAlertAction(title: "확인", style: .default){(_) in
            //alert에 addTextField()로 등록된 처음 tf의 주소를 참조한다.
            //아래 방법은 alert에 등록된 첫번째 tf의 주소를 참조한다.
            //or alert.textFields?.first
            let loginID = alert.textFields?[0].text
            let loginPW = alert.textFields?[1].text
            
            if loginID == "star123" && loginPW == "1234"{
                self.result.text = "인증되었습니다"
            }else{
                self.result.text = "인증 실패"
            }
        }
        
        //.alert는 텍스트 필드를 추가할 수 있다.
        //.addTextField(configurationHandler:)의 클로저는 tf의 속성을 설정한다.
        
        //추가된 tf를 참조할 때는 addTextField()를 통해 호출할 수 있다.
        /**
         또한 여러개의 tf를 알림창에 추가할 수도 있는데,
         이때는 알림창 객체.textFields?[0] / .texfFileds?[1] ..로 해당 tf가 뭘 입력받았는지, 참조값을 얻어 호출할 수 있다.
         
         */
        alert.addTextField(configurationHandler: ){
            $0.placeholder = "아이디"
            $0.isSecureTextEntry = false
        }
        alert.addTextField(configurationHandler: ) { (tf) in
            
            //회색 글 ( 이 tf가 뭘하는지 넌지시 알려줌
            tf.placeholder = "암호"
            
            // 비밀번호 처리
            tf.isSecureTextEntry = true
        }
        alert.addAction(ok)
        self.present(alert, animated: false)
    }
}

