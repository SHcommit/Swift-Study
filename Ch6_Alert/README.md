### 사용자에게 메세지 전달 방법 | UIAlertController , 로컬 알림 UserNotification, UILocalNotification ,싱글톤 , 로컬 알림 감지 방법(delegate)

---

🔭 싱글톤이란?

> : 전역(static)으로 접근 가능한 공유 클래스 인스턴스(한개의 객체를 여러 곳에서 호출)를 만드는 패턴이다.

🌱 서버점검, 장기간 미 접속 사용자에게 알림, 초대 메세지를 전달하는 방법에 대해서 다룹니다.

<img width="350" alt="사진1" src="https://user-images.githubusercontent.com/96910404/159112874-ce3f6aa3-345b-43a9-ba9f-1ffd672582be.png">
// 알림사진

> 알림을 통해 확인, 취소, 인 앱으로 들어가기 등 다양한 이벤트 처리가 들어간다.
>
>웹앱 알림의 단점은 웹이 실행 중일 때만 알람이 왔다는게 보인다.
>> 로컬, 서버 알림을 통해 보완. 이들은 push message 기능이다.

- 로컬 푸쉬 : 앱 내부에서 메세지 전달.

> 자주보는 알림이다. 

- 서버 푸쉬: 별도의 서버를 통해 APNs(Apple Push Notification Service) 애플 고유 메시징 시스템?에게 보낸 메시지가 네트워크를 통해 전달되는 방식 

> 공식 용어는 로컬 노티피케이션, 푸시 노티피케이션 이다.

>>company’s server generates push notifications, and Apple Push Notification service (APNs) handles the delivery of those notifications to the user’s devices.

---

### 🔭메시지 알림창 UIAlertController

> 앱 실행중 일 때, 사용자에게 메시지 전달하고 싶은 경우 + 의사여부를 입력받기 위한 경우 사용된다.
>
> 한개의 **뷰 컨트롤러**이다 ( 뷰 컨트롤간 화면전환을 통해 호출되어야 한다는 뜻)
>
>> 알림창과 액션 시트가 있다.

:white_medium_square: 알림창과 액션 시트의 차이는 모달형식 여부와 표현되는 화면의 위치입니다.

<img width="257" alt="사진2 알림창" src="https://user-images.githubusercontent.com/96910404/159112869-490fa216-f760-4318-9432-e53acf0f3a63.png">

> 알림창 : 모달형식(focusing) O , 화면 중앙에 표현됨
>> 텍스트 필드 추가 가능, 사용자의 선택을 입력 받을 때 주로 사용된다.

<img width="262" alt="사진3 액션시트" src="https://user-images.githubusercontent.com/96910404/159112866-5824e3af-012c-439d-a1b7-67c758bbce43.png">

> 액션 시트 : 모달형식 X, 화면의 하단에 표시됨
>> 텍스트 필드 추가 X, 여러개의 항목중 사용자가 선택하는 경우 사용된다.

:black_medium_square: 알림창이 실행될 때는 Asynchronize(비동기) 방식을 사용한다. ⚡**앱이 실행된다는 뜻** 

:white_medium_square: 알림창의 선언은  <a href="https://github.com/SHcommit/SwiftStudy_No2/blob/master/Ch6_Alert/MSG-AlertController/MSG-AlertController/ViewController.swift">여기를 클릭하세요</a> 

:black_medium_square: 알림창에는 TextField가 사용될 수 있다.

:white_medium_square:  알림창 객체**.addTextField(configurationHandler:)** 를 통해 선언할 수 있고,
이때 매개변수로 클로저를 사용하면서 tf를 정의할 수 있다.

:black_medium_square:  여러개의 tf를 순차적으로 위의 함수를 통해 추가할 수 있고, 호출방법은 처음에 추가한 tf(textfield)부터 

:white_medium_square: <알림창객체>.textfields?[0].text / <알림창 객체>.textfields?[1].text 등 호출할 수 있다.


---

### 🔭로컬 알림 

:white_medium_square: 앱 내부에서 만든 특정 메시지를 **iOS 알림센터**를 통해 전달하는 방법

> (주로) 앱 종료, 백그라운드 상태일 때 메시지 전달할 수 있다!!✨
> > 실행중일 때는 UIAlertController이용하고, 위의 상황일때 로컬 알림을 이용한다.

:black_medium_square: ✨**iOS 스케줄러**에 의해 발송된다.

> 앱 내부에서 알림 메시지 정의 후 iOS 스케줄러에 등록하면 특정 시각에 맞게  발송해준다!!

#### :white_medium_square: UILocalNotification에 대한 더 많은 정보는
> <a href="https://www.google.com/search?q=local+notification+in+iOS&rlz=1C5GCEA_enKR986KR987&ei=cFY1YqK4E_vh2roPr_Oq2Aw&ved=0ahUKEwiisM3xpdH2AhX7sFYBHa-5CssQ4dUDCA4&uact=5&oq=local+notification+in+iOS&gs_lcp=Cgdnd3Mtd2l6EAMyBAgAEBMyBAgAEBMyBAgAEBMyBggAEB4QEzIGCAAQHhATMggIABAIEB4QEzIICAAQCBAeEBMyCAgAEAUQHhATMggIABAFEB4QEzIICAAQBRAeEBM6BwgAEEcQsAM6BQgAEIAEOgQIABBDOgQIABAeSgQIQRgASgQIRhgAUPgNWIMYYKobaAFwAXgBgAG8AYgB3AaSAQMwLjeYAQCgAQHIAQrAAQE&sclient=gws-wiz">이 키워드를 토대로 찾아보자!</a>

:black_medium_square: 참고로 iOS 10 버전부터는  UserNotification 프레임워크를 이외는 UILocalNotification을 이용한다.

---

#### 🔭 UserNotification 을 이용한 로컬 알림.

:white_medium_square: import UserNotifications

:black_medium_square: UNMutableNotificationContent

> 알림 전달에 필요한 메시지 등 "기본적인 속성" 을 담음

:white_medium_square: UNTimeIntervalNotificationTrigger

> 알림 발송 조건!!(특정 시간대에 발송할 것이다~)

:black_medium_square: UNNotificationRequest

> 알림 요청 객체를 만든다 (인자값 : UntimeIntervalNotificationTrigger )

:white_medium_square:  UNUserNotificationCenter

> 수정 불가능함. (위에서 지정한 객체를 읽어 들일 수만 있음)
>
> 싱글톤 방식이다( 인스턴스 생성x) -> current()메서드를 통해 참조 정보만 가져온다.

### 🤔 로컬 알림 등록 요약!!

> 로컬 알림 구현하기 앞서 p391

:black_medium_square: 1. application(__:didFinishLaunchingWithOptions:)를 통해 알림 설정환경 등록하고

:white_medium_square: _2. UNUserNotificationCenter.current().getNotificationSettings { $0.authorizationStatus 상태가 .authorized인지 확인한다.}_

:black_medium_square: _3. 로컬 알림에 대한 콘텐츠를_

*  _nContent = UNMutableNotificationContent() 인스턴스를 생성하고, 정의한다._

*  _( 알람 떳을때 앱 아이콘 (빨간)+1 표시, 알람 제목(title) 내용(body), sound 등등._

:white_medium_square: 4. 이 알람 객체가 언제 호출 될 것인지 UNTimeIntervalNotificationTrigger를 통해 생성한다.

:black_medium_square: 5. UNNotificationRequest 를 통해 알림 요청 객체를 생성한다.

*  -> 3에서 정의한 알림 인스턴스를 좀더 명확하게 하는 느낌 (식별자 부여랑, 언제 호출될 것인지 등)

:white_medium_square: 6. 이렇게 5에서 생성한 진짜 알림 요청 객체를 

*  UNUserNotificationCenter.current().add(알림요청 객체) 로 등록한다!

*  이는 노피티케이션 센터에 알림 요청 객체가 추가되어, 추후 노피티케이션 센터는 iOS 스케줄링에 값 등록하고, 알림을 정해진시간에 발송시켜준다.

<a href = "https://github.com/SHcommit/SwiftStudy_No2/blob/master/Ch6_Alert/MSG-Notification/MSG-Notification/AppDelegate.swift"> 로컬 알림 설정 구현 클릭! </a>

---

### 🔭 사용자가 로컬 알림 클릭했을 때 감지 방법

:black_medium_square: AppDelegate 클래스에 UNUserNotificationCenter**Delegate** 프로토콜을 추가한다.

:white_medium_square: application(_:didFinishLaunchingWithOptions:)에서 

:black_medium_square: UNUserNoficationCenter.current()를 통해 인스턴스를 참조했다면, 그 참조한 인스턴스 ( = aCenter라고 가정)

:white_medium_square: aCenter.delegate = self 를 선언한다.

:black_medium_square: **앱 실행 도중에** 알림센터에 이벤트가 발생했을 시 userNotificationCenter(_:willPresent:withCompletionHandler:)메서드를 호출시킨다.

:white_medium_square: 이 메서드를 통해 사용자의 알림 클릭 여부를 알 수 있다.

:black_medium_square:  **사용자가 알림메시지**를 클릭했다면 userNotificationCenter(_:didReceive:withCompletionHandler:)를 통해 알 수 있다.
> 앱실행중 || 미실행 상태 여부 상관 x
> 
### 🔭 로컬 알림 예

<a href= "https://github.com/SHcommit/SwiftStudy_No2/blob/master/Ch6_Alert/MSG-Notification/MSG-Notification/ViewController.swift"> 데이트피커를 통한 로컬 알림 !! </a>

//추후 dispatchQeuue.main.async에 대해서 공부해보자!
