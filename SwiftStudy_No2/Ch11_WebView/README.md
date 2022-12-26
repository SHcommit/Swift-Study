## 웹 브라우저 호출 방법

> REST API를 통해 특정 JSON에서 URL 정보를 받았을 때, 인앱에서 웹 브라우저를 여는 4가지 방법이 존재합니다!

🌱 웹 뷰(Web View)
> 웹 페이지 탐색하려고 사용되는 뷰 object임, + 내장형 웹 브라우저!
> > 인 앱 브라우저라고 불림

🌱 인 앱 브라우저(In-App Browser)
> 앞, 뒤, 북마크 등 추가 구현해야 사용자가 쓸 수 있음. 
>
> 인 앱 브라우저는 단순히 url만 호출해서 웹 페이지 보여준다.

// SFSafariViewController 가 좋을 수도,, 인앱에서 사파리 지원

:white_medium_square: 사파리 앱 호출
> 인 앱 벗어남
> > 아래 경우들은 인 앱에서 웹 호출됨.
> UIApplication.shared.open(URL, options:)

:black_medium_square: UIWebView 구현
> URL 객체 만들고, URLRequest(url) 로 요청하고, self.webView.loadRequest(위의 요청 객체) 로 호출

:white_medium_square: WKWebView 구현
>UIWebView는 기존 iOS에서 사용하던 웹 뷰 기반 컴포넌트, 
>> WKWebView는 iOS 8버전부터 새로 지원된 컴포넌트 ( 성능 개선 good)
>
> URLRequest(url:)로 url객체만든 후 요청하고, 그 객체를 self.webView.load(요청객체)

:black_medium_square: SFSafariViewController 구현
> 인 앱에서 사파리 기능 지원!!
>> 사파리는 뷰 컨트롤러 객체로 취급되서 present로 화면 전환!

<img width="1512" alt="스크린샷 2022-04-28 오후 2 11 46" src="https://user-images.githubusercontent.com/96910404/165686925-ef9931ce-1a28-4db1-a8f0-ee6b2b5617a1.png">

기존 movie List에서

특정 cell 클릭시 mvo.detail의 url로 이동

<img width="826" alt="스크린샷 2022-04-28 오후 2 12 02" src="https://user-images.githubusercontent.com/96910404/165686913-916d914a-de12-4044-a64c-614bc5b318c3.png">
