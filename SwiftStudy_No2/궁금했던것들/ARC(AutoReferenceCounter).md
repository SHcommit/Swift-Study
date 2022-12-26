## 🤔ARC(Auto Referencing Counter)

### 안녕하세요👋
꼼꼼한 재은씨 기본편 chapter2를 공부하다 ARC가 궁금해져서 공부를 했습니다!!
> 참조 카운터는 이전에 공부하다 한번쯤 들어봤는데,, 이번기회에 자세하게!!

---

### 🔭 Auto Referencing Counter를 공부하기 전에!

🌱 Value Type 과 Reference Type에 대해서 알아야 합니다.

:white_medium_square: Value Type : Structure, Enum, Tuple ...

> 스택에 저장된다. 
>
> 스택의 경우 메모리에 저장된 데이터 자동으로 삭제된다.

:black_medium_square: Reference Type  : Class, Clousre ... 
> 힙에 저장된다.
>
>힙의 경우 특정 인스턴스가 필요하지 않을 경우 개발자가 직접 제거 해야한다.

🌱 Reference Counting 에 대해서 알아야 합니다

> 인스턴스를 가리키는 프로퍼티가 한개 이상 존재 할 경우 메모리에 유지된다.
>
> 인스턴스를 가리키는 프로퍼티가 한 개도 없을 경우 메모리에서 제거되는데,
> 제거될 시점을 파악하기 위해 참조중인 변수들을 counting한다.
>
> 이때 Reference Counting은 오직 **reference Type**✨ 에 대해서만 지원됩니다.

### 🔭 ARC

:white_medium_square: 더 이상 필요로 하지 않는 클래스 '인스턴스'의 메모리 저장을 해제할 수  있다.

:black_medium_square: 클래스를 만들게 된 후에 **한개의 인스턴스**를 만들면 **ARC**가 **인스턴스 정보에 대한 한 덩어리를 메모리에 할당**시킨다.

:white_medium_square: 또한 해당 인스턴스와 연관되어 저장된 프로퍼티도 메모리에 ARC에 의해 할당된다.

:black_medium_square: **더 이상 인스턴스가 필요 없을 경우** ARC는 메모리에 사용된 **인스턴스를 해방**시켜 그 자리에 다른 목적으로 사용될 수 있게한다.
> 클래스 인스턴스가 더 이상 필요하지 않을 경우 공 간을 차지하지 않도록 빈 공간으로 보장해준다.

---

### 🤔 만약 인스턴스가 사용중일 때 ARC가 할당을 해제한다면?

> 에러가 발생할 것이다.
> 
> **🔭 그렇다면 인스턴스가 필요로 할 때 사라지지 않는 것을 보장하려면???**
> > 적어도 1개의 활동중인, 여전히 존재하는 인스턴스에 대해서는 할당을해제하지 않는다.
> 
> 이 때 활동중인, 여전히 존재하는 인스턴스는 **Reference Countring**을 통해 파악할 수 있다.

### 🔭   ARC가 적절하게 메모리에 할당, 해제 시키려면?

:white_medium_square: 인스턴스에 대해서 **"Strong"**  reference(강한 참조)로 할당을 하자!! 

> Strong 참조는 해당 인스턴스를 "확고하게 유지시켜 줄거야!!"
> > 참조중인 동안은 할당 해제 하지 않을 거야!! (Reference Counting)

- iOS는 ARC를 통해 메모리 관리를 한다.
- 인스턴스 메모리 관리는 Reference Counting을 통해 이루어진다.

---

![1](https://user-images.githubusercontent.com/96910404/156913171-75d05fb0-383f-4c8e-ae37-8758d2a1a3b3.png)
###  🔭Strong Reference Cycles Between Class Instance
![2](https://user-images.githubusercontent.com/96910404/156913177-7dae526f-cebe-4a12-8e5d-06b662c58a4b.png)
> 강한 참조 간에 Cycle 형성하는 경우 ( 참조 카운트가 어디서 0이 되는지 코드에서 얻을 수 없도록 클래스를 작성한 경우)
>  > 각 클래스에서 서로 다른 인스턴스 멤버변수 간 Strong 참조를 할 경우.
![3](https://user-images.githubusercontent.com/96910404/156913178-a8dceeca-1d42-486c-8340-00ee173e3de2.png)
 ### 🤔 이 경우를 String Reference Cycle이라고 한다. 
 
 > ARC는 강한 참조간 인스턴스 해제를 하지 않아서 참조 카운트가 증가, 감소하지 않고, 개발자가 직접 nil 처리를 해주어도 강한 참조가 해제되지 않는다.
  
:white_medium_square: 이 경우 해결방법이 있다!! ( 두가지)

:black_medium_square: 인스턴스 멤버변수 들 간 Strong 참조를 하는 변수들 중 한개를 **Strong** 대신 **weak , unowned** 참조로 바꾸면 강한 참조 cycle을 해결할 수 있다.
![weak](https://user-images.githubusercontent.com/96910404/156913181-005d9410-756b-484f-b854-f19e49059163.jpeg)
### weak 키워드!

:black_medium_square: 약한 참조weak의 경우 **Optional** type로 선언한다!
![4](https://user-images.githubusercontent.com/96910404/156913179-8730a8cb-6cf1-4bd7-96d5-10a6b04a5195.png)
:white_medium_square: 서로 강한 참조 만드는 것을 미룬다.
> 인스턴스간 서로 강한참조 cycle 되는 것을 예방할 수 있다.
>  > 강한 싸이클이 되는 해당 프로퍼티 선언하기 전에 **weak** 키워드 선언하자
>  
>  그렇다면 다른 프로퍼티가 할당 해제 됬을 경우 reference 되고 있는 weak 프로퍼티에 대해서 
>
> ARC✨가 자동으로 nil(인스턴스 할당 해제) 처리를 한다.
![5](https://user-images.githubusercontent.com/96910404/156913180-2d0c7ab5-2b04-4e01-9c84-ebc08bb202a8.png)
//사진 2
:black_medium_square: 강한참조로 연결된 A에 대해서 nil 처리를 할 경우

:white_medium_square: 더이상 A B 간에 강한 참조가 없어져 B 또한 nil처리가 된다!!

정말 자세한 예시는

https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
