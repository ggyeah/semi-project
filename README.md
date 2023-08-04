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

### 팀원 송현정

### 팀원 임지예


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


