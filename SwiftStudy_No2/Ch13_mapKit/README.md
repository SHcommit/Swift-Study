## 맵킷 프레임워크[ 번들 프로그램, 번들 애플리케이션, Segue 데이터 전달 복습]

🌱  번들 프로그램(Bundle Program) == 번들 애플리케이션(Bundle Application)
> 전화, 메일, 계산기, 카메라 지도 등등 이미 휴대폰 내 기본적 설치된,,, OS에 포함된 애플리케이션
>> 프레임워크 형식으로 번들 어플리케이션을 제공한다.
>>
>> ex) 주소록 동의 .. 
>이전 WebView 또한 번들 애플리케이션. 별도로 프레임워크로 제동된 번들 프레임워크를 -> 인 앱 프레임워크라고 함

//실행 결과

<span>
<img width="146" alt="스크린샷 2022-04-28 오후 11 21 52" src="https://user-images.githubusercontent.com/96910404/165774942-4636af28-7549-498b-bacb-4926f3a43584.png">
<img width="139" alt="스크린샷 2022-04-28 오후 11 22 01" src="https://user-images.githubusercontent.com/96910404/165774930-67464ae2-227b-424a-bf3e-23b6bfed77fe.png">
</span>



---

### 🔭 번들 애플리케이션 관련 프레임워크!
`
class BundleFramework : UIViewController{`

`
var 주소록_UI_프레임워크 : String =  "Address Book UI Framwework"`

`var 이벤트_및_일정_관련_프레임워크 : String = "Event Kit Ui Framework" //시스템 등록, 애플 계정으로 연동된 일정, 스케줄 정보를 달력 형태로 표현해주는 뷰 컨트롤러 제공,,!!`

`var 메시지_UI_프레임워크 : String = "Message UI Framework //앱 내부에서 간단한 이메일 작성 + 전송`

`lazy var 광고_관련_프레임워크 : String = "iAd Framework" //앱 내 배너 광고!! `

`let 지도 관련 프레임워크 = "Map Kit Framework // 지도와 여러 기능지원!!"`

`
}
`
---

### 🔭 Segue 데이터 전달 복습


**override** **func** prepare(for segue: UIStoryboardSegue, sender: **Any**?) {

**if** segue.identifier == "segue_map" {

**let** path = **self**.tableView.indexPath(for: sender **as**! UITableViewCell)

**let** data = **self**.list[path!.row]

/*

* 안드로이드 시점에서는 인텐트를 통해 전달했는데,

*

* Swift는 segue를 통해 특정 segue identifier 를 찾고,

* indexPath . row를 특정 클릭된 테이블 셀 행찾고,

* segue.destination 의 형변환을 통해 도착지 VC 인스턴스 얻어서

* 해당 맴버변수에 값을 전달한다!!

*/

**let** dest = segue.destination **as**? TheaterViewController

dest!.param = data

}
