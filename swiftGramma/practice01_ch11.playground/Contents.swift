import UIKit
import Foundation
                /*20.01.07*/

// 예외처리
enum DateParseError : Error{ //예외처리할 때는 enum 이나 protocol로 예외 처리 항목에 대한 정의를 많이한다.
    case overSizeString
    case underSizeString
    case incorrectFormat(part : String)
    case incorrectData(part : String)
}
// 날자 (3개 프로퍼티를 갖는다)
struct Date {
    var year : Int
    var month: Int;
    var date : Int;
}


/*  열거형으로 에러 값들을 정의 하였기에, 열거형 사용방법은 열거형.멤버변수로 호출이 가능하다!!!!! */
func parseDate(p: NSString) throws -> Date{ //String 이 아닌 NSString 을 받는 이유는 NSString 에 스트링 관련 더 많은 //메서드가 있기때문.
    guard p.length == 10 else {
        if p.length > 10 {
            throw DateParseError.overSizeString; //위에서 정의한 열거형.프로퍼티 호출
        }else{
            throw DateParseError.underSizeString
        }
    }//guard 조건문은 조건문이 false 일 경우 else 구문이 실행된다.
    
    var dateResult = Date(year: 0, month: 0, date: 0) //구조체를 선언한다. 구조체는 멤버와이즈 초기화를 지원하기에
        //이와같은 초기화가 가능하다.
    /*
     NSString은 substring(with:) 메서드가 있다. 이 메서드의 반환은 NSRange이다 . NSRange 객체의 초기화 형식 중
     NSRange(location:length:)은 특정 location(index)로부터 length 개수만큼의 NSString의 NSRange를 반환?
     */
    if let year = Int(p.substring(with: NSRange(location: 0, length: 4 ))){
        dateResult.year = year; // 입력받은 문자열 p 의 부분 문자열 0~4까지가 Int() 숫자로 변환되어서 상수에 대입된다면 옵셔녈 자동 해제, 대입이 안될 경우 옵셔널 타입부여 -> else 구문 실행
    }else{
        throw DateParseError.incorrectFormat(part : "year")
    }
    
    //입력받은 매개변수 p :NSString 로부터 부분 문자열을 Int화.
    if let month = Int(p.substring(with: NSRange(location:5, length: 2))){
        guard month > 0 && month < 13 else {
            throw DateParseError.incorrectFormat(part: "month")
        }
        dateResult.month = month ;
    }else{
        throw DateParseError.incorrectFormat(part: "month")
    }
    
    if let day = Int(p.substring(with: NSRange(location:8, length: 2))){
        guard day>0 && day<32 else{
            throw DateParseError.incorrectData(part: "date")
        }
        //위의 guard 구문이 거짓이 아닐 경우 day 값을 위에서 인스턴스화한 dateResult에 대입
        dateResult.date=day
    }else{
        throw DateParseError.incorrectFormat(part: "date")
    }
    return dateResult;
}
//enum으로 오류타입을 선언했고, parseDate를 통해 문자열로 입력된 날자가 확실한지 부분 문자열로 분리 후 구조체 Date의 Int 프로퍼티에
//대입시키는 함수를 실행하면서 오류가 발생하면 throw를 통해 예외를 집어 던져버렸다.

//따라서 이 예외를 잡아야 하는 구문을 만들어야한다.
/*
    예외를 받을 경우는 do{ try < 오류가 발생가능한(throw 키워드가 들어있는) 함수 > } catch 오류타입{} ...
     이 형식으로 do 구문 안에서 try 함수를 정의하고, 이에대한 catch로 예외를 처리하게 된다.
 */
func getPartsDate(date: NSString ){
    do{
        try parseDate(p: date)
        //let date = try parseDate(p: date);
        //만약 여기서 내가 특정한 구간을 입력받고 출력하고 싶으면 그에대한 구문과 매개변수를추가해서 조건식을 붙이면 되고, 아닐 경우
        //일밙거으로 do -try 구문에 대한 catch 를 설정해야함.
    }
    catch DateParseError.overSizeString{
        print("문자열 너무 긴데? 좀만 줄여봐~")
        return
    }catch DateParseError.underSizeString{
        print("문자열이 너무 작아.. 다시 작성좀..")
        return
    }catch DateParseError.incorrectFormat(part: ""){
        print("그 문자 잘못 입력됬다... 다시 확인해봐")
        return
    }catch DateParseError.incorrectData(part: ""){
        print("day 잘못입력됬어 다시봐바")
        return
    }catch {
        print("예기치 못한 오류가 발생 했습니다. 자세한 사항은 디버깅을..본인이 하셔야,,해용~")
        return
    }
    print("\(date) 년월일 작성 잘하셨네요 !!");
}

getPartsDate(date: "2021-01-07")
