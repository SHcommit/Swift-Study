## 이번 장에서 해본 시도

🤔 교재와는 다르게 색다른 도전들을 했다.

---

<a href="url"><img src="https://user-images.githubusercontent.com/96910404/174410414-0ab1475e-e027-440e-9fc0-8aceac5240d0.gif" align="center" height="600" width="300" ></a>

---
:white_medium_square: 모든 변수에 옵셔널 부여, 강제 옵셔널 해제 연산자 사용x

:black_medium_square: 변수는 따로 Model을 통해 DTO클래스를 통해서 다루었다.

:white_medium_square: MVC 패턴을 사용했다.

:black_medium_square:  layz 키워드 사용하는것도 나쁘지 않네 init대신

:white_medium_square: DTO와 VO in Model

 - getter만 있는 경우 DTO
 - - setter 존재 시 가변,  
- - setter 비 존재 시 불변

- set기능까지 있는 경우 VO + 로직 포함 단 read-only

:black_medium_square: layer를 통해 shadow와 radius 적용

<img width="150" alt="1" src="https://user-images.githubusercontent.com/96910404/173125223-a0618a61-3f88-4da1-be27-3163172d6b99.png">

---

:white_medium_square: 코드 구현하면서 마주친 문제들....

 1. 클래스 내 선언한 옵셔널 타입의 변수를 함수의 매개변수에 넣을 때 그 매개변수가 참조값을 원한다면. 그때의 옵셔널 해제 방법  중 강제 해제 방법 이외의 방법이 있는가?
 2. view.addView()안에 클로저를 통한 임시 버튼과 present 메서드를 통한 화면 전환을 했다. 

> readViewContentDTO 클래스에서 우선적으로 실행해봤는데 성공했다.
> 
> 이후 모든 코드의 변수 타입을 옵셔널 타입으로 바꾸고 옵셔널 여부 체크를 하도록 코드를 리펙토링했다.
 
 - 이 문제를 해결하면서 왜 옵셔널 변수는 뒤에 ? 가 붙는지 다시 복습했다.

 - ! 옵셔널 강제 해제 연산자를 한 번도 안썼다. 앞으로 안 써가면서 공부 할 예정이다 +_+


:black_medium_square: 그 밖에 새로 도전해본 기능들


기존 코드
<img width="300" float:left alt="1" src="https://user-images.githubusercontent.com/96910404/172996579-2c4d854d-0cfe-40b1-b66c-d35a394e17b5.png">

이상태로 버튼 5개만 추가하면 viewDidLoad()가 겉잡을 수 없이 길어지기에 다른 방법을 도전해봤다.

1. 클래스 내부 멤버변수로 btn 버튼을 구현한다. 이때 타입만 명시해주고 초기화를 하지 않으면 생성자함수를 작성해주어야 하므로 디폴트로 UIButton() 을 통해 초기화 해주었다.
2. extension을 통해 커스텀 버튼 구현하는 구간을 만들고, 함수를 통해 커스텀 버튼이 실행 되도록 구현했다.
3. 버튼에 대한 이벤트 헨들러도 extension을 통해 구현했다.

<img width="200" align="left"  alt="2" src="https://user-images.githubusercontent.com/96910404/172996592-4f894b32-90e4-494c-8d27-16e2815200be.png">

<img width="200" align="left"  alt="3" src="https://user-images.githubusercontent.com/96910404/172996597-a49338cf-f8d5-453b-b44d-036dad042c30.png">

<img width="1435" alt="4" src="https://user-images.githubusercontent.com/96910404/172996599-76a7dfae-fd1e-470e-8ebb-b3d116cb788b.png">
</div>

추후 버튼을 많이 만들게된다면 DTO, VO 타입으로하는 클래스를 구현하면 좋겠다+_+

---

곧 바로 MVC 패턴을 통해 VO 를 사용했다.

<img width="1024" alt="settingContentVO" src="https://user-images.githubusercontent.com/96910404/174407039-5ea7ae8d-6f36-475a-86fe-791c80a75c99.png">

<img width="271" alt="MVC" src="https://user-images.githubusercontent.com/96910404/174407042-1c47fce2-b27a-4184-8bfa-f8649cee542b.png">
