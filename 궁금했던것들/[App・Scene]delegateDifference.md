## 🤔 AppDelegate.swift VS SceneDelegate.swift

### 안녕하세요👋
✨**Swift 공부를 할 때마다**✨ 항상 궁금했었습니다. 

> (뭐지,, appDelegate는  앱 시작될 때 화면 LaunchScreen에 관련해서, 앱 데이터 정리 관련 다루긴 했지만 SceneDelegate.swift는 뭐지? - 🌱Swift공부 2달째.. - )

🔭 MVP 패턴을 공부하다 UIWindow와 window의 차이가 궁금해졌고, AppDelegate.swift 와 SceneDelegate.swift가 궁금해서 공부를 했습니다.

//사진 1

:white_medium_square: iOS 12버전일 때. (다중 화면 x) 
>:black_medium_square: AppDelegate에서 process Lifecycle , UI Lifecycle 모두 다루었습니다.
>
>:white_medium_square: App Delegate는 앱의 프로세스 상태, UI상태( Not running, Active, Inactive, Background, Suspended)를 알고 있어야 했다.

//사진 2

:black_medium_square: iOS 13 버전(tablet 다중 화면 지원 O)
> :white_medium_square: 다중화면일 경우 여러개의 Scene 과 UI를 갖기에 체계적으로 UI Life cycle를 관리할 새로운 Scene Delegate가  만들어졌다.
> 
> :black_medium_square: 이때 기존에 App Delegate에서 관리했던 willEnterForeground(실행된 앱이 화면에 표시될 것인가?)등 UI Life cycle을 Scene Delegate에서 다루게 된다.

//사진 3

[자세하게 설명한 icksw님 블로그]https://icksw.tistory.com/137 
