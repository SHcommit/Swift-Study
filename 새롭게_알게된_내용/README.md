<a href="https://dev-with-precious-dreams.tistory.com/entry/Swift-class-%EC%B4%88%EA%B8%B0%ED%99%94-%EC%99%9C-superinit%EC%9D%84-%EC%93%B0%EB%8A%94%EA%B0%80-%EC%98%A4%EB%B2%84%EB%A1%9C%EB%94%A9-%EC%98%A4%EB%B2%84%EB%9D%BC%EC%9D%B4%EB%94%A9">클래스와 초기화. 왜 super.init()을 쓰는가? (오버로딩, 오버라이딩)</a>

<a href="https://dev-with-precious-dreams.tistory.com/entry/Swift-%EC%9E%90%EB%8F%99-%EC%A7%80%EC%A0%95-%ED%8E%B8%EC%9D%98-%EC%B4%88%EA%B8%B0%ED%99%94in-class-%EC%97%B0%EC%87%84-%ED%98%B8%EC%B6%9C-%EA%B4%80%EA%B3%84-%EB%BF%8C%EC%88%98%EA%B8%B0">자동, 지정, 편의 초기화(in class). 연쇄 호출 관계 정리</a>

<a href="https://dev-with-precious-dreams.tistory.com/entry/Swift-%ED%81%B4%EB%9E%98%EC%8A%A4-2%EB%8B%A8%EA%B3%84-%EC%B4%88%EA%B8%B0%ED%99%94%EC%99%80-%EC%95%88%EC%A0%84%EC%A0%90%EA%B2%80-%EC%99%84%EB%B2%BD-%EC%9D%B4%ED%95%B4">클래스 2단계 초기화와 안전 점검 완벽 이해</a>

required가 붙은 초기화 메서드는 항상 오버라이딩 되기 때문에 자식 클래스의 메소드에 override 키워드를 붙일 필요가 없다.

init?() failure 실패할 가능성이있는 초기화 메소드입니다. 할당 실패시 nil 반환

부모 클래스에는 init( v :)가있고 자식클래스에서는 convenience init만 있을때 자식클래스에선 반드시 delegation init을 호출해야하는데. 이때는 delegateion을 정의하지 않았기에 부모 초기화 메소드를 자동 상속 받는다. 따라서 self.init(v : )를 해줘야한다.

<a href="https://dev-with-precious-dreams.tistory.com/entry/SwiftUIkit-dequeueReusableCellwithIdentifier-in-TableView%EA%B3%BC-%EB%AC%B8%EC%A0%9C%EC%A0%90">dequeueReusable(withIdentifier:)를 왜 사용하는가?</a>
