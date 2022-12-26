## TableViewController! [ 테이블 뷰 컨트롤러, 테이블 뷰, 프로토타입 셀, 재사용 큐 cell, 테이블 뷰 생성 방법, Content mode ]👋

<img width="632" alt="스크린샷 2022-04-23 오후 1 25 30" src="https://user-images.githubusercontent.com/96910404/164877826-e3aa946a-6a30-441a-977a-2c0145824650.png">

🌱 선택도(Cardinality)
> 특정 카테고리 선택시 나온 결과값 개수 적을수록 선택도가 높다!
> 
> 컨텐츠 분류가 잘 되있음을 뜻한다.

---

### 🔭 테이블 뷰 컨트롤러

<img width="591" alt="스크린샷 2022-04-23 오후 1 52 51" src="https://user-images.githubusercontent.com/96910404/164878265-cc8f4a73-ea1d-49e4-ba46-c22dbd1a62cc.png">

:white_medium_square: Root View 는 테이블 뷰이다(화면에 보이는 Scene 전체)

> **목록** 형식의 데이터를 화면에 표현할 때 많이 사용함  

:black_medium_square: TableView(최상위 루트 뷰) <- 테이블 뷰 셀(TableRow) <- 콘텐츠 뷰 

> 테이블 뷰 컨트롤러는 여러 개의 **테이블 뷰 셀**을 나타내는 **테이블 뷰**(Table View Controller당 ✨한 개의✨ TableView✨!!) 가 존재한다. main section.
>
> 테이블 뷰 안에 적절히 배치된 여러개의 테이블 뷰 셀(Table Row)들이 있는데 그 안에 보여지는 것은 콘텐츠 뷰이다.
> 
> Section은 테이블 뷰 셀들을 묶는 Group의 개념이다.

---

### 🔭테이블 뷰(Table View)

> 데이터를 테이블 뷰 셀에 추가할 때 테이블 뷰 셀이 동적으로 할당되거나, 정적으로 할당되는 두가지 경우가 있다.
> > Content에서 변경이 가능하다.

<img width="370" alt="3" src="https://user-images.githubusercontent.com/96910404/164878579-b516a463-2ed8-4abe-8e25-14c83b1b1775.png">

:white_medium_square: Static Cells : 정적 타입의 테이블 뷰

> 한번 개발자가 설정해두면 그 경우의 Cell만 화면에 표시됨. 셀이 추가되지 않고 고정될 때 사용
> > ex) 설정 화면의 테이블 뷰(맨 위의 사진)

:black_medium_square: Dynamic Prototypes : 동적 타입의 테이블 뷰

>  데이터가 매번 갱신되는 경우 
>  > 예를들어 OpenAPI를 사용하는 데 해당 데이터가 주기적으로 업데이트 되는 경우. 

---

### 🔭프로토타입 셀(Prototype Cell)

<img width="371" alt="스크린샷 2022-04-23 오후 1 26 00" src="https://user-images.githubusercontent.com/96910404/164877855-f3b84f8d-c31a-453f-954b-e8fbc207a0d5.png">

> 테이블 뷰 셀을 원하는 대로 쉽게 디자인할 수 있도록 해주는 객체!
> 
> 화면에 공간을 차지하지 않는다. (가상 틀)

:white_medium_square: Cell Content : 이미지, 텍스트 등 내용이 포함된다.
> 가변적임

:black_medium_square: Accessory View : 콘텐츠 뷰 정보 여부를 암시!!

:white_medium_square: ✨✨✨ 특정 프로토 타입 셀을 참조할 경우
> 해당 테이블 뷰 셀의 identifier을 선언해야한다! (id값 부여)

---

### 🔭 간단한 테이블 뷰 생성 방법

> tableView() 메서드에서 첫번째 매개변수는 특정 테이블 뷰 인스턴스를 알 수 있다.

:black_medium_square: tableView(_:numberOfRowsInSection:)
> iOS 운영체제에게 몇개의 tableViewCell이 생성되는지 알려줘야 한다.
>
> 이 메소드에 의해 테이블 뷰 행 수가 결정된다.

:white_medium_square: tableView(_:cellForRowAt:)
> 첫번째 메서드 반환 Int형 만큼 이 메서드가 실행된다.
> 
> 객체지향이므로 cellForRowAt 매개변수를 통해 특정행의 설정을 다르게 할 수 있다.
> > 특정 Cell을 알고 싶다면 고유한 ID값은 cellForRowAt을 통해 파악할 수 있다.
>✨**IndexPath.row**✨ 를 통해 알 수 있다.

:black_medium_square: tableView(_:didSelectRowAt:)
> 유저가 특정 행을 선택 했을 경우 이 메서드가 호출된다.
> 
> 마찬가지로 didSelectRowAt을 통해 특정 셀의 index를 파악할 수 있다.
> > 상세하게 보여주기 위해 present를 통한 화면 전환을 하거나, Alert, Dialog등 여러 기능을 구현할 수 있다.
> 
> 델리게이트 메서드이다. (콜백메서드)

---

### 🔭 재사용 큐를 사용한 Cell 구현

> dequeueReusableCell(withIdentifier:)

:white_medium_square: 특정 데이터를 모두 cell로 바로 할당해서 데이터 개수만큼 만들게 된다면. 상당히 비효율이다.

:black_medium_square: 해당 데이터가 약 5천개의 정보가 있다면 그 정보를 작은 휴대폰 화면에 cell로 할당을 한다면 얼마나 비 효율적인가!!!!

:white_medium_square: 그래서 재사용 큐(Resusable Queue)객체가 사용된다.

:black_medium_square: **화면에 당장 보일**, 필요한 테이블 행들이 우선 재사용 큐에 없다면,

:white_medium_square: 할당 후 페이지를 내릴 경우 위에서 할당되었던 특정 Cell들은 화면에서 없어지게 되는데, 

:black_medium_square: **이때 삭제되는게 아니라 재사용 큐에 대기한다**. 

:white_medium_square: 이후 재사용큐에 있을 경우 해당 데이터를 새로 할당하지 않고 꺼내 쓰는 방식!!

---


### 🔭 Content mode == basic 과 custom타입]

:black_medium_square: Content mode == basic타입
> 이 경우 Title, subTitle 등 textLabel을 지원한다.

<img width="250" alt="스크린샷 2022-04-23 오후 4 08 27" src="https://user-images.githubusercontent.com/96910404/164884298-4cb16e1d-2306-45b7-a7bf-d74de763e16a.png">

> 테이블 뷰의 basic만 달랑 사용하니 제목만 있어 뭔가 밋밋하다. 이 테이블을 대표하는 캡션과 여러 메뉴가 있으면 ?!
 

 :white_medium_square: Content mode == custom타입
 > 이 경우 개발자가 직접 Cell안에 Label이나 ImageView등을 추가해야 한다.
>
> 이때 특정 Cell안의 객체(label, imageView etc)를 제어하는 방법은
> > 객체에 태그 지정 or UITableViewCell을 타입으로 하는 커스텀 클래스를 만든 후 아울렛 변수를 선언해야 한다.(그냥 UITableView에 Cell안의 아울렛 변수 선언시 오류 발생)

:black_medium_square: 태그 지정시
<img width="590" alt="2" src="https://user-images.githubusercontent.com/96910404/164915033-bea7becb-6971-4e24-80f6-397f0994965d.png">

:white_medium_square: 결과

<img width="1123" alt="스크린샷 2022-04-24 오전 12 52 40" src="https://user-images.githubusercontent.com/96910404/164913516-e556de25-c163-4948-8520-c4f724a9befa.png">

> 커스텀으로 Cell안에 4개의 레이블을 넣었다. 
> > 커스텀Cell에서는 지정된 textLabel이 없기 때문에 각각 추가한 label에 태그를 통해 id값을 지정하거나, 아울렛 변수로 만들어 사용해야 한다.

:black_medium_square: 추가적으로 이미지까지

<img width="1056" alt="2 5" src="https://user-images.githubusercontent.com/96910404/164915035-50353169-0226-4f3c-9984-e3351df9b45a.png">
