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
    - Param dao        : 코어 데이터 Memo entity's dao
 */
class MemoFormVC: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - variable
    var subject : String!
    let WarningAlert = warningAlert("내용을 입력해주세요", nil, .alert)
    lazy var dao = MemoDAO()
    var contents: UITextView?
    var preview: UIImageView?
    var saveBtn: UIBarButtonItem?
    var pictureBtn: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSubview()
        setupTextViewDelegate()
        setupBackground()
        
    }

}


//MARK: - func
extension MemoFormVC: UIImagePickerControllerDelegate
{
    //이미지 선택시 호출되는 콜백 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey: Any]){
        guard let preview = preview else {
            return
        }
        preview.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: false)
    }
    
}

extension MemoFormVC: UITextViewDelegate {
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
    
    func setupTextViewDelegate() {
        guard let contents = contents else {
            return
        }
        contents.delegate = self
    }
}

//MARK: - SetupSubview
extension MemoFormVC {
    
    func setupSubview() {
        setupContentsTextView()
        setupPreviewImageView()
        setupRightBarButtonItems()
        setupContentsConstraints()
        setupPreviewConstraints()
    }
    
    func setupContentsTextView() {
        contents = UITextView()
        guard let contents = contents else {
            return
        }
        contents.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contents)
        
        contents.layer.borderWidth = 0
        contents.layer.borderColor = UIColor.clear.cgColor
        contents.layer.backgroundColor = UIColor.clear.cgColor
        
        let style = NSMutableParagraphStyle()
        contents.attributedText = NSAttributedString(string: "",attributes: [.paragraphStyle : style])
    }
    
    func setupPreviewImageView() {
        preview = UIImageView()
        guard let preview = preview else {
            return
        }
        preview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(preview)
        
    }
    
    func setupRightBarButtonItems() {
        setupSaveBtn()
        setupPictureBtn()
        guard let saveBtn = saveBtn, let pictureBtn = pictureBtn else {
            return
        }
        navigationItem.rightBarButtonItems = [pictureBtn,saveBtn]
    }
    
    func setupSaveBtn() {
        saveBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save(_:)))
    }
    
    func setupPictureBtn() {
        pictureBtn = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(pick(_:)))
    }
    
}

//MARK: - Setup subview's constraints
extension MemoFormVC {
    
    func setupContentsConstraints() {
        guard let contents = contents else {
            return
        }
        NSLayoutConstraint.activate([
            contents.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            contents.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            contents.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            contents.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)])
    }
    
    func setupPreviewConstraints() {
        guard let preview = preview, let contents = contents else{
            return
        }
        
        NSLayoutConstraint.activate([
            preview.topAnchor.constraint(equalTo: contents.bottomAnchor, constant: 10),
            preview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            preview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            preview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)])
    }
}

//MARK: - EventHandler
extension MemoFormVC {
    
    /**
     * 저장 버튼 클릭시 호출 메서드
     * TODO :
     *  1. 데이터 저장할 memoList 객체 생성.
     *  2. Appdelegate에 저장되어있는 배열에 append data
     *  3. Navigation을 이용해 이전 화면으로 되돌아간다.
     *  Date : 22.08.26
     *      코어데이터에 저장 이력 추가
     *      AppDelegate에 추가한 memoList 배열 사용 x  (영구 저장소 활용)
     */
    @objc func save(_ sender: Any) {
        
        guard contents?.text?.count != 1 else {
            self.present(WarningAlert.alert,animated: true)
            return
        }
        
        guard let cost = navigationController?.viewControllers.count else {
            return
        }
        
        guard let vc = navigationController?.viewControllers[cost-2] as? MemoListVC else {
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            NSLog("appDelegate error in MemoFormVC's save(_:)")
            return
        }

        var data = MemoData()
        setupData(data: &data)
        appDelegate.memoList.append(data)
        
        //영구 저장소에도 반영해준다.
        dao.insert(data)
        vc.listVM.append(data: MemoDataViewModel(memoData: data))
                         
        navigationController?.popViewController(animated: true)
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
    @objc func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker,animated: false)
    }
    
    override func touchesEnded(_ touches : Set<UITouch>, with event : UIEvent?) {
        let bar = navigationController?.navigationBar
        let ts  = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            NSLog("\(String(describing: bar?.alpha))")
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
    
}

//MARK: - setup logic
extension MemoFormVC {
    
    func setupData(data: inout MemoData) {
        data.title    = self.subject
        data.contents = contents?.text
        data.image    = preview?.image
        data.regdate  = Date()
    }
    
    func setupBackground() {
        let bgImage = UIImage(named:"memo-background.png")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
    }
}
