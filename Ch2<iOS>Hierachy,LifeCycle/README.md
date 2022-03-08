##  mvc패턴, window와 Root ViewController관계, 코코아 터치 프레임워크 

안녕하세요👋
 

### 🔭 MVC 패턴
	chapter 1에 이어 다시 한 번 MVC패턴을 공부했습니다.
	
![ios_mvcPattern](https://user-images.githubusercontent.com/96910404/156876650-ffd166f4-e960-451b-9434-1c38d5890360.png)
(iOS에서의 MVC 구조)

:white_medium_square: Model 

> 비즈니스 로직, 앱의 **데이터** 담당!!
 
:black_medium_square: View 

> 화면에 출력되는 UI 담당!

:white_medium_square: Controller(대장)

> action(사용자의 입력)을 받아 Model에게 알려주거나, 입력 처리를 하고, 뷰로 결과 전달
> Model에서의 데이터 변화를 인식하고, View에 전달!! 혹은 데이터 처리를 함.

![draw](https://user-images.githubusercontent.com/96910404/156876648-8d0cc5b5-29ff-4e30-b2cd-2b343adc6728.jpeg)

MVC 패턴과 Window, (Controller 에 있는) Root View Controller..

:black_medium_square: iOS에서는 하나의 뷰 컨트롤러 아래의 한개의 루트뷰!를 관리하는 것이 MVC패턴의 기본 원리이다. 하지만 두개의 루트뷰를 쓴다면? It isn't mvp pattern

 ---
 
### 🔭  window란?

:white_medium_square: iOS에서 디바이스의 스크린을 빈틈없이 채우기 위한 객체

:black_medium_square: 항상 UI(UserInterface)표현 계층(hierarchy)에서 ✨**최상위**에 위치한다.

:white_medium_square: window는 직접적으로 콘텐츠(view)를 가지진 않는다!!

:black_medium_square: 내부에 배치된 뷰의 콘텐츠만 변경된다.

:white_medium_square: window는 모바일의 Screen에 뷰들을 표시한다.

:black_medium_square: iOS모바일에서는 한개의 window만 존재(테블릿의 경우 다중 화면 때매 여러개의 window 존재 O)

---

### 🔭  Root View Controller란?

:white_medium_square: 윈도우에서 지정한 한개의 뷰 컨트롤러(항상 루트 뷰 컨트롤러만 참조한다)
> 따라서 윈도우는 View를 직접 관리하지 않는다

:black_medium_square: 한개의 Root View**(최상위 계층)**를 갖는다
 > 이때의 루트 뷰는 항상 화면 전체를 채울 수 있는 크기를 유지한다.
 > 
 > 자신의 하위에 있는 뷰(SubView)를 참조한다.

:white_medium_square: 여러개의 SubView를 갖는다.
> SubView는 자신의 상위 View를 기준으로 레이아웃을 구성한다.
>
>컨테이너 역할

:black_medium_square: View를 관리한다

:white_medium_square: @IBAction 등 윈도우 객체로부터 이벤트를 전달받고 처리한다.

:black_medium_square: View의 콘텐츠를 사용자와 상호작용 할 수 있도록 필요한 컨트롤을 뷰 컨트롤러에 작성한다.

:white_medium_square: Root VC(ViewController)가 RootView를 참조하기에 모든 뷰에 접근 가능하다.

---

### 🔭  코코아 터치 프레임워크

>  UIKit , Foundation , WebKit 등 여러 하위 프레임워크를 지닌 상위 프레임워크이다.
> > 프레임 워크란? 기본구조, 정형화된 틀의 모음. 앱 제작시 좀 더 빠르고, 편리하게 제작할 수 있는 도구들.

🤔 UIKit 만 선언했는데 Int , Double 선언이 가능한 이유?
> 대부분의 상위 프레임워크는 하위 프레임워크를 통해 구현된 기능에 보다 구체적인 기능을구현한다!!
>  > 다시 말해 하위 프레임워크에 의존적이다!
