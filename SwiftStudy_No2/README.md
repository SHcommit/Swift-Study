# SwiftStudy_No2

### 안녕하세요~👋

- 꼭 읽어주세요!!

✨**꼼꼼한 재은씨의 Swift 기본편**✨  복습 기록용 Repository입니다.

---

:gift: 각 챕터마다 프로젝트아래 README.md 파일에 중요한 핵심 개념을 정리했습니다.

🔭 특정 함수에 대한 간단한 코드 리뷰를 작성할 것입니다.

◽ 실전편 이전에 MVP 패턴 정확하게 이해하기

◼️ iOS App Life cycle 복습하기

◽ 애매하게 알고 있었던 오토 리사이징, 레이아웃 

◼️ 자주 사용된 Tab bar 등 
	
전체적으로 복습할 것입니다.
	
 🌱  Date : 2022.03.02 ~ 22.4.28 ( 영상처리 과제가 중간에..ㅠ)

<div align=center><h2> 📗 Book cover </h2></div>

![b2](https://user-images.githubusercontent.com/96910404/156351366-ff68962d-dc09-4e21-8118-71add9b8df38.jpeg)

<div align=center><h2> 📇 Info </h2></div>

### 💡 <a href="https://github.com/SHcommit/Swift-Study/blob/master/SwiftStudy_No2/Ch1%22helloworld%22/README.md">chapter 1 </a>

 ◽ MVC 패턴
 
 ◼️ 스토리보드(.storyboard)를 사용하는 이유?
 
 ◽ 포그라운드(foreground) 상태란?
 
 ---
 
 ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch2%3CiOS%3EHierachy%2CLifeCycle" >chapter 2</a>
 
 ◼️ 사진 첨부된 MVC 패턴이란?!
 
 ◽ window와 Root ViewController의 관계
 
 ◼️ 코코아 터치 프레임워크(대장)
 
 ---
 
 ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch3_outletVariable" target="_blank">chapter 3</a>
  
 ◽ 어노테이션 ( @ )
 
 ◼️ @IBAction과 @IBOutlet ( 아울렛 변수) 란?
 
 ◽ ARC란? - 링크 참고
 
 ---
 
 ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch4_%ED%99%94%EB%A9%B4%EC%A0%84%ED%99%98" target="_blank">chapter4 화면을 전환하는 방법</a>
 ◼️ Segue, present(_:animated:)

 ◽ Navigation을통한 화면 전환
 
 ◼️ Unwind(화면 복귀)

 ---
 
  ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch5_submitValue" target="_blank"> chapter5 다른 뷰 컨트롤러에 데이터 전달하는 방법</a>

 ◼️ 동기, 비동기 방식

 ◽ prev VC -> nextVC로 직접 전달하는 경우 
 
 > Use present(_:animated:) or Manual Segue or Navigation Controller.
 
 ◼️ 반대로 다음화면에서 이전화면으로 값을 update하려면?

 ---
 
  ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch6_Alert" target="_blank">chapter6 사용자에게 메시지 전달 방법</a>
  
  ◼️ 싱글톤이란?
  
  ◽ 메시지 알림창 UIAlertController
  
  ◼️ 로컬알림 UserNotification, UILocalNotification
  
  ◽ 사용자가 로컬 알림 클릭했을 때 감지 방법

  ◼️ 로컬 알림 예
  
  ---
  
   ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch7_DelegatePattern" target="_blank"> chapter7 델리게이트 패턴의 사용</a>
  
  ◼️ 델리게이트(delegate : 위임하다!!) 의미
  
  ◽ 디자인 패턴
  
  ◼️ 델리게이트 패턴이란?
  
  ◽ First Responder(최초 응답자)

  ◼️ 이미지 피커(UIImagePicker)
  
  ---
  
  ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch8_TableView" target="_blank">chapter8 TableView</a>
  
  ◼️ 테이블 뷰 컨트롤러
  
  ◽ 테이블 뷰
  
  ◼️ 프로토타입 셀
  
  ◽ 재사용 큐 cell

  ◼️ 테이블 뷰 생성 방법
  
  ◽ Content mode
  
  ◼️ 이미지 처리와 캐싱
  
  ---

### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch9_RESTAPI" target="_blank">chapter9 OpenAPI를 통한 TableViewCell 구현</a>
  
  ◼️ CURD
  
  ◽ RESTful
  
  ◼️ 파싱
  
  ◽ Json 방식

  ---
 
### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/blob/master/Ch10_TableViewAsync/README.md" target="_blank">chapter10 테이블 뷰 동작 원리</a>
  
  ◼️ 동기 방식
  
  ◽ 재사용 매커니즘
  
  ◼️ 비동기 방식(Async)
  
  ◽ 일반 UIViewController 를 참조한 Scene ( not UITableViewController) 에서 tableView 생성 방법

  ---
 
### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch11_WebView" target="_blank">chapter11 웹 브라우저 호출 방법</a>
  
  ◼️ 웹 뷰( Web View)
  
  ◽ 인 앱 브라우저 (In-App Browser)
  
  ◼️ 웹 브라우저 호출 4가지 방식
  
  ◼️ 비동기 방식(Async)
  
  ---
  
  ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch12_TabBar" target="_blank">chapter12 탭 바 컨트롤러</a>
  
  ◼️ 수평적 관계
  
  ◽ Container Controller
  
  ◼️ 관계형 세그웨이
  
  ◼️ 비동기 방식(Async)
  
  ---
  
  ### 💡 <a href="https://github.com/SHcommit/SwiftStudy_No2/tree/master/Ch13_mapKit" target="_blank">chapter13 맵킷 프레임워크</a>
  
  ◼️ 번들 프로그램
  
  ◽ 번들 애플리케이션
  
  ◼️ Segue 데이터 전달 복습
