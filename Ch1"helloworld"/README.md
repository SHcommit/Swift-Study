### Chapter01 시작하기에 앞서👋
가장 많이 다루었고, 근본인 **MVC패턴**과 **ViewController**과 **인터페이스 빌더**의 연관성을 잊고 있었습니다..

---

🔭  **MVC패턴**

:white_medium_square: 기본적인 화면 구성은 여러 UIView를 window에 담아서 Screen 에 보내고, Screen은 기기에 출력한다.

:black_medium_square: 여기에는 가장 많이 다루었던 **ViewController**가 존재하지 않는다.

:white_medium_square: UIView와 리소스 관리를 위해 ViewController 객체가 만들어 진 것이다. 

:black_medium_square: 한개의 ViewController 안에 여러개의 View가 존재하기 때문에 이에 대한 리소스 또한 ViewController에서 다루어 져야한다. 

:white_medium_square: 이것이 ViewController가 해야할 일이다.

:black_medium_square: 이 역할은 모두 UIViewController에 정의 되어있다.

:white_medium_square: 따라서 UIView 객체가 바로 windows에 얹혀지는 게 아니라 ViewController에 얹혀지고, ViewController가 window에 전달되어야 한다.

:black_medium_square: 이때 window에 화면의 정보를 전달하는 ViewController는 루트 뷰이다!!!!!

- 따라서
	- MVC 패턴이란?  
> window에 UIView를 보내기 전 뷰와 리소스 전체를 담당할 객체를 **ViewController**로 정하자!
> 
> 이제 한 개의 프로젝트를 구성할 때 Model, View, Controller 세개의 구성요소를 갖도록 하자!
> 
> window에 뷰 객체를 바로 할당하지 말고, ViewController를 할당시켜 첨부된 뷰들만 화면에 추가하자!!

---

🔭  **ViewController는 인터페이스 빌더 사용해 '스토리보드'라는 형식의 '파일'을 만든다!!**

🔭 시작화면 LaunchScreen.storyboard은 **Splash(스플래쉬)**라고도 불린다.

:white_medium_square: 여기서 .storyboard 도 눈여겨 봐야하는게,,

:black_medium_square: Main.storyboard는 내가 구현한 앱 UI 가 있고

:white_medium_square: LaunchScreen.storyboard는 시작화면 스토리보드가 있다.

:black_medium_square: 이전 세대와 달리 storyboard는 화면을 하나의 파일에 모아 설계 할 수 있는 **UI 설계용** 파일 형식이다.

:white_medium_square: 서로 연결되는 여러 화면(Scene)이 한개의 storyboard파일로 구성된다.

:black_medium_square: 이때 한개의 Scene에서 계층 구조 파악하려면 옆에 창봐잇!!(contentView)

### :bulb: **스토리 보드를 사용하는 이유?**

> VC마다 분리된 UI파일을 만들지만, 하나의 스토리보드(한개의 도화지)에 여러 화면 사이의 관계? 뷰 컨트롤러의 연결 관계를 포함하는 전체 화면 구성을 정의 함으로 앱의 전체 구조를 쉽게 파악 가능하기 때문!!
>
> 한 화면에서 다른화면으로 전환하기 위해 적상해야 하는 코드 또한 줄어들기 때문!!(segue 방식)


