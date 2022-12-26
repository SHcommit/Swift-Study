## 탭 바 컨트롤러 [ 수평적 관계, Container Controller, 관계형 세그웨이

![result](https://user-images.githubusercontent.com/96910404/165744792-de114fcd-e366-437b-b650-bfeec6228cd8.gif)

//스토리보드

<img width="1512" alt="스크린샷 2022-04-28 오후 6 30 51" src="https://user-images.githubusercontent.com/96910404/165744873-a33e6b92-2612-47c8-9cb9-fad19bcf459d.png">

`
 시작에 앞서 이번에는 전  ch11, ch10 tableView 구현보다 좀 더 간결하고, 알기 쉽도록 구현 했습니다.
`
`
 중복된 코드가 많아 코드 리뷰 따로 작성x. ch 11, 10, 8을 참고하면,,!!
`


🌱  수평적 관계
> 다른 VC에 상위이거나, 하위로 소속되어있지 않은 관계라 할 수있다.

🌱  Container Controller(컨테이너 컨트롤러) 
> 직접적으로 화면에 객체 표시x 그러나, 다른 뷰 컨트롤러를 유기적인 관계로 제어하는 역할을 하는 컨트롤러

//특징 

:white_medium_square: **수평적 관계**의 독립된 각 화면에 바로 접근할 수 있다.

> 독립된 한개의 Scene가 아니다. 특정Scene과 연결된 탭 바를 ✨화면 하단✨에 나열하여 다른 뷰 컨트롤러를 호출할 수 있다.

:black_medium_square: 스토리보드에서 대부분 맨 앞에 위치한다 ( Navigation Controller보다도 앞에,,)
> 여기서 네비게이션 컨트롤러를 통한 Scene 구현은 계층적인 구조를 갖는데, 이 사이에 tabBar가 낀다면 호출 관계가 이상해짐.
> > 따라서 먼저 Scene에서 탭바를 통해 특정 Scene를 이동했을 때, 네비게이션 바를 사용해 점점 부가적인 기능을 보여주는게 best of best!!
> 그래서 네비게이션 바 보다 스토리보드에서 앞에 있음

 수평 == 탭바. 
 계층구조 == 네비게이션 (교재p746)

:white_medium_square: 배지(알림) , more 탭 등 탭 바에 추가 가능함.

:black_medium_square: 탭 바는 관계형 Segue(Relationship Segue).
