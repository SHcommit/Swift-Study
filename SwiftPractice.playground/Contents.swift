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
//day1()
day2()
