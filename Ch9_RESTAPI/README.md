## OPENAPI 사용한 영화 목록 업데이트 [ CURD,RESTful,파싱,JSON방식]

🌱 CURD : 서버에 요청할 때 일어날 수 있는 정보 타입C(Create)R(Read)U(Update)D(Delete)

🌱 RESTful : 웹형식으로 데이터 전송.
> HTTP 바탕으로 데이터를 주고 받음.

🌱파싱(Parsing) : 데이터를 형식에 맞게 분석하는 과정
> JSONSerializatoin 객체 안에 .jsonObject(with:options:) 메서드가있다.
> > 이를 통해서 데이터를 파싱한다.  자세한 방법은 
> >
> ><a href="https://github.com/SHcommit/SwiftStudy_No2/blob/master/Ch9_RESTAPI/MovieChart-RESTAPI/MovieChart-RESTAPI/ListViewController.swift">이 곳</a>에서 dataParsing(RESTAPI:) func를 보자!!

🌱 Mutable 수정, 삭제 할수 있다!

---

### 🔭 JSON 방식 

:white_medium_square: 경량의 데이터 교환 형식

> 마크업 태그 사용하는 XML은 시작, 종료태그가 많이 있어서 데이터 커지는 단점있음. 


:black_medium_square: JSON에 사용될 데이터 종류는 대표적으로 두가지가 있다.

> {key : value} , [ value1, value2, value3...]
> > 여기서 Swift의 Dictionary와 다른점은 스위프트의 딕셔너리는 동일한 타입의 데이터만 저장이 가능하다.
> 
> NSDic or NSMutableDictionary 를 사용하자! 
> > Mutable 키워드 없으면 한번 읽어드린 데이터를 수정, 삭제 불가능

 ---
 ### 🔭 REST API 호출 방법

:white_medium_square: Data(contentsOf : )
> Array에서도 contentsOf가 존재한다. 여러개의 무언갈 받아들일때,, 사용되는 듯?!!
> >인자값으로 URL 타입의 객체가 필요하다

✨✨ 이때 URL은 그냥 주소가 아닌 객체를 전달해야한다!!✨✨
> URL(string:) 
> > 이것을 통해 url을 객체화해야한다.

:black_medium_square: 참고로!? 데이터를 NSData()로 타입 캐스팅이 가능하다. 이때 옵셔널 연산자는 붙지 안는다. 부모 / 자식 관계 x이기 때문

> let nsD = NSData() as Data
> 
>let Data = Data as NSData()
