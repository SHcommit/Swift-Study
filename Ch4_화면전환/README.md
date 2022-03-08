### Chapter4 화면을 전환하는 방법 !! Segue, present , Navigation  ,동기-비동기 방식, Unwind(화면복귀)

🌱화면 전환은 **소스코드**를 사용하거나, **스토리보드 위에서(segue)** 전환을 할 수 있다.

---

### 🔭 뷰 컨트롤러에서 다른 뷰 컨트롤러를 호출하여 화면 전환하기!!

> 이때 기존의 뷰 컨트롤러에서 화면 전환 될 뷰 컨트롤러를 호출 할 때 기존의 뷰 콘트롤러위에 얹혀지는 형식이다.
 
<img width="495" alt="present" src="https://user-images.githubusercontent.com/96910404/157259092-0e47a6b0-7eaa-474f-8055-a55297d1f7d0.png">

:white_medium_square: 전환될 때 기존의 화면 위에 얹혀진다.

:black_medium_square: 기존화면과 새로운 화면 사이에는 ViewController를 ✨참조✨할 수 있다.

:white_medium_square: present(_:animated:completion:)메서드를 사용하여 다른 뷰 컨트롤러를 호출한다!

:black_medium_square: 첫번째 매개변수에는 변환될 Scene를 스토리보드에서 찾아서 인스턴스화한 값이 들어간다.

:white_medium_square: 두번째 매개변수는 애니메이션 여부.

:black_medium_square: 세번째 매개변수는 화면 전환이 끝난 후 수행해야할 클로저, 함수가 들어간다.

> 이때 **비동기방식**을 사용하기 때문에 presnet(_:animated) 메서드가 완전히 끝났다고 해서 뒤이어 클로저가 작동되는게 아니다.
> 
> > 🔭 동기 방식 : 결과가 주어질 때까지 아무것도 못하고 대기(순차적임)
> 
> > 🔭 비동기 방식 : 결과가 주어질 때 시간이 걸린다면, 그시간동안 다른 작업!!

:white_medium_square: present(_: animate:)메서드를 사용해서 화면 전환을 한다면

> 원래 뷰가 V(iew)C(ontroller)1, 새로운 뷰를 VC2로 가정하고 VC1에서 present()메서드를 통해 VC2로 화면 전환했다면?
> 
> > VC2는 presentingViewController를 통해 VC1의 인스턴스를 참조할 수 있다.
> 
>  > VC1은 presentedViewController를 통해 VC2의 인스턴스를 참조할 수 있다!!

:black_medium_square: VC2에서 VC1로 돌아갈 때는 dismiss(animated:) 메서드를 써야한다.

> **누구에게 요청**을 해야 하는가? 원래 기존에 새로운 VC2를 호출한 VC1에게 dismiss권한이 있다. 
> 
> > VC2마음대로 못 내려간다는 말이다!!
> 
> 따라서 presentingViewController 를 통해 VC1의 인스턴스를 사용해 dismiss메서드를 써야한다.

:white_medium_square: dismiss된 VC2는 운영체제(Operation System)에의 해 메모리에서 해제된다

---

### 🔭 네비게이션 컨트롤러를 이용한 화면 전환

:white_medium_square: 네비게이션  컨트롤러는 계층(hierarchy)적인 성격을 띠는 콘텐츠 구조를 관리한다!!

:black_medium_square: 화면 전환이 발생하는 뷰 컨트롤러의 참조를 **Stack**으로 관리한다!

> Navigation Controller 는 구조를 관리한다! 
>  > 직접 콘텐츠를 담고 있진 않으나, 다른 뷰 컨트롤러들을 포함한다.
>  
>자신의 화면을 갖진 않지만, 이 컨트롤러를 갖는 모든 뷰 컨트롤러는 Navigatioin Bar를 생성한다!!

#### 🌱 네비게이션 컨트롤러 

:black_medium_square: 현재 표시되는 뷰 컨트롤러들을 **네비게이션 스택** 을 이용해 관리한다.(배열형식)


:white_medium_square: 스택 답게 최상위(top)에 위치한 화면이 현재 화면에 표시되는 뷰 컨트롤러이다.

:black_medium_square: 화면을 네비게이션 컨트롤에 추가할 때는 pushViewController(_:animated:)

:white_medium_square: popViewController(animated:)

:black_medium_square: 네비게이션 컨트롤러를 추가하면, ViewController(VC)에 네비게이션 아이템(Navigation Item)을 추가해야 한다.

:white_medium_square: 네비게이션 바 에 다음화면으로 가는 버튼을 추가하려면 Bar Button Item을 추가한다!!(in Navigation bar)

> 이때 일반 버튼을 네비게이션바에 추가하면 자동으로 Bar Button Item으로 변환된다. *일반 버튼은 네비게이션 바에 추가될 수 없어서 자동 변환이 되는것,,

:black_medium_square: 네비 바 버튼을 @IBAction처리 후 새로 전환되는 VC를 스토리보드에서 찾아 

:white_medium_square: stroyboard?.instantiateViewController(withIdentifier:)를 통해 인스턴스화한다.

:black_medium_square: ⚡self. navigationController?.pushViewController()⚡메서드를 통해 

:white_medium_square: 첫번째 매개 변수에는 인스턴스화 된 새로 전환될 VC, 두번째 animated 여부를 설정하면 끝!

:black_medium_square: 이후에 VC2에서는 네비 바를 추가하지 않아도 네비게이션의 계층적 성격때매 자동으로 네비게이션 바가 삽입된다.

:white_medium_square: 또한 뒤로가기도 자동으로 생성해준다.

> 만약 네비게이션.pushViewController()메서드가 아닌 present를 통해 
>
> 화면 전환을 한다면 VC2에서는 네비게이션 바가 붙지 않는다.

:black_medium_square: VC2에서 일반 버튼으로 뒤로가기 버튼을 만들었을 때, 

> @IBAction으로 연결 후 self.NavigationController?.popViewController(animated: true) 를 호출하면 된다.!!
> 
> // 참고로 popViewController(animated:) 메서드는 UIViewController를 반환한다.

## 🔭 좀 중요하다고 생각이 드는 Segue!!

- segue(세그웨이)란? 소스코드를 통한 화면 전환이 아닌, 화면과 화면!!

- 스토리 보드 안✨에서 이루어지는 화면 전환 방식이다!!

- > 아무런 소스 코드가 필요하지 않다!!

- 스토리 보드상에서 Segue로 연결된 각 화면의 표시는 -> 화살표로 표시된다!

- 출발지와 목적지!!

- Segue는 한쪽 통행만 가능하다.

> 호호.. 소스코드에서는 전환될 화면의 스토리보드상 인스턴스가 필요했지만
>
> Segue를 통한 화면 전환에는 뷰 컨트롤러 인스턴스 없어도 된다.
> >✨Segue가 실행되는 순간 스토리보드를 통해 세그웨이 출발, 목적지에 대한 인스턴스가 생성된다. 


//세그웨이 출발지 뷰 컨트롤러

**let** srcUVC = **self**.source

//세그웨이 도착지 VC

**let** destUVC = **self**.destination

:white_medium_square: 세그웨이의 목적지는 VC이지만 **출발점**에 따라
 
:black_medium_square:  액션 세그웨이

> 버튼 등이 출발점!!
>
>버튼을 통해 ctrl 드래그 -> 대상화면을 할 경우
> > present Modally 기능은 

> present(_:animated:)와 같은 기능이다. (현재 뷰 컨트롤러에서 새로운 뷰 컨트롤러를 얹는것)
> 
> Navigation Bar안에 있는 버튼을 통해 화면 전환을 하고 싶다면
> 
> Action Segue기능에서 **Show**를 사용하자!!
>
>> Q. 만약 출발점의 VC가 네비게이션 Controller라면????
>
> present Modally를 사용한 액션 세그웨이는 네비게이션 바가 없어지는데,
>
> Show를 사용한 액션 세그웨이는 네비게이션 바가 상속된다.
> 
> 만약 출발점이 일반 VC인데 Show를 사용한다면? == present Modally와 같아짐.

:white_medium_square: 메뉴얼 세그웨이 or 트리거 세그웨이

> 출발점이 뷰 컨트롤러!
>
> 메뉴얼(VC->VC) 세그웨이의 경우 preformSegue(withIdentifier:sender:)메서드를 쓰자
>
> 스토리보드의 VC위에 도크바에서 3가지의 아이콘 중 첫번째 !! 클릭 -> 다른 VC 로 컨트롤 드래그!! 
> present Modally 를 선택하면 뷰와 뷰 간 segue가 형성된다.
> > **이후에✨✨✨**
> > 화면 전환 시킬 **버튼을 만들고**!!! @IBAction 아울렛 변수로 선언후
> >
> > 원래 출발점에서의 VC에서 스토리보드 Segue Identifier값을 이용해
> >
> > self.performSegue(withIdentifier: <스토리보드 Segue Identifier>, sender : self)를 해야 비로소 화면 전환을 할 수 있다.


### 🌱 이 세그웨이 방식들은 wind(새로운 화면으로 전환한다!!)

---

## 🔭 Unwind (화면 복귀)

> 원래 있던 화면으로 돌아가기 위해 기존VC를 지목하는 화살표(segue)를 만들자!!
: 삐빅 오답입니다. 🤔 

Segue는 화면 전환이 시작될 때 목적지 VC에 대한 인스턴스가 생성되므로.. 

기존에 새로운 창을 띄워주고, 또 전화된 창에서 기존의 화면에 segue를 하면 기존 화면은 인스턴스가 2개가 되기 때문..
 
< 화면 복귀 방법>

- present Modally를 사용한 경우 dismiss(animated:)
- 네비게이션 컨트롤러 Show를 사용한 경우 popViewController(animated:)

*************************
- Segue에서 제공해 주는 Unwind Segue를 이용한 방법
- - 도크바(스토리보드 VC위 세개 이모티콘)에서 맨 마지막 이모티콘 Exit.

:black_medium_square: 1. 기존 VC1에 UIStroryboardSegue타입의 인자값 받는 @IBAction 정의✨. ( Unwind Segue 메소드)

> @IBAction func unwind(_ segue: UIStoryboardSegue){ }

:white_medium_square: 2. 새로운 VC2(전환될 화면)에 버튼을 만들고 Exit✨아이콘으로 드래그 (트리거 생성)

> 🔭트리거란?
> > 어떤 이벤트의 자동으로 실행되는 것을 뜻합니다.

:black_medium_square: 3. Exit로 트리거를 생성한 했기에, 1. 에서 생성한 메소드를 인식하고, 이를 찾아 Unwind Segue로 자동 생성✨ 해준다.


## 🔭 진짜 만약에 여러 화면을 이동한 상태라면 홈 화면으로 어떻게 전환할 수 있을까??? 

:white_medium_square: 마찬가지로 위의 Unwind방식을 이용해

:black_medium_square:   **첫번째 VC class에서 UIStoryboardSegue타입의 인자값을 받는 @IBAction func** 정의 후

:white_medium_square:  마지막화면에 버튼을 도크바의 Exit 아이콘과 트리거 형성 하면 된다. 

:black_medium_square:  이때 첫번째 VC에서 @IBAction func이름과 트리거 연결을 하면 됨,, 크으,,

:white_medium_square: @IBAction func 돌아갈 화면이름으로 지정하면알기좋음(_ segue: UIStoryboard){    }

### 🔭 커스텀 세그웨이 작성할 때?

:white_medium_square: 세그웨이 커스텀할 때는 UIStoryboardSegue를 상속받는 class를 만든다.

:black_medium_square: 세그웨이의 실행을 처리하는 perform()메서드를 오버라이딩한다!!

:white_medium_square: Scene-CustomSegue 파일 -> newSegue.swift보자!!
