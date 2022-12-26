import UIKit
                    /* 22.01.01*/
func day1(){
    /*       ************************ 구조체, 클래스에 대한 인스턴스 생성 ************************     */
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
    
    
    // case Struct:
    let insRes = Resolution(); //이 경우 진작에 프로퍼티들이 초기화되 있어야 한다.
    let MIRes = Resolution(width: 89, height:70);
    // 멤버와이즈 초기화를 할 때 선언된 멤버변수 순서에 따라서 초기화를 해야 하는 것 같다.
    // 단 하나만 초기화를 하는 경우는 디폴트가 아니다. 위의 두 경우가 디폴트 초기화 방법이다.

    //case Class:
    let insVMod = VideoMode( );
    //클래스의 인스턴스 생셩 경우에 VideoMode의 멤버변수가 단 한개라도 초기화 되어 있지 않다면 위의 빈 괄호는 사용할 수 없다.
    //이때는 사용자가 생성자함수를 직접 구현해야한다.

    print(insRes.decs() + " 와 " + insVMod.decs() + "인스턴스가 생성되었습니다.");

    /*       ************************ 프로퍼티의 서브 프로퍼티 ************************     */
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

    
                    /*22.01.02*/

    //인스턴스간 메모리 주소값 비교 ( === )연산자
        // L 구조체 간의 비교에는 === 연산자를 사용할 수 없다.
    if (derVMod === insVMod) {
        print("두 인스턴스는 동일한 주소를 참조합니다.")
    }else{
    print("두 인스턴스는 서로 다른 주소를 참조합니다.")
    }

}


func day2(){
    
    /*       ************************ lazy keyword ************************     */
    //지연 저장 프로퍼티
        //위의 키워드가 붙은 프로퍼티는 선언만 된 후, 추후 이 프로퍼티가 호출 될 때 초기화된다.
    //클로저를 통한 프로퍼티 초기화 pClosure
    print("");
    class OnCreate {
        init() {
            print("OnCreate ")
        }
    }

    class LazyTest {
        var base : Int!;
        lazy var pClosure : String! = {
            print("클로저를 통한 프로퍼티 생성 complete")
            return "pClosure"
        }() //클로저를 정의후. 실행되어야 하기 때문에 () 빈 괄호를뒤에 붙인다.
    
        lazy var late = OnCreate();
        init() {
            print("LazyClass create!")
        }
    }
    let LT = LazyTest();
    LT.late // late를 호출하지않으면 late의 OnCreate 인스턴스는 생성되지 않는다.
    print(LT.pClosure!) //클로저가 실행된 이후에는 return된 값만 사용할 수 있다.
                            //=> 클로저를 통한 프로퍼티 초기화는 클래스 생성시, 변수들이 처음 초기화 될 떼 한번만 실행된다.
                            //   하지만 이 프로퍼티 사용하지 않을 수도 있다는 판단이 들면 lazy를 통한 지연된 초기화를 하면 좋다.
    
    
    /*       ************************ 연산처리 프로퍼티의 사용 예 ************************     */
    //메서드를 구현하는 방법도 있지만, get을 이용해 연산처리 프로퍼티를 구현함으로 속성 값으로 바로 지정되는 장점이 있다.
    var count :Int = 0;
    struct UserAge{
        var ID : Int!
        var age :Int {
            get{
                return 2022 - (self.ID)/10000 + 1 ;
            }
        }
    }
    let one = UserAge(ID: 19670908);
    print(one.age)

    
    /*       ************************ 연산 프로퍼티 사용 2번째 예 ************************     */
    
    /*
     * get의 경우 클래스 , 구조체 내의 다른 프로퍼티들을 연산처리 후 반환하여 연산 프로퍼티에 값을 대입할 수 있는 기능이다.
     *      get{} 구현이되지 않으면 연산 프로퍼티 의미가 없다.
        *
     * set의 경우, 인스턴스를 생성하고, 특정 인스턴스의 연산 프로퍼티 값을 새로 할당할 경우,
     *      set {} 가 없으면 특정 인스턴스의 연산 프로퍼티에 값을 새로 할당할 수 없다!
     * 연산프로퍼티의 (return)값은 인스턴스 내 다른 프로퍼티들의 연산에 의한 결과값이므로,
     *       인스턴스 내 다른 프로퍼티들의 값을 바꾸어 주어야 한다. 또한 바꿀수 있는게 set {} 이다.
     */
    struct Circle{
        var startX : Double = 0.0 //도형의 시작좌표
        var startY : Double = 0.0
        
        var diameter : Double = 0.0; //원의 지름
        
        var centerX : Double {
            get{
                return self.startX + self.diameter/2
            }
            set(newCenter){         //newCenter를 통해 새로운 x좌표가 설정된 것.
                //(사용자가 인스턴스.centerX를 통해 연산 프로퍼티 값을 새로 변경함.
                //Center연산에 연관 있는 startX, startY 값을 바꾸지 않으면
                //이후에 centerX를 호출해도 값이 그대로다!
                startX = newCenter - diameter/2
            }
        }
        var centerY : Double {
            get{
                return self.startX + self.diameter/2
            }
            set(newCenter){
                startX = newCenter - diameter/2
            }
        }
    }
    // 연산 프로퍼티를 사용할 경우 초기값을 지정해주면 즉시 이와 연관된 새로운 프로퍼티들을 정의, 사용할 수 있다 오옹,,좋은데?
    
    var myCircle = Circle(startX : 0.0, startY : 0.0 , diameter : 10.0);
    print("circle 구조체의 두 연산 프로퍼티 centerX , center Y를 바로 알 수 있다.")
    print("center X , center Y = (\(myCircle.centerX),\(myCircle.centerY))");
    myCircle.centerY = 20;
    print("\(myCircle.centerX)") //centerX만 바꿨지만 set을 통해 연관된 프로퍼티들의 값이 바뀌었음으로, 20 출력
    print("\(myCircle.startX)")
    
    
    
   // startX , startY두 프로퍼티를 한개의 좌표값으로 표시하는 방법
    struct Point{
        var x : Double = 0.0
        var y : Double = 0.0
    }
    
    struct Ellipse {
        var start = Point(x: 0.0, y: 0.0);
        var diameter : Double = 0.0
        var center : Point {
            get{
            return Point(x: (self.start.x + (self.diameter/2)) , y: (self.start.y + (self.diameter/2)))
            }
            set(newCenter){
                start.x = newCenter.x - diameter/2
                start.y = newCenter.y - diameter/2
            }
        }
    }
    let s  = Point(x: 0.0, y: 0.0)
    var ellipse = Ellipse(start: s, diameter: 10)
    print("Center (x , y) = (\(ellipse.center.x) , \(ellipse.center.y))\n"); //체인 기능도 상당히 편리하네,,,
    
    ellipse.center = Point(x: 30, y: 30);
    print("Start (x , y) = (\(ellipse.start.x) , \(ellipse.start.y))");
    ellipse.diameter = 20;
    print("Center (x , y) = (\(ellipse.center.x) , \(ellipse.center.y))");
     // 배열의 count == 대표적인 연산 프로퍼티 .. 그래서 메서드() 빈 괄호가 안 붙었구나 ㄷㄷ
    
}


                    /* 22.01.03*/
func day3(){
    /*       ************************ didSet , willSet ************************     */
    struct userWeight{
        var name :String = ""
        var weight :Int {
            willSet(newWeight){     //값을 대입하면, 대입되기 전 willSet옵저버가 실행된다. 이때 매개상수(newWeight에 프로퍼티 값이 우선 대입된다.
                print("당신의 몸무게는 \(newWeight)kg 입니다.") // willSet이 끝난후에 프로퍼티에 값이 대입된다.
                    //weight = weight - 30;      대입될 프로퍼티의 값을 수정할 수는 없다.
            }
            didSet(oldWeight){
                if(weight < oldWeight){
                    print("축하드립니다. 체중이 \(weight - oldWeight)kg 빠지셨군요^^")
                }else{
                    print("살이 좀 찌셨군요?\n적절한 운동은 다이어트에 도움이 됩니다.")
                }
            }
        }
    }
    var hap = userWeight(name: "happy", weight: 75)
    hap.weight=80
    
    /*       ************************ 타입 프로퍼티 ************************     */
        //struct = "static"키워드를 통해 저장 , 연산 프로퍼티를 타입 프로퍼티로 만들 수 있다.
    
        //class  = "static"키워드를 통해서 위와 같이 타입 프로퍼티 만들 수 있고,
        //추가적으로 "class" 키워드를 통해 연산 프로퍼티를 타입 프로퍼티로 만들 수 있다. 이때 자식 객체에서 재정의가 가능하다.
            //타입 프로퍼티는 클래스명.타입프로퍼티 를 통해 호출 가능하다(인스턴스 생성x == 가능)
    
    struct zoo {
        static var cZoo: Int {
            return 10;
        }
    }
    var kow  = zoo();
    print(zoo.cZoo)             //타입 프로퍼티는 인스턴스에 속하지 않는 값이다.
    //print(kow.cZoo) ; error   //타입 프로퍼티는 반드시 클래스명, 구조체명  dot 타입 프로퍼티 의 방식을 통해 호출해야한다.
    
    /* ************************ struct에 프로퍼티 값 변경(mutating키워드) ************************ */
    struct Point {
        var x = 0.0;    var y = 0.0;
        mutating func moveTo(_ x : Double, _ y : Double){
            self.x += x;
            self.y += y;  //mutating 키워드를 사용하지 않으면 구조체에서 프로퍼티 값을 변경할 수 없음.
        }
    }
    var point = Point();
    point.moveTo(17, 14)
    print("(x,y) = (\(point.x),\(point.y))\n")
    
    
    /*       ************************ 클래스 메서드 , 프로퍼티 재정의 ************************     */
    class Vehicle{
        var currentSpeed = 0.0 ;
        var description :String {
            return "시간당 \(self.currentSpeed)의 속도로 이동하고 있습니다."
        }
        func makeNoise(){print("no Sound")}
    }
    
    class Car :Vehicle {
        var gear :Int=0
        var engineLv :Int=0
         
        //부모 프로퍼티를 오버라이딩 할 경우 override 키워드를 붙여야 한다.
        override var currentSpeed: Double { // 저장 프로퍼티를 오버라이딩 할 경우.( 연산 프로퍼티를 통해 오버라이딩 할 수 있음)
            get{ //연산 프로퍼티 (get , set)
                return Double(self.engineLv  * 100);
            }
            set{
                print(" - 오버라이딩 된 자식 프로퍼티 currentSpeed 호출됨 이때의 값은 \(currentSpeed)")
            } //저장->연산 프로퍼티로 오버라이딩 할 경우 get{} set{} 구문을 모두 사용해야한다.
        }
        
        override var description: String {
            get{
                return "Car : engineLv = \(self.engineLv), currentSpeed = \(self.currentSpeed)"
            }
            set{
                print(" - 오버라이딩된 자식 프로퍼티 description 호출됨. 이때 이름은 \(newValue) ");
            }
        }
        
        //메서드를 오버라이딩 할 경우 반환타입, 매개변수 , 매개변수 개수 동일해야한다.
        override func makeNoise() {
            
            print("\t\t\t\t부와아아앙 삐용 삐용 삐용 삐용~~!!!!!!") //함수 내용을 변경하여 오버라이딩을 하자!
        }
    }
    let mycar = Car()
    
    mycar.engineLv = 5
    mycar.currentSpeed = 5
    mycar.description = "my class Car"
    print(mycar.description)
    mycar.makeNoise()
    
    //참고로 연산 프로퍼티 get과 didSet은 같이 쓰일 수 없다.
    let castedCar : Vehicle = Car();
    castedCar.makeNoise()
    
    class A {
        
        func classType () {
            print(" A class 타입이 호출 되었습니다.");
        }
    }
    class B :A{
        override func classType() {
            print(" B class 타입이 호출 되었습니다.")
        }
    }
    class C : B{
        override func classType() {
            print(" C class 타입이 호출 되었습니다.")
        }
    }
    
    let typeC :B = C(); //업캐스팅
    typeC.classType()
    
    let anyA = typeC as A;
    anyA.classType(); //업캐스팅된 anyA이지만 오버라이딩을통해 재정의 된 함수가 있기에 그 함수를 호출한다.
    if let anyC = anyA as? C{ //다운그래이드
        print("다운캐스팅 형 변환이 성공적으로 되엇습니다.");
    }
    //클래스의 최상위 클래스는 AnyObject 클래스이다.
    var list = [AnyObject](); //어떤 클래스 타입이든 다 배열의 원소로 받을 수 있다.
    list.append(A())
    list.append(B())
    list.append(C())
    list.append(Car())
    
}
                    /* 22.01.03*/
func day4(){
    /*       ************************ 생성자 init ************************     */
    class userID{
        var name :String
        var age :Int
        var ID : String = "X"
        init(name : String,age : Int){
            self.name = name;
            self.age = age
        }
        func prtFunc(){
            print("이름 : \(name) , 나이 : \(age) , 아이디 : \(ID) ")
        }
    }
    //let jang = userID();  //기본 초기화 구문 x
    let kim = userID(name: "kim" , age: 10 )    //init 메서드 호출
    //let park = userID(name : "park" , age : 15 , ID : "9238") 구조체의 경우 가능하지만 클래스는 안됨
    kim.prtFunc()
    //park.prtFunc();
    
    // init를 구현 후 해당 맴버변수에 맞는 생성자로 초기화 하거나, 구조체의 경우 추가적으로 멤버와이즈 초기화를 할 수 있다.
    /*
        - 특이한 점은 struct에 init를 구현하지 않았는데도 불구하고 인스턴스를 생성할 때
        - var kim userID(name : "kim" , age : 10)을 했을 때 초기화가 되었다. ???????
        - 하지만 클래스의 경우 init를 구현하지 않으면 위에 경우처럼 초기화가 안됨
     */
    
    struct Human{
        var name :String?
        var man : Bool = true;
    }
    
    struct Company{
        var ceo : Human? //human 구조체를 프로프로퍼티로 갖는다.!
        var companyName :String?
        func getCEO() -> Human?{ //구조체를 반환한다.
            return self.ceo     //자신이 속한 인스턴스의 프로퍼티를 (참조?)반환한다.
        }
    }
}
//day1()
//day2()
//day3()
day4()
