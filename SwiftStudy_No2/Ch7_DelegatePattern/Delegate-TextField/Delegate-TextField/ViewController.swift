//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 양승현 on 2022/04/22.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{

    @IBOutlet var tf: UITextField!
    
    @IBAction func confirm(_ sender: Any) {
        //tf 최초 응답자 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: Any) {
        //tf 최초 응답자 설정
        self.tf.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Do any additional setup after loading the view.
         ***
         **
         * 1. 텍스트 필드 사용자 정의 할 것.
         * 2. Delegate 패턴 사용할 것.
         */
        customTextField()
        //텍스트 필드 최초 응답자로 지정
        self.tf.becomeFirstResponder()
        //뷰 컨트롤러(이 클래스에 대한 Scene)가 텍스트 필드의 델리게이트 객체로 지정됨.
        //
        self.tf.delegate = self
    }
    
    private func customTextField(){
        /**
         * placeholder == 예시
         * 타입 영문
         * 키보드 스타일 == .dark
         * 리턴타입 Join (enter)말고
         * 텍스트필드 입력. x 면 값 return키 자동적으로 비활성화
         */
        self.tf.placeholder = "값을 입력하세요."
        self.tf.keyboardType = UIKeyboardType.alphabet
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark
        self.tf.returnKeyType = UIReturnKeyType.join
        self.tf.enablesReturnKeyAutomatically = true
        
        /**
         * 텍스트 필드 스타일
         *
         * 테두리 스타일  == .line
         * 수직방향 텍스트 정렬 == .center
         * 수평방향 텍스트 정렬 == .center
         * 테두리 색 다크그레이
         * 테두리 두께
         */
        self.tf.borderStyle = UITextField.BorderStyle.line
        self.tf.backgroundColor = UIColor(white: 0.87, alpha: 1.0)
        self.tf.contentVerticalAlignment = .center
        self.tf.contentHorizontalAlignment = .center
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        self.tf.layer.borderWidth = 2.0
    }
    
    private func customOverrideFunc(){
        /**
         * 텍스트 필드TextField(== tf) 편집 시작된 후 호출
         * tf 내용 삭제될 때 호출
         * tf 내용 변경될 때 호출
         * tf 리턴키 눌러졌을 때 호출
         * tf 필드 편집 종료될 때 호출
         */
        func textFieldDidBeginEditing(_ textField: UITextField){
            NSLog("텍스트 필드 편집 Begin");
        }
        func textFieldShouldClear(_ textField: UITextField)-> Bool{
            NSLog("텍스트 필드 내용 삭제")
            return true
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string : String) -> Bool{
            NSLog("텍스트 필드의 내용이 \(string)으로 변경")
            if Int(string) == nil{
                return true
            }
            else{
                return false
            }
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool{
            //할당 해제
            textField.resignFirstResponder()
            NSLog("tf 리턴키 눌러졌습니다.")
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool{
            NSLog("tf 편집 종료")
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField){
            NSLog("텍스트 필드 편집 종료됨")
        }
    }
}

