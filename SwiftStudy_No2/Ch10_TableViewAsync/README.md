## 테이블 뷰 동작 원리 [동기 방식, 재사용 매커니즘, 비동기 방식(async),일반 ViewController에서 tableView 생성 방법]

🌱 동기 방식 : 컴퓨터에서 본다면, 특정 프로세스에게 주어진 임무가 끝나기 전까지는 cpu는 다른 요청된 프로세스라도 현재 프로세스를 완전히 수행하지 않으면 다른 프로세스를 수행할 수 없다. 
> ex) 버스는 중간에 서지 않는다. 특정 정거장까지 가야함, (원할때 내려주쎄용~하는 택시와 다름) 

### 🌱  테이블 뷰의 Cell은 tableView(_:numberOfRowsInSection:)의 반환값만큼 tableView(_:cellForRowAt:) 메서드가 실행될까?

> 반환값이 작다면 그 값만큼 테이블 셀 메서드가 실행되겠지만, 그 경우가 아니라면 답은 아니다!
> > 화면(뷰)에 보이는 당장 몇개의 테이블 셀만큼의 tableView(_:cellForRowAt:)가 호출되고,
> >
> > 이후에 추가적으로 만들수록, 이전에 만든 셀들은 재사용 큐에 들어간다.(의 반복)

✨ 재사용 매커니즘(Reuse Mechanism)이라고 한다.

---

### 🔭 재사용 매커니즘(Reuse Mechanism)

> 매번 셀이 화면에 보일 때마다 새로 메모리에 바인딩 되지 않고, 기존에 셀을 만들었다면 해당 셀을 재사용큐에서 빼서 사용하는 방식
> > tableView.dequeue.ReusableCell(withIdentifier: )

:white_medium_square: 네트워크를 통해 읽어온 데이터 중 특히 이미지의 경우

:black_medium_square: 용량이 클 수 도 있기에, async(비동기)방식이나 캐싱(cashing- 메모리에 저장되면, 메모제이션-dp?!! 을 통해 메모리에 이전에 할당된 주소를 저장)방법을 사용 하도록 하자~!!

---

### 🔭 비동기(Async) 방식 방식 

:black_medium_square: 비동기 방식은 동기 방식과는 달리, 컴퓨터에서 예를 들자면, 특정 프로세스에게 cpu가 할당되어 임무를 수행할 때 긴급한 프로세스의 임무 요청을 해야한다면 그 긴급 프로세스에게 cpu처리가 진행됨.
> ex) 식당에서 손님이 치킨을 주문하면 주방장은 치킨 요리를 하기 위해 기름이 대워지기 전까지 
> 
> "대기" 해야 하는게 아니라 물도 마시고, 화장실도 가고, 친구랑 전화 통화도 하고, 부족한 재고 주문도 하고,, 여러가지를 할 수 있다. 이걸 비동기라고 한다. 
> 
> 처음부터 끝까지 치킨 요리를 만들어야 하는게 아니라, 중간에 시간이 남을때(유휴~시간 이라고 함,,)
> 
>  그 시간동안에 멀뚱멀뚱 기다리는게 아니라 다른 작업을 할 수 있는 것을 의미한다.

:white_medium_square: 스위프트는 비동기 실행 함수를 제공한다.

:black_medium_square: 델리게이트 패턴 or 위에 비동기 실행 함수 DispatchQueue.main.async(execute: ) { 실행 내용 클로저로 } 사용한다.

---

### 🔭 일반 ViewController에서 tableView 구현 방법

<img width="416" alt="1" src="https://user-images.githubusercontent.com/96910404/165346530-0a3421b8-a62b-4362-819d-b35c09eb43ea.png">

:white_medium_square: cmd + shift + L 로 Tabie View 객체를 Scene에 추가한다.

<img width="298" alt="2" src="https://user-images.githubusercontent.com/96910404/165346572-c8f6b051-b948-4c06-9b2d-140433f948b6.png">

:black_medium_square: 따로 TableView Cell 프로토타입인 Table View Cell 을 cmd + shift + L 에서 추가한다. 이후 style 과 identifier를 설정하고,

:white_medium_square: tableView 객체를 추가했던, layout이 UITableViewController 가 아닌 다른,, 예를 들어 UIViewController등 이라면

:black_medium_square: tabieVeiw( ) 메서드를 사용하기위해

:black_medium_square: extension Scene클래스명 :UITableViewDelegate, UITableViewDataSource를 추가 후 원하는 tableView, Cell 관련 메서드를 구현하도록 하자~

<img width="423" alt="3" src="https://user-images.githubusercontent.com/96910404/165346574-1896b28f-4d06-47dd-be28-57a9d8636197.png">

:white_medium_square: 그 후 중요한 것이 ✨✨ 해당 table View 객체를 세그웨이로 해당 Scene 과 dataSource로 연결을 해야합니다.

:black_medium_square: 이렇게 하지 않으면 tableView(_:numberOfRowsInSection:), tableView(_:cellForRowAt:) 등 메서드가 호출이 되지 않는다!! + 테이블 뷰 터치에 관한 다양한 이벤트 처리 또한 불가능..!!
