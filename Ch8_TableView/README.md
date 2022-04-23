## 테이블뷰! [ 테이블 뷰 컨트롤러, 프로토타입 셀]👋

<img width="632" alt="스크린샷 2022-04-23 오후 1 25 30" src="https://user-images.githubusercontent.com/96910404/164877826-e3aa946a-6a30-441a-977a-2c0145824650.png">

🌱 선택도(Cardinality)
> 특정 카테고리 선택시 나온 결과값 개수 적을수록 선택도가 높다!
> 
> 컨텐츠 분류가 잘 되있음을 뜻한다.

🌱

### 🔭 테이블 뷰 컨트롤러

:white_medium_square: Root View 는 테이블 뷰이다.
> **목록** 형식의 데이터를 화면에 표현할 때 많이 사용함  

:black_medium_square: TableView(최상위 루트 뷰) <- 테이블 뷰 셀(TableRow) <- 콘텐츠 뷰 

> 테이블 뷰 컨트롤러는 여러 개의 **테이블 뷰 셀**을 나타내는 **테이블 뷰**(Table View Controller당 ✨한 개의✨ TableView✨!!) 가 존재한다. main section.
>
> 테이블 뷰 안에 적절히 배치된 여러개의 테이블 뷰 셀(Table Row)들이 있는데 그 안에 보여지는 것은 콘텐츠 뷰이다.
> 
> Section은 테이블 뷰 셀들을 묶는 Group의 개념이다.

### 🔭프로토타입 셀(Prototype Cell)

<img width="371" alt="스크린샷 2022-04-23 오후 1 26 00" src="https://user-images.githubusercontent.com/96910404/164877855-f3b84f8d-c31a-453f-954b-e8fbc207a0d5.png">

> 테이블 뷰 셀을 원하는 대로 쉽게 디자인할 수 있도록 해주는 객체!
> 
> 화면에 공간을 차지하지 않는다. (가상 틀)

:white_medium_square: Cell Content : 이미지, 텍스트 등 내용이 포함된다.
> 가변적임

:black_medium_square: Accessory View : 콘텐츠 뷰 정보 여부를 암시!!
