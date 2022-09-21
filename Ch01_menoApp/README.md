# MemoApp Refactor

### Date 22.07.30 오늘의 돌발 문제 상황

책에서 처럼 깃 오픈소스로 sideBar를 사용하지 않고 직접 만들었다.

TODO : SideBar의 firstCell을 클릭시 FrontVC(memoListVC)에서 memoFormVC(작성글) 로 이동해져야한다.

이렇게 이동하기 위해선 FrontVC 인스턴스가 필요한데, 마침 RevealVC는 FrontVC, sideBarVC둘다 제어하기 위한 컨테이너 컨트로러이므로 RevelVC 인스턴스만 SideVC에서 얻어오면 된다.

그렇게 얻어왔는데 아래 동영상처럼 됬다 ㅋㅋ. sideVC를 없애야한다.

<img src="https://user-images.githubusercontent.com/96910404/181824739-bfa97ad0-1375-4d82-9226-68b71efe3c5b.gif"  width="200" height="400"/>

해결법은 간단했다. 우선 sideBar의 인스턴스를 제거하면서 끝난 경우에 complete를 통해 memoForm을 호출하면 된다..

<img src="https://user-images.githubusercontent.com/96910404/181827527-bd3a1c14-3d6e-4f23-986d-f16010284ce7.gif"  width="200" height="400"/>


## Date 22.09.21 앞으로 해야 할 것

### 리펙터링 목표
 
> MVC패턴으로 구현한 MemoApp을 MVVM Architecture을 적용할 것입니다.
> Udemy로 추가 공부했던 AutoLayout과 VM을 도입할 것입니다.

### TODO List:

- Storyboard에 있는 Control들 전부 프로퍼티로 변경하고 AutoLayout 적용.
- MVC -> MVVM으로 구현
- 각 Controller마다 구현된 Container Delegate의 메소드 data를 ViewModel로 쪼개어 구현
- RESTful API url 을 private로 바꾸고 .gitignore에 추가하기
- Model에서 Codable 프로토콜 도입.
- Alamofire로 호출하는 타입 decodable로 바꾸기

