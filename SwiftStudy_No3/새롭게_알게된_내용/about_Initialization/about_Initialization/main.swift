//https://dev-with-precious-dreams.tistory.com/entry/Swift-class-%EC%B4%88%EA%B8%B0%ED%99%94-%EC%99%9C-superinit%EC%9D%84-%EC%93%B0%EB%8A%94%EA%B0%80-%EC%98%A4%EB%B2%84%EB%A1%9C%EB%94%A9-%EC%98%A4%EB%B2%84%EB%9D%BC%EC%9D%B4%EB%94%A9
import Foundation


/**
 * x = 변수 선언과 동시에 값 할당
 * y = init()을 통해 초기화
 */
class point
{
    var x : Int = 0
    var y : Int
    init()
    {
        y = 0
    }
}

/**
 * x = 옵셔널 타입
 * y = 옵셔널 타입
 */
class optionalPoint : point
{
    var ox : Int?
    var oy : Int?
    override init()
    {
        super.init()
        
    }
    init(ox : Int?, oy : Int?) {}
}
