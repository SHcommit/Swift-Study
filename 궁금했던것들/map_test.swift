//
//  main.swift
//  Map test
//
//  Created by 양승현 on 2022/03/07.
//
/**
 *고차함수
 *매개변수로 함수를 받는 함수
 *
 *container (Array, Set, Dictionary)
 *
 *for in 구문과 기본적인 동작 원리는 같다.
 *
 **
 *map(_:)
 *Returns an array containing the results of mapping the given closure over the sequence’s elements.
 */
import Foundation

var array = [0,1,2,3,4]
var result = Array<Int>()
for num in array {
    result.append(num * 2 )
}

print("\(array)")
print("\(result)")

//map 을 사용한 경우

var array1 = [0,1,2,3,4]

var result1 = array1.map({
    (number : Int) -> Int in
    return number * 2
})

print("\(result2)")
/*
 *클로저 중에서..
 *인자 값을 축약해서 사용할 수 있다.
 *위의 result1에서 보면 인자값으로 number가 사용됬는데, (인자값) -> in //이런 타입과 반환값은 클로저에서 생략 가능하다.
 * 단, 클로저 내부의 코드가 두 줄 이상이라면 return을 생략할 수 없다.
 *(인자의 표기는 $0부터 순서대로)
 * 아래의 경우에는 number * 2가 사용됬는데, 인자값이 정의되어있지 않고 생략되어있어 에러가 발생한다.
    /**
        var result2 = array1.map( {
            return number * 2
        })
     */
 *for in 구문과 같은 효과로 배열에 append를 사용하지 않아도 된다.
 */

var result2 = array1.map{ $0 * 2 }
//map은 위와같은 트레일링 클로저의 반환값인 한개의 요소를 각 배열에 차례대로 적용하여 새로운 배열의 형태로 반환한다.

print("\(array1)")
print("\(result1)")


/**
 *튜플이란?
 *여러가지 타입의 아이템을 저장할 수있다.
 *일단 선언되고 나면 상수적(let) 성격을 띄므로 더이상 값을 추가, 삭제가 불가능하다.
 *타입과 상관 없이 다양하게 저장 0
 *그러나 한번 선언되면 수정, 삭제, 추가 불가능하다.
 ****
 *let tuple = ("a", "b" , 3)
 *
 *튜플은 점( . dot)을 통해서 사용 가능하다.
 *tuple.0 // "a"
 *tuple.1 // "b"
 *tuble.2 // 3
 *튜플을 타입 어노데이션으로 적용하는 방법
 *tpl03 : (Int , (String, String)) = (100,("a", "b"))*
 *튜플 내부에 튜플을 갖을 수 있다.
 *또한 let (value1, (value2, value3)) = tp103;
 *이렇게하면 value1 = 100, value2 = "a" 이렇게 개별적으로 받아서 변수처럼 쓸 수 있지만 let이라 대입 안됨.
 */

/**
 * Dictionary 딕셔너리란?
 * 고유 key와 그에 대응하는 값 value를 연결해 데이터를 저장하는 자료형.
 * 인덱스 대신 고유 key를 통해 value를 추출한다.
 * 이 점을 제외하면 배열과 유사한 자료형이다..!!
 * [key: data ,key: data ...]
 * 예를들어 var capital = ["KR" : "Seoul" , "EN " :  "London" , "FR" : "Paris"]
 * 일 때 capital["KR"] = Seoul 인 value를 갖는다.
 * 초기화는 Dictionary<Stirng, Int>() or [키로 사용할 타입 : 값으로 사용할 타입(튜플이나 정수나 등)]()
 * 딕셔너리 해제는 nil로!!
 */
let n = Int(readLine()!)!
var lcr = "", clr = "", lrc = ""
// tree라는 딕셔너리는 key : String, 데이터는 (left: String, right: Stirng) 튜플]로 되어있다.
var tree = [String: (left: String, right: String)]()

for _ in 0..<n {
    //readLine()!.split(separator: " ")로 할 경우 subString으로 문자열을 받아지는데, 이를 String으로 변환하려면 String(감싸줘야한다.) 이렇게,,. 또는 .map을 통해서 subString에 대해서
    // 인자값을 지정하지 않았으므로 $0부터, subString인 $0을 String타입으로 바꾼다. 그렇게 readLine()으로 받은 배열 개수만큼 subString을 map을 통해 String 배열로 바꾼다.
    let input = readLine()!.split(separator: " ").map{String($0)}
    //그리고 특정 노드 : key값이라고한다면 그에 해당하는 데이터는 좌, 우 자식노드를 갖고 있기에.

    tree[input[0]] = (input[1], input[2])
}

func k(node: String, pos: Int) -> String {
    if node == "." {
        return ""
    }
    
    let left = k(node: tree[node]!.left, pos: pos)
    let right = k(node: tree[node]!.right, pos: pos)
    
    if pos == 0 {
        return node + left + right
    } else if pos == 1 {
        return left + node + right
    } else {
        return left + right + node
    }
}

print(k(node: "A", pos: 0))
print(k(node: "A", pos: 1))
print(k(node: "A", pos: 2))
