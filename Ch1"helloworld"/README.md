### Chapter01 시작하기에 앞서👋
가장 많이 다루었고, 근본인 **MVC패턴**과 **ViewController**과 **인터페이스 빌더**의 연관성을 잊고 있었습니다..

---

🔭  **MVC패턴**

:white_medium_square: 기본적인 화면 구성은 여러 UIView를 window에 담아서 Screen 에 보내고, Screen은 기기에 출력한다.

:black_medium_square: 여기에는 가장 많이 다루었던 **ViewController**가 존재하지 않는다.

:white_medium_square: UIView와 리소스 관리를 위해 ViewController 객체가 만들어 진 것이다. 

:black_medium_square: 한개의 ViewController 안에 여러개의 View가 존재하기 때문에 이에 대한 리소스 또한 ViewController에서 다루어 져야한다. 

:white_medium_square: 이것이 ViewController가 해야할 일이다.

:black_medium_square: 이 역활은 모두 UIViewController에 정의 되어있다.

:white_medium_square: 따라서 UIView 객체가 바로 windows에 얹혀지는 게 아니라 ViewController에 얹혀지고, ViewController가 window에 전달되어야 한다.

:black_medium_square: 이때 window에 화면의 정보를 전달하는 ViewController는 루트 뷰이다!!!!!

- 따라서
	- MVC 패턴이란?  
> window에 UIView를 보내기 전 뷰와 리소스 전체를 담당할 객체를 **ViewController**로 정하자!
> 
> 이제 한개의 프로젝트를 구성할 때 Model, View, Controller 세개의 구성요소를 갖도록 하자!
> 
> window에 뷰 객체를 바로 할당하지 말고, ViewController를 할당시켜 첨부된 뷰들만 화면에 추가하자!!

---

🔭  **ViewController는 인터페이스 빌더 사용해 '스토리보드'라는 형식의 '파일'을 만든다!!**
