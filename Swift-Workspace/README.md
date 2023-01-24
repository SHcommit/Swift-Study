# Swift-Workspace

## 로컬 알림 UserNotification
앱이 실행 중일 뿐 아니라, 앱이 종료되어있을 때도 '알림'을 발송할 수 있다. 이 점이 UIAlertController과 다른 점이다.
- 로컬 알림은 **한개의 프레임워크**이다. //import UserNotifications

그래서 앞에 UN이라는 줄임말이 붙는다. UserNotifitcation에서 가장 중요한 객체는
1. UNMutableNotificationContent	
	- *Mutable*이란 단어가 많이나온다 ( 변할 수 있는). 
	- 알림의 기본적인 속성()을 추가할 수 있기에 Mutable 이란 단어가 붙는다.  알림 메세지 이름 내용 등 UIAlertController()같은 느낌.
2. UNTimelntervalNotificationTrigger // 시간 간격!! Trigger
	- 알림 발송(시간) 조건 메서드이다.  (몇 분 후, 몇 번?) . 입력 단위 : 초
3. UNNotificationRequest
	- 2에서 좀 더 구체적으로 시간까지 지정한 알림에 대해서 UNNofiticationRequest의 인자값으로 할당한다. 그렇게 된다면 알림 요청 객체가 생성된다.
4. UNUserNotification**Center**
	- 수정 불가. 오르지 (구현한) 객체만 읽을 때. == 등록된 알림 콘텐츠를 찾으려면 MutableNotificationContent를 사용해야 한다.
	- 이 객체는 **싱글턴** 방식으로 동작한다.
		- 싱글 턴이란
			-  : 전역(Static)으로 접근 가능한 공유 클래스 인스턴스(한개의 객체를 여러 객체에서 호출_reference) 만드는 패턴.
	- 위에서 만든 알림 에 대해서 current( ) 메서드를 통해 참조 정보를 가져 올 수 있다. 

이외의 객체 UNCalenderNotificationTrigger 
	: 특정 시각에 알림 전송하고 싶을 경우 사용된다.

## 프레젠트 메서드로 화면 전환
- call View Controller // 프레젠트 메서드 이용한 경우.
이 경우는 `present 메서드를 사용한 화면 전환은 기존의 뷰 컨트롤러VC1을 그대로 둔 채 그 위에 새로운 뷰 컨트로러VC2의 화면을 덮는 방식!`
//화면 전환시
	- present(_: animated:) 메서드를 사용하는 방법.
-> 첫번째 인자값 == 화면 전환될 new View Controller
-> 두번째 인자값 == 전환 시 애니메이션 여부
//이전화면으로 되돌아갈 때
	- dismiss(animated:)
**이전화면**으로 되돌아간 다는 것은. 기존 화면을 덮고 있던 새 화면을 걷어낸다. *이후 걷어낸 화면의 뷰컨트롤러는 운영체제에 의해 메모리 해제된다.*

다시 말해서. VC1 에서 present(_: animated:) 메서드를 통해 VC2를 화면에 표시해주었다면. VC2가 화면에서 사라질 때도 **VC1의 권한**이 있어야 한다.

`아니.. 이전화면 없어지고, 이미 새로운 화면으로 온거 아니야? `
> 틀렸습니다.

VC1에서 VC2로 전환될 경우. VC1은 VC2(새로운 화면)에 대해서 presentedViewController을 통해서 현재 화면에 출력되고 있는 VC2에 대한 참조를 할 수 있다.

VC2에서 VC1로 화면 전환될 경우, VC2는 VC1(현재 출력되는 Scene)에 대해서 presentingViewController을 통해서 참조할 수 있다.

다시 말해 새로운 화면으로 전환되어도 서로 참조가 가능하다는 말은 이전화면이 없어지면 참조가 될 수 없다는 말..

`그렇다면 VC2인 화면에서 VC1로 화면 전환은 어떻게 할까?... `
VC2일 경우 presentingViewController속성을 통해 VC1을 참조할 수 있음으로, *VC1 뷰 컨트롤러에 대해서 새로운 인스턴스를 생성하지 않고도* VC1을 참조하고 있는 presentingViewController을 이용하면 쉽게 VC1의 정보를 알 수 있다!! 돌아가기도 쉽다는 말씀. 

`그렇다면 VC2인 화면에서 presnet메서드를 이용해서 VC1을 호출하면 안되는가? `

> 안됩니다. 이미 참조되고있는 VC1이외에 새로운 VC1이 화면을 덮는 것이기 때문에 (new)VC1 , VC2 , (old)VC1 이 세개의 장면이 겹치게 됩니다. (이전의 VC1은 메모리 해제가 되지 않고 남아있다. why? presentingViewController?.dismiss(animated:)메서드를 통해 VC1을 부르지 않았으니까..)

- VC2에서 돌아가는 방법?
`printingViewController 속성을 이용해서 뒤로간다는것은 알겄는디 우째 써야해? `
	- 버튼을 추가하자!! 그리고 @IBAction을 통해 VC class에서 메서드로 연결해서 뒤로가기 기능을 구현하면 되자너~
`VC2 (새로운화면) 에 대한 클래스가 object C로 구현되어있다. 뭐지?`

이럴때는 해당 object C로 구현된 UIViewController를 상속받는 클래스를 정의하고, 해당 클래스 명을 VC2 뷰 컨트롤러 속성에서 커스텀 클래스 명으로 등록하면 된다잇!@ 
 그 후 presentingViewController (VC1 참조중) 이거 써서 dismiss.. 알지? 
 

**//요약**.
**// (화면을 덮는것이다! 기존 VC 존재한다! 사라지지 않는다.)**
// 화면 전환 present(_ : animated:) //이전 화면 복귀 dismiss(animated:)
**//차이점은 presnet메서드는 새로운 뷰 컨트롤러에 대한 인스턴스를 필요로한다.** 
// present를 통해 화면 전환 할 경우 presnetedViewController (새로운 VC 참조) , presentingViewController (원래 VC 참조 가능) 속성이 생기고. 이전화면 복귀 시 presentingViewController을 통해 dismiss를 사용해야한다.
`(물론 present 메서드를 쓰기 위해선 인스턴스가 필요한데, 이는 stroyboard에 존재할 것이고, instantiateViewController메서드를통해 새로운 VC의 Storyboard ID값과 일치하는 뷰 컨트롤러를 찾고, 이를 인스턴스화한다!)....
(그리고 또 한가지.. storyboard는 옵셔널 타입이어서 . nil값일 경우 인스턴스 생성되지 않게 옵셔널 바인딩을 적용 하도록!`

---

## Segue
Date : 20.01.14
// 스토리보드(인터페이스 빌더)에서 **뷰 컨트롤러** 사이의 연결 관계, **화면전환**을 하는 역활이다.
이전에 공부했던 Navigation Controller에서 루트 Navigation Controller가 해당 뷰 컨트롤러한테 붙는 화살표 또한 (관계형)세그웨이다.
//세그웨이는 출발지와 목적지가 존재한다.
// 세그웨이를 이용할 경우 뷰 컨트롤러에 대한 정보가 없어도 된다. 
 => 즉 뷰 컨트롤러 class에서 대상 객체의 인스턴스를 생성하지 않나도 된다는 말이다.
- - - 왜 ??
- - - - `세그웨이는 목적지인 뷰 컨트롤러의 인스턴스를 자동으로 생성하기 때문이다. 이러한 특성때문에 Segue를 통한 화면 되돌아가기는 사용하면 오류가 발생한다. (기존 ViewController가 하나 더 생성되거든,,== 뷰 컨트롤러의 인스턴스는 하나 이상 존재하면 안된다!!)`

 // 사용자의 이벤트를 전달받아 화면 전환의 매개체 역할을 한다! (but 코드 구현을 하지 않아도 된다. 그것이 장점. 하지만 장점이자 단점인 것은 기능이 제한되어있기에 custom으로 Segue를 구현하는 방법이 있다.)
//사용법 ctrl ->대상 ViewController

//장점 : 화면전환 대상을 파악하기 쉽다.


- action Segue
- Unwind //되돌아가다. 복귀
되돌아갈 VC(ViewController)에 @IBAction 액션 메서드 unwindToVC( _ segue: UIStoryboardSegue){} 메서드를 작성후 되돌아가려는 새로운 VC에 버튼만들고  exit 와 트리거 연결하면 **우리가 정의한 unwind 메서드를 선택할 수 있다?**how?
- - ->`그 이유는 우리가 이전에 만들었던 메서드중 UIStoryboard타입의 인자값을 받는 액션 메서드를 모두 수집하기 때문에 선택할 수 있는 것이다.. 대박...`
//이를 이용해서 특정 페이지로 되돌아갈 수 있다. 되돌아갈 원하는 특정 페이지에 UIStoryboard를 인자값으로 하는 unwind 액션 메서드를 정의하고 마지막 페이지나 특정 페이지에서 exit 와 트리거연결하면된다. 참고로 이때 특정 페이지에 되돌아갈려면 해당 Viewcontroller에 대한 ViewController class 정의해야 하는거 알지? ㅎㅎ
- custom Segue
- 전처리 메서드(prepare for segue: UIStoryboardSegue, sender: Any?){}

## action Segue

> 다른 말로 트리거 라고 한다. ( **터치, 클릭 event** 발생시켜 세그웨이를 실행할 수 있는 요소!

위에서 표기한 사용법으로 present 화면전환 효과도 나타낼 수 있다.
( Action Segue -> Present Modally) // 뷰 컨트롤러 자신이 새로운 화면을 불러들이도록 처리.

내비게이션 컨트롤러 관련 뷰 컨트롤러라면 Action Segue -> Show 옵션을 선택할 경우 Navigation controller 효과가 부여된다. (내비게이션 바에 뒤로가기 버튼 생성)
-> 만약  내비게이션 컨트롤러와 관련이 없는데 Show 옵션을 선택할 경우에는 그냥 Present Modally 화면전환이 적용된다.


## custom Segue

이 경우는 UIStoryboardSeuge를 상속받는 클래스를 정의한 후에, 그 클래스 안에 *override func perform() {}* 메서드를 구현하는 것이다. 구현할 때 출발지, 목적지를 정해주어야 한다! 참고로 이들의 타입은 UIViewController이다.

또한 전처리 메서드 prepare의 경우 세그웨이가 실행되기 이전에 특정 메서드(prepare)을 호출 할 수 있게 한다.

근데 prepare(전처리 메서드)의 경우 여러 세그웨이가 공유?!한다 (static 느낌..) 근데 인자값으로 segue: UIStoryboardSegue를 통해 어떤 뷰 컨트롤러가 호출하는지 알 수 있으므로 switch문 등 조건문을 통해서 특정 세그웨이가 호출 될 경우 이에 대한 특별한 처리를 하고 싶으면 하면된다!


---

## UIAlertController

앱 사용자에게 알림 메세지를 전달 할 때![:bowtie:](https://github.githubassets.com/images/icons/emoji/bowtie.png ":bowtie:")(똑똑)
## 알림창이란?

사각형의 박스 안에서 알림 문구의 메세지와 함께 확인, 취소 등 버튼을 통해 의사표현 하는 창
- UIAlertController : **앱 안**에서 특정 메세지를 알림 형식으로 전달 할 때!
	- 액션 시트 ( 모달 형식 x) _ 버튼을 세로로 배치
	- 알림창 (모달 형식 o ) _ 버튼을 가로로 배치
### :star::star::star:모달(modally)형식이란?
- 특정한 화면이 모달 형식으로 열렸을 경우 그 화면이 닫히기 전 까지는 다른 부분의 화면, 창은 반응할 수 없는 형식. ( 사용자는 버튼을 통해 해결해야 한다)




## UIAlertController 특징
- 사용자와 상호작용하는 용도로 자주 사용된다(yes or no)
- 경고, 확인 문구의 알림 메세지가 전달 되기도 한다.
- UIAlertController는 :sparkles:**ViewController**:sparkles: 의 일종이다. 
	- 즉 알림창을 나타낼 때는 present(_:animated:)메서드를 통해 뷰 컨트롤러를 화면에 present 해야한다.
- **알림창**(모달 o)을 만들 경우 UIAlertController의 세번째 매개변수 preferredStyle에 UIAlertController.Style.alert 를 입력한다.
	- alert . 알람창
		- 모달 형식이다.
=> 알람창 **뷰 컨트롤러**:star: 화면이 출력되면, 알람창이 **포커스 온** 되서 알람창 에서만 이벤트 발생과 이에 대한 변화가 발생된다. 
- **액션 시트**(모달 x)을 만들 경우 UIAlertController의 세번째 매개변수 preferredStyle에 UIAlertController.Style.actionSheet 를 입력한다.
	- 만약 세번째 매개변수 **prefferedStyle**에 인자값을 할당하지 않을 경우 **디폴트값**으로 **actionSheet** 스타일이된다.  
### :star::star::star::star: UIAlertAction 알림창 안에 버튼을 추가할 때
UIAlertAction(title: "<버튼 이름>", style: <버튼 실행 타입>,handler : nil )<or { ( _ ) in ... } // 클로저>
- 첫번째 인자값에는 버튼 이름
- 두번째 매개변수 style에 대한 인자 값은 버튼 실행 타입
	- case .default
		 - 일반적인 버튼 .default
	- .cancel
		 - 이때 cancel은 알림창 내 **한번만** 사용 가능하다
	- .destructive
		- 중요한 내용 변경, 삭제될 때의 버튼에 적용시킨다. 이때 색은 빨간색:exclamation:이다.
- 세번째 매개변수 handler는 사용자가 버튼을 클릭했을 때 세번째 매개변수에 전달된 클로저가 실행된다. 
	- 여기서 메세지 창의 text구문 내용도 바꾸고 다양한 작업 가능.

UIAlertAction 인스턴스 생성후 

알람객체.addAction( <UIAlertAction인스턴스>) 인스턴스를 알람 객체에 추가 한다.

그 후 **화면 전환**을 한다! 

**UIAlertController 또한 ViewController의 일종**이기 때문이다. self.present(알람객체, animated: false)

그러나 삭제할 때는 dismiss(animated:) 구현 x 해도 된다. 버튼 클릭시 창 자동으로 닫히기 때문.

//추가적으로 앱이 시작될 때 알림창을 띄우고 싶다면
 1. viewDidLoad()
 2. viewDidAppear(_:)
어느 곳에 알림 변수를 선언해야 할까?

2 번 viewDidAppear(_:)에 해야 한다. 

1번의 경우 런타임 에러가 난다. ( 초기 화면 구성이 되지 않은 상태에서 present() 화면전환을 시도했기 때문.

따러서 viewDidAppear()에 해야햔다.

### 참고로 런타임과 컴파일의 개념이란?
- 컴파일 : 개발자가 입력한 소스 코드를 기계어로 변환되는 과정(실행 가능한 프로그램이 된다.)
- 런타임 : 컴파일 이후 사용자에의해 실행되고, 프로그램이 동작된다.


## 알림창 선언, 출력하는 코드 
https://github.com/SHcommit/Swift-Workspace/blob/master/AlertControllerStudy/AlertControllerStudy/ViewController.swift



---

###  다른 뷰 컨트롤러에 데이터 보내거나 받는 방법.

대부분의 뷰 컨트롤러는 이전화면과 그 다음화면이 계층적인 관계를 갖는다.
*ex) 앞에 **VC(ViewController)** 가 상위 내용을 갖는다면, 다음 VC는 상위내용중 특정 주제에 대한 하위 내용을 갖는 구조이다.*

## 화면 전환과정에서 값 전달하는 방법
- 이전화면에서 다음화면으로 값을 주고 받을 경우

case 1: 이전VC에서 다음VC로 값을 **직접 전달**한다.
**직접 전달 방법(동기 방식)**
ex)화면이 전달 될 때 값을 주고난 이후의 데이터가 필요 없는 경우
 주로 직접 전달 방식을 사용한다.
// 저장소를 통한 값을 저장, 꺼내오는 방식보다 코드가 *간결하기* 때문
> 이 방식의 경우 
> 전달 받는 VC 또한 전달 받기 위한 지역 변수를 **미리** 생성해 두어야 한다.
> 서로 다른 VC간 **아울렛 변수 끼리는 데이터를 바로 주고 받지 못한다.**
> 따라서 값을 보낼 VC는 반드시 받는 VC에 대한 정보!!!인스턴스를 가지고, 받는측의 VC는 이전 VC에서 값을 몇개 보낼 것인가?에 대해 받을 변수를 미리 선언해야 한다.
> 
case 2: 이전VC와 다음VC가 **공통 저장소**를 갖는다. ex) github
ex) 지속적으로 값을 저장할 필요가 있을 경우.
**로그인 정보** 처리를 할 경우. 화면이 이동한 이후에도, 계속적으로 갖고 있어야 할 정보이다. 매번 화면의 전환 때마다 정보를 프로그래머가 갱신한다면 ㅎㄷㄷ 쉽지 않을 것이다.
ex) 메모 데이터,
> 공유 저장소를 쓰기 전, 이전VC와 다음 VC간 모두 저장소의 위치를 **사전에 공유**해야 한다. 
> 값을 직접 전달x 공유 저장소에 저장하기 때문에 받는VC에서는 이 저장소로 접근 해야 한다.

- 주의사항 
	- 아울렛 변수는 외부에서 값을 직접 대입할 수 없다. 시스템에 의해 값이 주입된다. 또한 아울렛 변수는 *외부 객체에서 직접 참조할 수 없도록 제한* 되어 있다. 
그래서 프로퍼티에 값을 저장하는 것이다.

//viewWillAppear = 뷰 컨트롤러의 뷰가 화면에 표시 될 때마다(다른화면으로 기존화면 가렸다 다시 기존화면 출력될 경우에도) 이 메서드가 호출된다.
//맨 처음  뷰 컨트롤러가 화면에 나타날 때에도 호출이된다. 이 경우 viewDidAppear( ) ->viewWillAppear( )가 차례로 호출된다.

## case 1: VC에 값 직접 전달 (일회용 느낌?)

1. 위에서 말했지만, 보내는 측VC에서는 전달해야 할 값들을 명확하게 선정하고,
받는 측VC에서는 명확하게 선정된 값의 개수만큼 프로퍼티를 미리 정의해 두어야 한다.
이때 prevVC와 nextVC간 값의 개수는 동일해야 한다.
2. VC1에서 VC2로 값을 전달하기
우선 값을 전달하기 위해서는 VC1에서 VC2의 프로퍼티를 참조할 수 있도록 VC2에 대한 인스턴스를 갖고 있어야 한다.
이때 let nextVC = self.storybaord?.instantiateViewController(withIdentifier: <두번째 클래스 스토리보드ID> ) as? <두번째VC 클래스명> 라는 코드를 통해
두번재 VC에 대한 인스턴스를 생성할 수 있다.
> instantiateViewController 메서드는 인자값으로 받은 스토리보드 ID값을 self.storyboard?자신의 스토리 보드에서 찾아서 인스턴스화 한다. 이때 **UIViewController 타입으로 인스턴스가 생성**된다. 하지만!!!
> 내가 생성한 두번째VC는 UIViewController를 상속받는 자식클래스로 구현되어 있기 때문에, 내가 구현한 프로퍼티들을 UIViewController에서는 사용할 수 없다. 오직 UIViewController 멤버속성만 사용할 수 있다. (업 캐스팅된 인스턴스라는 말이다. )
> 따라서 **다운캐스팅** 을 해야 한다.

3. 특정 함수가 실행됬을 때 위 1,2 과정을 거치게 되면 VC2는 지금 VC1의 값을 넘겨 받았다. 하지만 전달 받은 값들을 화면에 출력해야 한다면 어느 시점이 best of best?
=바로 화면이 메모리에 로드되고 난 직후!!!!
viewDidLoad( )메서드를 호출한다. 이 함수를 쓰자!
// iOS는 특정 타이밍에 따라 메서드를 자동으로 호출해준다. 화면이 메모리에 로드되고 난 시점에는 viewDidLoad( )메서드가 호출된다. 따라서 여기에 VC2의 아울렛 변수에 VC1로부터 대입 받은 값을 대입하면 되는 것이다.

다운 캐스팅을 마친 후에는 해당 인스턴스를 가지고 특정 프로퍼티에 값을 대입하면 된다.
	 
// Q> 그렇다면 이전 VC에 값은 어떻게 전달해? .. 

만약 present를 통해 값을 전달할 경우 이전 인스턴스는 self.presentingViewController를 사용하면 되고,
위에서**presenting~ 이나 presented~ 메서드는** 인스턴스에 대해서 UIViewController타입으로 인스턴스를 리턴한다!!!!


내비게이션 컨트롤이라면 self.navigationController>.viewController를 사용하면 된다.
그리고 VC1은 이전 화면으로 돌아가게 된다면 화면이 새로 생기는 것이 아니라!! 화면이 새롭게 그려질 때 호출되는 **viewWillAppear( )메서드**를 사용해야 한다. ( 그 후 VC2는 소멸된다! )
## case 2: 직접 값 주고 받기
저장소까지는 아니지만 앱이 시작되고, 종료되기 전가지는 AppDelegate.swift 단 하나만 존재하고**(싱글톤)**, 여러 뷰에서 쉽게 접근가능하기 때문에 이 방식을 사용한다. 근데 앱이 종료되면 AppDelegate에 저장한 정보는 모두 소멸됨,, 그래도 저장소 개념과 비슷하기에 이것을 중심으로 설명을 해본다.



이전VC에서 값을 전달해야할 개수만큼 AppDelegate에도 프로퍼티로 정의를한다. 그 후에 
let ad = UIApplication.shared.delegate as? AppDelegate
AppDelegate는 프로그램이 실행 될 때 생성되므로 하나의 생성된 인스턴스를 참조 해야 한다. 이것이 바로 싱글톤의 개념. 설마 ~~깃 허브?~~ 
UIApplicatoin.shared를 통해 현재 생성된 인스턴스를 참조해야 한다.
ad 인스턴스를 통해 VC1값을 전달-> ad -> VC2하고 받으면 된다.

하지만 앱 종료하면 데이터 소멸.
 따라서 더 좋은 방법
### UserDefaults 인스턴스를 이용하는 방법!
let ud = UserDefaluts.standard
//UserDefaults는 시스템에서 자동으로 생성하고, 제공되는 단일 객체이다.(설마 너도 싱글톤 느낌인가??)
// UserDefaluts.standard 프로퍼티를 통해 UserDefaluts 인스턴스를 ud 상수에 저장한 후에, set(_:forKey:)메서드를 사용해 값을 저장한다.
ex) ud.set(self.<아울렛변수(textfield이라한다면)>.text, forKey: "myParam")
set은 집합. = 중복허용x
따라서 forKey에의한 데이터 1개가 저장된다. 만약 이를 호출할 경우
ex)
	ud.set(self.email.text, forKey : "myParam") //email은 text field이다.
	let email = ud.string(forKey: "email"); // ud.<저장된 타입>(forKey : )를 통해 호출하는 방식이군+_+
	//저장된 값의 타입에 맞는 메서드를 사용하면 바로 읽어올 수 있다는 것이다!!!!



