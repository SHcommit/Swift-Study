import UIKit

/**
 TODO : 이미지 설정 기능 in ProfileVC
 
 - Param <#ParamNames#> : <#Discription#>
 - Param <#ParamNames#> : <#Discription#>
 
 # Notes: #
 1. Date : 22.08.11
    -- 문제 --
    지금 Alert를 통해 특정 cell 클릭시 해당 type로 이미지 피커를 통해 불러오는데 Done버튼을 하면 튕긴다.
    에러 사유는 UIImage가 잘못된 타입으로 저장된다고 한다.
    --해결--
    UserInfoManager의 profile 연산프로퍼티 set을 통해 UserDefaults.standard에 값을 넣을 때 value를 .pngData()로 바꾸지 않아서 오류남 Data타입으로 바꿨어야 했어,,
 
 */
extension ProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.indicatorView.startAnimating()
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            //이건 UserDefaults.standard에 저장하는거
            //self.userInfo.profile   = img
            //이건 profileVC에 저장하는거
            //self.profileImage.image = img
            
            self.userInfo.newProfile(img, success: {
                self.indicatorView.stopAnimating()
                self.profileImage.image = img
            }, fail: { msg in
                self.indicatorView.stopAnimating()
                self.alertMainThread(msg)
            })
        }
        picker.dismiss(animated: true)
    }
    //사용자의 선택에 맞는 UIImagePicker가 실행되도록 하는 함수
    func imgPicker(_ source: UIImagePickerController.SourceType)
    {
        let picker           = UIImagePickerController()
        picker.sourceType    = source
        picker.delegate      = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    //프로필 사진 소스 타입 선택
    @objc func profile(_ sender : UIButton)
    {
        guard self.userInfo.account != nil else
        {
            self.doLogin(self.tableView)
            return
        }
        
        let alertVO = customAlertVO(title: nil, message: "사진을 가져올 곳을 선택해 주세요", style: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            alertVO.addBtn(title: "카메라", style: .default)
            {
                (_) in
                self.imgPicker(.camera)
            }
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            alertVO.addBtn(title: "저장된 앨범", style: .default)
            {
                (_) in
                self.imgPicker(.savedPhotosAlbum)
            }
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            alertVO.addBtn(title: "포토 라이브러리", style: .default)
            {
                (_) in
                self.imgPicker(.photoLibrary)
            }
        }
        alertVO.addBtn(title: "취소", style: .cancel, completion: nil)
        self.present(alertVO.alert,animated: true)
    }
    func addTapGestrueInProfileImage()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(profile(_:)))
        self.profileImage.addGestureRecognizer(tap)
        //user와 상호반응 true처리
        self.profileImage.isUserInteractionEnabled = true
    }
}
