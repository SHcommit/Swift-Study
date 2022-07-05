## 이번 장에서 해본 시도

목차 

- 알림창의 커스텀 방법
- 이번 장에서 해본 색다른 도전들
 
 > 주 임무는 버튼을 클릭할 경우 addTarget(_:)을 통해서 alert 호출입니다.

1. 자주 사용되는 알림 구현 코드 객체화
2. ViewController에 몰린 버튼 변수와 lazy를 통한 초기 구현 코드, 알림창 커스텀 메서드 추가로 인해 길어진 코드 길이 리펙토링
3. 자주 사용되는 코드들 객체화를 통한 코드 리펙토링 in Model

---

### 🔭 알림창의 커스텀 구현 기능
	
![기본 알림창](https://user-images.githubusercontent.com/96910404/177367436-0682c4b3-b33d-4e91-8cd1-a9150d81d24a.png)

기본적인 알림창입니다.

커스텀은 title, message와 UIAlertAction 사이의 공간을 주로 커스텀합니다.

![알림창의 변형 예](https://user-images.githubusercontent.com/96910404/177367447-82a90dfb-ab7f-405a-abcb-3b3f26aa0e89.png)

기본적으로 이 빨간 공간에 커스텀을 할 수 있습니다.

버튼 또한 커스텀이 가능합니다.

![no title](https://user-images.githubusercontent.com/96910404/177367449-4970222a-8ea9-40f9-a7ed-18dbb6febc08.png)

title, message 를 nil처리할 경우 알림창 같지 않아 다양한 표현이 가능합니다.

---

###  🔭 코드를 구현하며 겪었던 불편한 점들

우선 중첩되는 코드들이 너무 많았습니다. 또한 ViewController에 lazy를 통한 버튼 변수 속성부여, alert 속성 부여, 커스텀 alert함수까지 구현하게 되니 코드가 너무 길어졌습니다.

이 동영상은 2개의 버튼과 alert, alert 커스텀 메서드 2개, @objc fucn 가 들어있는 코드입니다.
 
![ezgif com-gif-maker](https://user-images.githubusercontent.com/96910404/177372137-046a9236-ca0c-4992-bc17-d7a03ed4d46a.gif)



상당히 길었고, 코드 중간 중간마다 중첩되는 코드들이 너무 많았습니다. 

원래의 ViewController에는 변수 선언과 초기화 속성 부여, 커스텀 alert 메서드 정의,  버튼의 @objc func 안에 알람 구현과 커스텀 알람 구현메서드 호출을 통해 한개의 alert가 호출되는 코드들이 4개가 있었습니다.

따라서 저는 Model Group을 만든 후에 

자주 사용되는 alert와 버튼까지 CallAlertButtonVO 클래스에 초기 디폴트 값을 각각 부여할 수 있도록 설정했습니다.

![pattern](https://user-images.githubusercontent.com/96910404/177367473-3795e144-1a44-42d9-8fa4-27aa486cb875.png)

이후 이 CallAlertButtonVO클래스를 멤버 변수로 하는 커스텀 클래스 ex) CustomImageAlertVO 클래스를 통해 커스텀 클래스로 구현을 했습니다. 

그 결과 매번 사용되었던 let alert = UIAlertController(title:message:preferredAction:) 과 UIAlertAction의 반복 구현과 button의 초기 frame, fontstyle 등은 이제 CallAlertButtonVO 를 맴버변수로 단 한번만 초기화 하면 자동으로 초기 디폴트값으로 초기화 됩니다.

다음은 리펙토링 이후 ViewController의 상황입니다.

![리펙토링이후](https://user-images.githubusercontent.com/96910404/177371147-b96b661e-77ec-463d-aaa8-57ef45163e73.gif)

많이 가독성 있게 되었고, 추후 특정 로직 구현은 손 쉽게 Model의 커스텀 클래스 or 디폴트 알림,버튼 클래스를 통해 추가 구현이 가능해졌습니다.

결과입니다.

![결과](https://user-images.githubusercontent.com/96910404/177371122-6c33ae45-36db-455b-8088-20f9e2334d38.gif)
