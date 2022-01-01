import UIKit
/* 22.01.01*/
struct Resolution{
    var width = 0;
    var height = 0; //구조체안에 정의된 변수나 상수는
    //프로퍼티, 속성이라고 부른다.
    
    func decs() -> String{ //구조체 안에서 정의된 함수는 메서드라고 불린다.
        return "Resolution 구조체";
    }
}

class VideoMode{
    var interlaced = false;
    var frameRate = 0.0 // Double
    var name : String? // 옵셔널 키워드를 붙임
        //옵셔널의 경우 초기화하지 않으면 nil 부여됨.
    
    func decs() -> String {
        return "VideoMode 클래스";
    }
}

// 구조체, 클래스에 대한 인스턴스 생성
// case Struct:
let insRes = Resolution(); //이 경우 진작에 프로퍼티들이 초기화되 있어야 //한다.
let MIRes = Resolution(width: 89, height:70);
// 멤버와이즈 초기화를 할 때 선언된 멤버변수 순서에 따라서 초기화를 해야 하는 것 //같다.
// 단 하나만 초기화를 하는 경우는 디폴트가 아니다. 위의 두 경우가 디폴트 초기화 //방법이다.

//case Class:
let insVMod = VideoMode( );
//클래스의 인스턴스 생셩 경우에 VideoMode의 멤버변수가 단 한개라도 초기화 되어 있지 않다면 위의 빈 괄호는 사용할 수 없다.
//이때는 사용자가 생성자함수를 직접 구현해야한다.

print(insRes.decs() + " 와 " + insVMod.decs() + "인스턴스가 생성되었습니다.");


/* 프로퍼티의 서브 프로퍼티*/
//한개의 클래스 안에 inner클래스로 인해 서브 프로퍼티가 생기는 경우.
class derivedVM : VideoMode {
    var res = Resolution()
}
let derVMod = derivedVM()
print("derVMod.res.width(서브프로퍼티) : " +  String(derVMod.res.width));
derVMod.name = "derVMod";
derVMod.res.width=30;
derVMod.res.height=70;
print( "\(derVMod.name!) 인스턴스 width 값 : \(derVMod.res.height) ");
 //이때 주의해야할점은 super클래스의 멤버변수 name가 옵셔널 타입이다
//따라서 !를 붙여 해제해야 한다.


/*
    구조체와 클래스의 차이
      -  Call by value = Struct  // [상수 , 변수]에 따라 값 변경[ x , o ]
      -  Call by reference = Class
 */
