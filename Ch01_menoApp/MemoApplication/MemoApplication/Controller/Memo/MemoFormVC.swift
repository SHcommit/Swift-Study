//
//  MemoFormVC.swift
//  MemoApplication
//
//  Created by 양승현 on 2022/06/06.
//

import UIKit

/**
 MomoList와 segue로 연결
 
    - Param subjecet : 제목 저장
    - Param contents : 사용자 글 작성 tevtView 객체
    - Param preview  : 이미지 미리보기
 */
class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    // MARK: - variable
    var subject      : String!
    let WarningAlert = warningAlert("내용을 입력해주세요", nil, .alert)
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview : UIImageView!
    
    // MARK: - eventHandler
    /**
     * 저장 버튼 클릭시 호출 메서드
     * TODO :
     *  1. 데이터 저장할 memoList 객체 생성.
     *  2. Appdelegate에 저장되어있는 배열에 append data
     *  3. Navigation을 이용해 이전 화면으로 되돌아간다.
     */
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.count != 1 else {
            self.present(WarningAlert.alert,animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title    = self.subject
        data.contents = self.contents.text
        data.image    = self.preview.image
        data.regdate  = Date()
        
        (UIApplication.shared.delegate as! AppDelegate).memoList.append(data)
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     카메라 버튼 클릭시 호출 메서드
     
     TODO :
        1. 이미지 피커 인스턴스 생성
        2. 인스턴스의 delegate를 현재 VC로 설정
        3. .allowsEditing 이미지 편집 허용
        4. 사용자의 입력 마다 발생하는 textViewDidChange()를 통해 제목 변경(최대 15길이)
        5. 화면 전환
     */
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker,animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.contents.delegate = self
        let bgImage = UIImage(named:"memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        
        textUI()
        
    }
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?)
    {
        let bar = self.navigationController?.navigationBar
        let ts  = TimeInterval(0.3)
        UIView.animate(withDuration: ts)
        {
            NSLog("\(bar?.alpha)")
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
}

//MARK: - func
extension MemoFormVC
{
    //이미지 선택시 호출되는 콜백 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey: Any]){
        self.preview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
    /**
      TODO: 사용자가 입력시 이 메서드 호출됨. 이 때 네비게이션 바 제목에 즉각적으로 표시
     
        - Param contents : 텍스트 string
        - Param length     : 15이전엔 글자 길이 else 15  return
     */
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length   = ( (contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location:0, length:length))
        self.navigationItem.title = self.subject
    }
    func textUI()
    {
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor   = UIColor.clear
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [.paragraphStyle : style])
    }
}
