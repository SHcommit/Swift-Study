기존 코드
<img width="964" alt="1" src="https://user-images.githubusercontent.com/96910404/172996579-2c4d854d-0cfe-40b1-b66c-d35a394e17b5.png">

이상태로 버튼 5개만 추가하면 viewDidLoad()가 겉잡을 수 없이 길어지기에 다른 방법을 도전해봤다.

1. 클래스 내부 멤버변수로 btn 버튼을 구현한다. 이때 타입만 명시해주고 초기화를 하지 않으면 생성자함수를 작성해주어야 하므로 디폴트로 UIButton() 을 통해 초기화 해주었다.

<img width="891" alt="2" src="https://user-images.githubusercontent.com/96910404/172996592-4f894b32-90e4-494c-8d27-16e2815200be.png">

2. extension을 통해 커스텀 버튼 구현하는 구간을 만들고, 함수를 통해 커스텀 버튼이 실행 되도록 구현했다.
<img width="948" alt="3" src="https://user-images.githubusercontent.com/96910404/172996597-a49338cf-f8d5-453b-b44d-036dad042c30.png">

3. 버튼에 대한 이벤트 헨들러도 extension을 통해 구현했다.

<img width="1435" alt="4" src="https://user-images.githubusercontent.com/96910404/172996599-76a7dfae-fd1e-470e-8ebb-b3d116cb788b.png">

추후 버튼을 많이 만들게된다면 DTO 타입으로하는 클래스를 구현하면 좋겠다+_+

---

layer를 통해 shadow와 radius 적용

<img width="429" alt="1" src="https://user-images.githubusercontent.com/96910404/173125223-a0618a61-3f88-4da1-be27-3163172d6b99.png">

---
