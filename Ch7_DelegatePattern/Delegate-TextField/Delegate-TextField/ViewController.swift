//
//  ViewController.swift
//  Delegate-TextField
//
//  Created by 양승현 on 2022/04/22.
//

import UIKit

class ViewController: UIViewController {

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
         */
        customTextField()
        //텍스트 필드 최초 응답자로 지정
        self.tf.becomeFirstResponder()
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
    
}

