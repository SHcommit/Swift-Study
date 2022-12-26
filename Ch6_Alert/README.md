## 사용자에게 메세지 전달 방법 | 알림창 , 로컬알림, 서버 알림

🌱 서버점검, 장기간 미 접속 사용자에게 알림, 초대 메세지를 전달하는 방법에 대해서 다룹니다.

> 알림과정에서 확인, 취소, 인 앱으로 들어가기 등 다양한 이벤트 처리가 들어간다.
>
>웹앱 알림의 단점은 웹이 실행 중일 때만 알람이 왔다는게 보인다.
>> 로컬, 서버 알림을 통해 보완. 이들은 push message 기능이다.

//사진 1
- 로컬 푸쉬 : 앱 내부에서 메세지 전달.

> 자주보는 알림이다. 

- 서버 푸쉬: 별도의 서버를 통해 APNs(Apple Push Notification Service) 애플 고유 메시징 시스템?에게 보낸 메시지가 네트워크를 통해 전달되는 방식 

> 공식 용어는 로컬 노티피케이션, 푸시 노티피케이션 이다.

>>company’s server generates push notifications, and Apple Push Notification service (APNs) handles the delivery of those notifications to the user’s devices.

---
