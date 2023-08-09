## 📑 프로젝트 개요
<p align="center">
<img src="https://github.com/huiju0502/semi-project/assets/133737044/d5bda8b8-0a2d-419c-afe9-2ee11979744d)" >
</p>

- 밀키트 쇼핑몰
- 5월30일 - 6월23일
- 개발인원 4명  
  
## 💻 개발내용  
- 모델1 방식을 사용하여 쇼핑몰 구현  
- 쇼핑몰 내에서 관리자, 회원, 비회원의 기능별 차등 부여  
- 관리자는 2개 등급으로 나누어 등급별 관리 권한 분리  
- 관리자는 상품, 주문상태, 문의, 리뷰관리, 고객리스트조회, 직원관리 가능  
-  상품구매, 리뷰작성, 장바구니 기능, 공지 조회, 정보조회 및 변경 가능  
- 비회원은 상품조회, 리뷰조회, 장바구니, 회원가입만 가능

## 👩🏻‍💻 담당기능  
### 팀장 양희주
- **팀 리더로 일정 조율 및 프로젝트 전반적인 관리**
- **로그인/로그아웃, 고객 회원가입 및 마이페이지, 관리자의 회원관리와 직원관리 파트**
- 로그인시 크게 **직원**과 **고객**으로 구분 
  - **직원**은 권한을 **관리자**와 **일반사원** 두개로 나누어 기능별 차등 부여
  - **고객**은 **정상계정**, **휴면계정**, **탈퇴계정**으로 분기하여 그에 따라 각각 다른 기능 구현
- 고객이 로그인하면 **마지막 접속일을 조회**해서 6개월 지나면 **휴면계정** 처리하고 `JavaScript`를 이용해 **휴면 해제**
- 회원가입, 수정 등 입력폼에 `jQuery`를 적용해 **유효성 검사 실시**
- 아이디 중복 검사시 `AJAX`를 이용해 **비동기 처리**
- 비밀번호 변경시 **비밀번호 이력테이블에 저장**하여 보관
### 팀원 김예은
- **권한에 따른 메인메뉴**
  - 마이페이지, 관리자메뉴(카테고리 관리, 회원정보, 직원관리, 주문관리, 할인관리), 장바구니, 나의 주문리스트
  - 권한 level에 따라 메뉴 분기
- **비로그인 / 로그인 사용자에 따른 장바구니**
  - `HashMap<Integer, Cart>`타입의 `session`을 사용해 비로그인 사용자 장바구니 기능 구현
  - 비로그인 사용자는 회원가입 완료 후에도 장바구니 상품을 유지
- **주문 및 주문리스트 조회**
  - 장바구니의 담은 상품을 주문 가능
  - 권한 level에 따라, 완료된 주문리스트를 조회
  - 최상위 관리자는 주문리스트에서 '주문상태' 변경 가능
  - 고객은 주문상태가 '배송완료' 일때 '구매확정' 버튼을 누를 수 있으며, 리뷰작성 가능
- **배송지 관리**
  - 주문 시 배송지 리스트에서 배송지를 선택하여 주문
  - 배송지 정보 CRUD(삭제시 `JQuery` Alert)
  - **기본 배송지** 기능 구현
### 팀원 송현정

### 팀원 임지예
- **문의, 답변, 리뷰, 포인트, 할인관리 파트**
- 관리자만 답변 추가,수정,삭제 버튼이 보이며 `AJAX` 활용한 삭제기능 구현
- 리뷰 작성시 이미지 추가를 구현하여 **multipart**형식의 form으로 File타입의 객체를 받아와서 DB와 로컬폴더에 **파일이 저장**되도록 구현
- 답변,리뷰,문의,할인관리 입력 및 수정 폼에 `jQuery`를 적용해 **유효성 검사 실시**
- 주문확정을 눌러 추가 된 포인트를 양수(+), 음수(-)을 통해 총점수를 계산하고 출력
- **join**과 **case**문을 사용하여 할인이 적용된 상품 리스트를 조회하고 할인이 적용됐을 시에만 할인가격과 할인율을 반환하도록 구현 

## 🛠 개발환경  
Language

![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)


Library


![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)
![Bootstrap](https://img.shields.io/badge/bootstrap-%238511FA.svg?style=for-the-badge&logo=bootstrap&logoColor=white)


Database


![MariaDB](https://img.shields.io/badge/MariaDB-003545?style=for-the-badge&logo=mariadb&logoColor=white)


WAS


![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black)


OS


![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![macOS](https://img.shields.io/badge/mac%20os-000000?style=for-the-badge&logo=macos&logoColor=F0F0F0)


TOOL


![Eclipse](https://img.shields.io/badge/Eclipse-FE7A16.svg?style=for-the-badge&logo=Eclipse&logoColor=white)


SQL, JavaScript  
Library JQuery, BootStrap4  
Database MariaDB  
WAS Apache Tomcat9  
OS window, MAC  
TOOL Eclipse, HeidiSQL, sequel Ace  

# 메인화면
![image](https://github.com/huiju0502/semi-project/assets/133733210/f3e6fcf8-2cab-4bfc-9bb3-6a8541a75840)


