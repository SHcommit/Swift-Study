## Chapter5 다른뷰 컨트롤러와 데이터 전달하는 방법!! (동기 : present(_:animated:), segue, navigation ... , 비동기 방식)

- 대부분의 VC(ViewController)에서이전 Scene(화면)과 다음 화면은 서로 **계층(hierarchy)적인 관계**를 갖고 있다.
> ex) 네비게이션바, TableView...

- 계층적인 구조를 이루는 prev VC와 NextVC간 데이터 전달 방법에는 

### 🔭 1. prev VC에서 next VC로  직접 데이터를 전달하는 경우
> 동기 방식
 
 - present()로 화면 전환시,
 - Navigation Controller를 이용한 화면 전환 시,
> 화면 전환시 Navigation Controller에서 요구되는 함수
> > NavigationController?.pushViewcontroller(_:animated:) 전달될 데이터,, 함수에서 정의하자
  
 
### 🔭 2. 공통 저장소에서 값을 저장한 후 next VC에서 값을 가져오는 경우 

> 비동기 방식

가 존재한다!!
 
---

### 🔭  1. prev VC에서 next VC로  직접 데이터를 전달하는 경우


:white_medium_square:  1. VC1에서 VC2에대한 인스턴스를 갖고 있어야 한다.

> instantiateViewController(withIdentifier:)을 통해 VC 인스턴스 생성

:black_medium_square: 2. VC2에서는 VC1에서 전달될 데이터를 받을 변수가 미리 **명확하게** 생성되어 있어야 한다.

:white_medium_square:  3. VC1에서 참조중인 VC2의 인스턴스를 이용해 VC2의 변수에 값을 전달한다!!

> 이때 화면에 표현되기 위한 변수는 @IB아울렛변수인데, 이 변수는 VC1에서 직접적으로 VC2.특정 아울렛 변수로 값 대입을 할 수 없다.
>  >  **다시말해  ✨아울렛 변수 ✨는 외부 객체에서 직접 참조할 수 없도록 제한 되어있다**  

:black_medium_square: 따라서 값을 대입할 프로퍼티를 추가적으로 정의 해야 한다.(VC2에서)

### 🔭이번엔 반대로 VC2에서 VC1로 (이전화면)으로 데이터를 전달하려면?

:white_medium_square: 만약 present(_:animated:)를 이용했다면

> presentingViewController 인스턴스를 통해 VC1에 아울렛이 아닌 일반 변수를 생성하고 전달하면 된다.
> 
> 이후 dismiss(animated:)
 
---

### 🔭 VC1과 VC2간 Segue를 통한 값 전달도 가능하다!!

- Manual Segue를 통한 값 전달 방법!!
> 화면과 화면을 이어주는 Segue == ManualSegue

//사진1

:white_medium_square: 도크바 첫번째 아이콘 ctrl클릭 -> 원하는 VC에 드래그

:black_medium_square: 화면과 화면은 눈빛⚡으로만 페이지를 넘길 수 없으므로 **버튼을 생성 후** @IBAction 함수를 만든다!

:white_medium_square: 위의 버튼을 클릭했을 때 위의 사진에서 정의했던 Segue를 실행할 수 있도록 Segue를 찾아준다.

> ex) **self**.performSegue(withIdentifier: "<VC1-VC2간 연결된 세그웨이 이름>", sender: **self**)

:black_medium_square: 이후 Segue가 실행되기 전에 발생하는 전처리 메소드 prepare(for:sender:)를 통해 데이터를 전달하면 끝!

- 참고로 Segue는 storybaord!.instantiateViewController(_:withIdentifier:)를 통해VC2의 인스턴스를 생성하면 안된다.

- Segue가 실행될 때는 이미 출발(VC1), 목적지(VC2)의 인스턴스가 만들어 지기 때문이다. 

- 이때는 prepare(for: sender:)메서드를 통해 출발지, 목적지에 대한 인스턴스를 얻을 수 있다. 

- segue.source // 출발지

- segue.destination // 목적지
