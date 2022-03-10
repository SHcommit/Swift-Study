## 🤔viewDidLoad()와 viewWillAppear()차이

### 안녕하세요👋
꼼꼼한 재은씨 기본편 chapter5를 공부하다 viewDidLoad()와 viewWillAppear()가 궁금해져서 공부를 했습니다!!

---

### 🔭  viewDidLoad()란?

:white_medium_square: View Controller에 있는 view가 **처음** 메모리에 load될 때 실행되는 메소드

### 🔭  viewWillAppear()란?

:black_medium_square: VC가 화면에 표시될 때마다 실행되는 메서드

:white_medium_square: 다른 화면 갔다가, 다시 화면 되돌아 올 때 viewWillAppear()가 호출된다.

:black_medium_square: 데이터 업데이트 할 때 많이 씀.
