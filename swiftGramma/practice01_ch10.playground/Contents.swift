import UIKit
import Darwin

                    /* 22.01.06*/

/*       ************************ 프로토콜의 특징 ************************     */

protocol SomeMethod {
    func myFunc(prop: String)
    func showLV(lv: Int) ->String
    
}

struct Service : SomeMethod{
    
    var lv = 20;
    func myFunc(prop: String) {
        if prop == "create"{
            print("생성 완료")
        }
    }
    func showLV(lv: Int) ->String{
        return "\(lv) 레벨입니다."
    }
}
 //구조체 내부 프로퍼티 lv의 값을 showLV메서드에서 변경시키려면 mutating 키워드를 사용해야 하는데,
    //showLV메서드는 프로토콜의 구현이므로 프로토폴안에 정의 된 showLV 메서드 또한 mutating 키워드를 선언해야한다.

/*       ************************ 구조체 mutating 프로토콜 ************************     */

 //구조체의 내부에 선언된 프로퍼티는 메서드에 의해 값이 변경되기 위해서는 mutating 키워드를 메서드에 선언해야 한다.
    //하지만 protocol 메서드를 구현한 것이라면??
protocol ModifySomeMethod{
    func myFunc(prop : String)
    mutating func showLV(lv: Int)->String   //프로토콜 메서드의 앞 부분에도 동일하게 mutating 키워드 선언!
}

struct ReService : ModifySomeMethod{
    var lv = 20;
    func myFunc(prop: String) {
        if prop == "create"{
            print("생성 완료")
        }
    }
    mutating func showLV(lv plusLV: Int) -> String {
        self.lv = plusLV + 2;
        return "\(self.lv)입니다."
    }
}
//프로토콜을 구현할 때 이름과, 외부 매개변수명은 일치시켜야 하나, 내부 매개변수명은 임의로 바꾸어도 된다.
// 프로토콜에서 mutating 키워드를 선언했지만 프로토콜을 선언 후 구현하는 구조체 속 메서드에서 프로퍼티 값을 변경하지 않는다면
        //구현 할 메서드에서 mutating 키워드 사용하지 않아도 됨.
        //하지만 역은 성립 X
                // < 클래스의 경우 참조 타입이기 때문에 mutating 키워드 사용 x >

// 프로퍼티가 선언된 클래스의 경우 타입 프로퍼티 ( 정적 메서드, 프로퍼티)를 선언 할 경우 class 키워드가 아닌 "static" 키워드를 써야한다. (구조체는 당연하기 static)

//멤버와이즈 초기화가 지원되는 구조체의 초기화 메서드를 프로토콜에서 초기화 메서드로 선언할 경우
    //반드시 프로토콜을 선언한 구조체에서 해당 초기화 메서드를 구현해야함.
//초기화 함수가 선언된 프로토콜을 선언받은 클래스의 경우 앞에 required 키워드를 붙여야함.
    //만약 부모객체가 위의 프로토콜을 선언받고, 자식객체에 상속된다면???

/* ******************** 부모 클래스와 자식 클래스 각각 같은 프로토콜을 선언받는다면? ******************** */

/*
    protocol Init{
        init()
 }
    class Parent :Init{     < - error : Redundant conformance of 'Child' to protocol 'Init'
            required init(){
            print("하위 ~ 나 부모 클래스 초기화 메서드야")
    }
 }
    class Child : Parent , Init{
        
 }
 
 //이 경우는 안되네,, 이미 부모클래스에서 프로토콜을 선언되면 자식 객체는 같은 프로토콜을 선언받을 수 없음.
*/

protocol Init{
    init()
}
class Parent {
    init(){
    print("하위 ~ 나 부모 클래스 초기화 메서드야")
    }
}
//부모 메서드, 프로토콜이 같은 이름일 경우 required ,override 키워드를 같이 사용해야 한다. 이때 순서는 상관 x
class Child : Parent , Init{
   override required init() {
        print("나는 프로토콜의 구현과 동시에 부모 메서드를 오버라이딩한 초기화 메서드지롱~")
    }
}

//          서로 다른 프로토콜은 " , " 를 통해 연속 선언이 가능하다.
//              하지만 클래스의 경우 "상속"의 개념이 있기에 상속되는 클래스를 맨 앞에 선언해야 한다.


/*       ************************ 타입(어노데이션) 프로토콜 ************************     */

protocol Wheel {
    func spin()
    func hold()
}

class Bicycle : Wheel{
    var moveState = false;
    func pedal(){
        self.moveState = true;
        print("자전거 움직이는 중 ~~~ ")
    }
    func pullBreak(){
        self.moveState = false;
        print("자전거 멈춤......")
    }
    func spin(){
        self.pedal();
    }
    func hold() {
        self.pullBreak();
    }
}

let trans = Bicycle(); // 원래 클래스 인스턴스를 생성 할 경우
let subTrans : Wheel = Bicycle(); //타입 어노데이션으로 프로토콜을 지정한 경우 , upCasting
subTrans.hold()
subTrans.spin() //Bicycle의 나머지 메서드나 프로퍼티는 은닉됨.

//타입 어노데이션을 AnyObject로 하는 경우는 클래스로 제한되고, 포로토콜로 정의된 프로퍼티, 메서드를 사용할 수 없음.

//두개의 프로토콜을 타입 어노데이션으로 받는 경우는 " & "연산자를 사용한다.
 // A와 B인 두개의 프로토콜을 선언 후 구현한 클래스 YesIcanDo가 있다고하면
 // var imp : A & B = YesIcanDo() // 로 선언하면 된다. //이 경우에는 초기화를 하는 YesIcanDo클래스에서
        //A 와 B 프로토콜을 선언받고 구현되야한다.


/*       ************************ 델리게이션 ************************     */

//       간단한 요약. 상속받은 클래스에서 프로토콜을 호출하는 업 캐스팅 개념이 아닌,
//       다른 클래스에서 프로토콜을 상속받고 또 다른 클래스에 정의만 되어있는 프로토콜 객체로 할당시켜서 다른 클래스의           정의된 프로토콜 메서드를 사용하는 경우이다.
//       = > 즉, 특정 기능을 다른 객체에 위임하고, 그에 따라 필요한 시점에서 메서드의 호출만 받는 개념이다.

protocol FuelPumpDelegate{
    func lackFuel()
    func fullFuel()
}
class FuelPump{
    var maxGage : Double  = 0.0
    var delegate : FuelPumpDelegate? = nil
   //아직 delegate 타입 프로토콜을 사용할 수 없다. 왜냐면 해당 메서드 정의가 안됬거든,,
    //업캐스팅되거나 delegate의 개념으로 다른 클래스에서 해당 프로토콜의 메서드 구현된 클래스로부터 할당받야아 사용 가능
    
    var fuelGate :Double {
        didSet{               //didSet 이란 프로퍼티의 값이 변경되면 호출되는 프로퍼티 옵저버!
            if oldValue < 10{
                self.delegate?.lackFuel()  //delegaate 는 어떤 객체든 해당 프로토콜의 메서드를 구현했다면 사용 가능.
            }else if oldValue == self.maxGage{ //그러나 이 클래스를 인스턴스로 만들어서 사용할 수는 없음.
                self.delegate?.fullFuel()
            }
        }
    }
    init(fuelGage : Double = 0){
        self.fuelGate = fuelGage
    }
}
 
class Car : FuelPumpDelegate{  //이 클래스는 프로토콜의 메서드를 구현했다. 따라서
    //이 클래스의 자신을 전달하거나 인스턴스화 해서 위의 delegate에 전달한다면 그 아래의 fuelGate 프로퍼티를 사용할 수 있다.
    var fuelPump = FuelPump(fuelGage: 100)
    
    init(){
        self.fuelPump.delegate = self //fuelpump클래스의 인스턴스를 사용하기 위해 업캐스팅 또는 델리게이션을 사용해야한다.
        //지금의 방식은 fuelpump의 자식 객체가 아닌 다른 클래스의 개념이므로 업 캐스팅이 아니라 델리게이션의 개념이다.
    }
    func lackFuel() {
        print("연료 보충이 필요하다!!")
    }
    func fullFuel() {
        print("연료 Max 할당.")
    }
}

//업캐스팅이 아닌 델리게이션을 사용하는 이유는,
//자식클래스로 상속받을 경우 자식 클래스에서 부모 클래스 메서드를 오버라이딩 시 부모 메서드는 봉인이 되고, 사용하기 위해선 업캐스팅 과정을 거쳐야하고, 하나의 부모 클래스를 상속받게된다면 기능이 다른 , 타 클래스를 상속받기 어렵기 때문에 Delegation을 사용한다.

//프로토콜은 서로간에 상위 클래스 개념이 있고, 다중 상속과 상속이 가능하다.

