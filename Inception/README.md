<h1 align="center">
    🐳 Inception
</h1>

<h3 align="center">
	<a href="#-project-overview">프로젝트 소개</a>
	<span> · </span>
	<a href="#-docker-components">Docker 컴포넌트</a>
	<span> · </span>
	<a href="#-requirements">필수 요구사항</a>
</h3>


## 📘 프로젝트 소개

**Inception** 프로젝트는 **Docker**를 사용하여 시스템 관리 지식을 확장하는 것을 목표로 합니다. 이 프로젝트는 **3계층 아키텍처(3-tier architecture)**를 기반으로 구성되어 있으며, 다양한 서비스를 **컨테이너**로 구현하여 **Nginx**, **WordPress**, **MariaDB**와 같은 기술을 활용해 웹 애플리케이션을 배포합니다. Docker를 이용한 시스템 설계와 관리의 기초를 배우는 프로젝트입니다.


## 💡 3-Tier Architecture

**3계층 아키텍처**는 애플리케이션을 **프레젠테이션(Web Server)** 계층, **애플리케이션(AP)** 계층, **데이터(Data)** 계층으로 나누는 소프트웨어 아키텍처입니다.

- **Web Server (Nginx)**: 클라이언트의 요청을 처리하고, 웹페이지를 제공합니다.
- **Application Server (WordPress)**: 애플리케이션의 로직을 처리하며, 동적 콘텐츠를 생성합니다.
- **Database Server (MariaDB)**: 애플리케이션에 필요한 데이터를 저장하고 관리합니다.


## 🛠️ Docker 컴포넌트

### 1. **Docker**

- **Docker**는 컨테이너 기반의 가상화 플랫폼입니다. 애플리케이션과 그 종속성을 함께 패키징하여 실행 환경을 일관되게 관리할 수 있습니다.
- **ENTRYPOINT vs CMD**: Dockerfile에서 `ENTRYPOINT`는 고정된 명령어를 설정하며, `CMD`는 기본값을 설정하여 사용자가 명령을 덮어쓸 수 있습니다.

### 2. **Nginx**

- **Nginx**는 고성능 HTTP 서버이자 리버스 프록시 서버로, 높은 동시성 요청을 처리하는 데 최적화되어 있습니다.
- 이 프로젝트에서는 **웹 서버**로서의 역할을 하며, 클라이언트 요청을 받아 **WordPress** 애플리케이션으로 전달합니다.

### 3. **WordPress**

- **WordPress**는 PHP 기반의 오픈소스 **컨텐츠 관리 시스템(CMS)**입니다. 사용자 친화적인 웹사이트 제작 도구로, **MariaDB**를 데이터베이스로 사용합니다.
- **PHP-FPM**(FastCGI Process Manager for PHP)를 사용하여 PHP 애플리케이션을 빠르게 처리하고 웹 서버와의 통신을 최적화합니다.

### 4. **MariaDB**

- **MariaDB**는 MySQL에서 포크된 오픈소스 **관계형 데이터베이스(RDBMS)**입니다. **WordPress** 애플리케이션의 데이터 저장소로 사용되며, 사용자의 데이터를 안전하게 관리합니다.


## 📋 필수 요구사항

### 1. **Docker 환경 구성**

- **Docker**와 **Docker Compose**를 사용하여 **Nginx**, **WordPress**, **MariaDB**를 각각의 컨테이너로 실행합니다.
- 각 서비스는 독립된 컨테이너로 관리되며, 컨테이너 간 네트워크를 통해 통신합니다.

### 2. **Nginx 웹 서버**

- **Nginx**는 443 포트에서 **SSL**을 사용하여 클라이언트의 요청을 처리하며, **WordPress** 컨테이너로 프록시 요청을 전달합니다.

### 3. **WordPress 애플리케이션**

- **WordPress**는 **PHP-FPM**을 사용하여 애플리케이션 서버로 동작하며, **Nginx**와 통신하여 동적 콘텐츠를 제공합니다.
- **MariaDB**와 연결하여 데이터를 관리합니다.

### 4. **MariaDB 데이터베이스**

- **MariaDB**는 **WordPress**의 데이터를 저장하고 관리하는 역할을 합니다.
- 모든 데이터는 **Docker volume**을 사용하여 영구적으로 저장됩니다.

### 5. **SSL 인증서**

- **SSL 인증서**를 생성하여 **Nginx** 서버에 적용하고, HTTPS로 트래픽을 처리합니다.


## 📊 데이터베이스 명령어

- **MySQL** CLI에서 데이터베이스 관리:

```bash
mysql -uroot // MySQL CLI에 연결
USE wordpress; // WordPress 데이터베이스 선택
SHOW TABLES; // 테이블 목록 확인
SELECT * FROM wp_users; // WordPress 사용자 목록 조회
mysqldump -u username -p databasename > filename.sql // 데이터베이스 백업
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql // 데이터베이스 복구
```