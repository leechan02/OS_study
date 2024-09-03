# Subject

---

*요약 : VM을 통해 운영체제를 설치해보는 프로젝트*

### Introduction

- You will create your first machine in [**VirtualBox**](https://ko.wikipedia.org/wiki/%EB%B2%84%EC%B6%94%EC%96%BC%EB%B0%95%EC%8A%A4) (or [**UTM**](https://mac.getutm.app/) if you can’t use VirtualBox) under specific instructions.

### Mandantory

<aside>
🚨 서버를 세팅할 때 최소한의 서비스를 실행하기 때문에 **graphical interface**를 여기서 이용하지 않는다. 사용하면 0점이니 그렇게 알아라.

(Since it is a matter of setting up a server, you will install the minimum of services. For this reason, a graphical interface is of no use here. It is therefore forbidden to install [X.org](http://x.org/) or any other equivalent graphics server. Otherwise, your grade will be 0.)

</aside>

- **Virtual box**나 **UTM**이라는 가상 머신에 운영체재를 설치해야하며, 최신 **안정화 버전**의 **Centos OS** 또는 **Debian OS**를 사용한다. 초짜라면 **Debian** 써라. (You must choose as an operating system either the latest stable version of Debian (no testing/unstable), or the latest stable version of CentOS. Debian is highly recommended if you are new to system administration.)

<aside>
ℹ️ **Centos**는 복잡하기때문에 **KDump**를 설정하지 않아도 된다. 하지만 **SELinux**와 **AppArmor for Debian**는 필수이다. 시작할 때 구동되어야 한다? (Setting up CentOS is quite complex. Therefore, you don’t have to set up KDump. However, SELinux must be running at startup and its configuration has to be adapted for the project’s needs. AppArmor for Debian must be running at startup too.)

</aside>

- **LVM**을 이용해 **두 개 이상**의 파티션을 만들어야하며, 만들어야 하는 파티션은 다음과 같다. (You must create at least 2 encrypted partitions using LVM. Below is an example of the expected partitioning:)
    
    ![https://blog.kakaocdn.net/dn/lY47R/btq8Ojlfesw/bhpbMO5MpFlwem8QA3HphK/img.png](https://blog.kakaocdn.net/dn/lY47R/btq8Ojlfesw/bhpbMO5MpFlwem8QA3HphK/img.png)
    

<aside>
ℹ️ 평가 도중 선택한 운영체제에 대해 질문을 받을 수 있다. 예를 들어 패키지 관리툴인 **apt**와 **aptitude**의 차이점이라던가 **SELinux**나 **AppArmor**이란 무엇인가 등에 대한. **그니까, 니가 뭘 쓰고 있는지 알고는 있어야겠지?!**(During the defense, you will be asked a few questions about the operating system you chose. For instance, you should know the differences between aptitude and apt, or what SELinux or AppArmor is. In short, understand what you use!)

</aside>

- SSH 서비스의 포트는 오직 4242에서 구동되어야 하며, 보안상의 이유로 **root폴더에 ssh로 연결할 수 없어야한다**. (A SSH service will be running on port 4242 only. For security reasons, it must not be possible to connect using SSH as root.)

<aside>
ℹ️ ssh의 사용은 평가 중 새로운 계정을 세팅하는 것으로 테스트되니까 **어떻게 동작하는지** 알고있어야겠지?! (The use of SSH will be tested during the defense by setting up a new
account. You must therefore understand how it works.)

</aside>

- UFW 방화벽으로 운영체제를 설정해야하기 때문에 **4242포트**만 열어두어야 한다. (You have to configure your operating system with the UFW firewall and thus leave only port 4242 open.)

<aside>
ℹ️ 가상 머신이 **시작될 때 방화벽이 켜져있어야한다.** **~~센토스**의 경우 **기본 방화벽 대신 UFW**를 사용해야 하며, 아마 **DNF**가 필요할 것임.~~ (Your firewall must be active when you launch your virtual machine. For CentOS, you have to use UFW instead of the default firewall. To install it, you will probably need DNF.)

</aside>

- 가상 머신의 Host 명은 **아이디 + 42로 끝**나야하며, 평가 중 이 **이름을 수정**해야 한다. (The hostname of your virtual machine must be your login ending with 42 (e.g.,wil42). You will have to modify this hostname during your evaluation.)
- **강력한** 암호 룰을 구현해야하며, 엄격한 룰로 **sudo**를 설치하고 설정해야 한다. (You have to implement a strong password policy. You have to install and configure sudo following strict rules.)
- 루트 사용자 외에 추가로 유저 이름으로 **현재 로그인** 되어있는 사용자가 있어야하며, 이 사용자는 **user42와 sudo 그룹**에 속해 있어야 한다. (In addition to the root user, a user with your login as username has to be present. This user has to belong to the user42 and sudo groups.)

<aside>
ℹ️ 평가 중 **새로운 유저를 생성**하고 **그룹에 배정**해야한다. (During the defense, you will have to create a new user and assign it to a group.)

</aside>

- 강력한 **암호** 룰 (To set up a strong password policy, you have to comply with the following requirements:)
    - 암호는 30일마다 만료. (Your password has to expire every 30 days.)
    - 비밀번호의 최소 수정 허용일수는 2일. (The minimum number of days allowed before the modification of a password will be set to 2.)
    - 유저는 패스워드 **만료 7일 전** 경고 받음. (The user has to receive a warning message 7 days before their password expires.)
    - 패스워드는 적어도 10글자이며, 한 글자 이상의 대문자와, 숫자로 이루어지며, 3글자 이상 연속되면 안 된다. (Your password must be at least 10 characters long. It must contain an uppercase letter and a number. Also, it must not contain more than 3 consecutive identical characters.)
    - 패스워드는 유저의 **이름**을 포함하고 있으면 안된다. (The password must not include the name of the user.)
    - 새로운 패스워드는 이전의 패스워드와 최소 7글자는 달라야 한다. → root 암호는 이 규칙은 포함 안함. (The following rule does not apply to the root password: The password must have at least 7 characters that are not part of the former password.)
    - root 또한 동일한 패스워드 정책을 적용 받아야 한다. (Of course, your root password has to comply with this policy)

<aside>
🚨 설정 파일을 세팅한 후 루트 계정을 포함한 머신의 모든 비밀번호를 바꿔야함. (After setting up your configuration files, you will have to change all the passwords of the accounts present on the virtual machine, including the root account.)

</aside>

- **Sudo 그룹의 강력한 설정**을 위한 **필요사항 (To set up a strong configuration for your sudo group, you have to comply with the following requirements:)**
    - Sudo를 통한 인증은 최대 **3회**의 기회가 주어진다. (Authentication using sudo has to be limited to 3 attempts in the event of an incorrect password.)
    - Sudo를 통한 인증이 실패했을 때, **선택한 사용자 지정 메세지가 출력**되어야 한다. (A custom message of your choice has to be displayed if an error due to a wrong password occurs when using sudo.)
    - Sudo를 통한 각 실행은 **입, 출력 모두 문서화**되어 /var/log/sudo/ 폴더에 로그파일로 저장되어야 한다. (Each action using sudo has to be archived, both inputs and outputs. The log file
    has to be saved in the /var/log/sudo/ folder.)
    - **보안 상**의 이유로 **TTY 모드**가 활성화 되어야 한다. (The TTY mode has to be enabled for security reasons.)
    - 역시 보안상의 이유로, Sudo에서 사용할 수 있는 루트가 제한되어야 한다. (For security reasons too, the paths that can be used by sudo must be restricted.)
    - 예를 들어 /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
- 마지막
    - 간단한 monitoring.sh라는 간단한 스크립트를 불러와야하며, bash 환경에서 개발되어진다.(Finally, you have to create a simple script called monitoring.sh. It must be developed in bash.)
    - 서버 시작 시 스크립트는 **10분**마다 모든 터미널에 아래와 같은 정보를 표시해야하며 (wall을 참고), 에러를 표시하지 않고, 선택사항으로 배너 옵션을 가질 수 있음. (At server startup, the script will display some information (listed below) on all terminals every 10 minutes (take a look at wall). The banner is optional. No error must be visible.)
    
    스크립트는 다음과 같은 정보를 항상 출력 가능해야한다. (Your script must always be able to display the following information:)
    
    - OS와 커널의 아키텍처 (The architecture of your operating system and its kernel version.)
    - 물리 프로세서(Core)의 갯수 (The number of physical processors.)
    - 가상 프로세서(Thread)의 갯수 (The number of virtual processors.)
    - 서버의 사용 가능한 램의 전체 크기와 현재 사용량을 백분율로 표시해야함 (The current available RAM on your server and its utilization rate as a percentage)
    - 사용 가능한 전체 저장 공간의 크기와 현재 사용량을 백분율로 표시해야함 (The current available memory on your server and its utilization rate as a percentage)
    - 프로세서(Thread)의 현재 사용량을 백분율로 표시해야함 (The current utilization rate of your processors as a percentage)
    - 마지막 재부팅 시간을 YYYY-MM-DD hh:mm로 표시 (The date and time of the last reboot.)
    - LVM이 동작중인지 아닌지 표시해야함 (Whether LVM is active or not.)
    - 연결된 네트워크의 수를 표시해야함 (The number of active connections.)
    - 서버를 현재 사용중인 유저의 수 (The number of users using the server.)
    - 서버의 IPv4 주소와 MAC주소 (The IPv4 address of your server and its MAC (Media Access Control) address.)
    - sudo를 통해 실행된 명령어의 수 (The number of commands executed with the sudo program.)

<aside>
ℹ️ 평가 중 해당 스크립트의 구동에 대해 설명해야하며, 수정 없이 중단해야함.(cron 참조) (During the defense, you will be asked to explain how this script works. You will also have to interrupt it without modifying it. Take a look at cron.)

</aside>

스크립트 예시

![https://blog.kakaocdn.net/dn/bNRc3s/btq8UN5Qq80/NHuNFMjZhu9lROo4WEwrH1/img.png](https://blog.kakaocdn.net/dn/bNRc3s/btq8UN5Qq80/NHuNFMjZhu9lROo4WEwrH1/img.png)

과제의 필요 요구사항을 확인할 수 있는 명령

- Debian OS

![https://blog.kakaocdn.net/dn/biZCzV/btq8SBL5Ml0/4mhrXB1Ug2Ve3vf2EzFk00/img.png](https://blog.kakaocdn.net/dn/biZCzV/btq8SBL5Ml0/4mhrXB1Ug2Ve3vf2EzFk00/img.png)

### Bonus

- 파티션을 정확히 설정했다면 다음과 같은 구조를 얻었을 것.

![https://blog.kakaocdn.net/dn/RF9fp/btq8RuzTJ9S/P41aSENxke5zzcDoganIdK/img.png](https://blog.kakaocdn.net/dn/RF9fp/btq8RuzTJ9S/P41aSENxke5zzcDoganIdK/img.png)

- lighttpd와 MariaDb, PHP를 통해 기능적인 워드 프레스 웹 사이트를 설정해봐라. (Set up a functional WordPress website with the following services: lighttpd, MariaDB, and PHP.)
- Apache, NGINX를 제외한 유용하다고 생각되는 서비스를 세팅하시오. 평가 중 선택한 이유에 대해 가드해야한다. (Set up a service of your choice that you think is useful (NGINX / Apache2 excluded!). During the defense, you will have to justify your choice.)

<aside>
ℹ️ (To complete the bonus part, you have the possibility to set up extra services. In this case, you may open more ports to suit your needs. Of course, the UFW rules has to be adapted accordingly)

</aside>

<aside>
🚨 보너스파트는 Mandantory가 완벽할 경우에만 통과임(The bonus part will only be assessed if the mandatory part is PERFECT. Perfect means the mandatory part has been integrally done and works without malfunctioning. If you have not passed ALL the mandatory requirements, your bonus part will not be evaluated at all.)

</aside>

### 제출법

- Git 저장소의 루트 디렉토리에 있는 signature.txt 파일만 제출하면 되며, 가상 머신의 서명을 붙여넣어야 함. 받는 방법은 기본 설치 폴더를 연 후
    - MacOS: ~/VirtualBox VMs/
    - 기타 OS
        - Windows: %HOMEDRIVE%%HOMEPATH%\VirtualBox VMs\
        - Linux: ~/VirtualBox VMs/
        - MacM1: ~/Library/Containers/com.utmapp.UTM/Data/Documents/
- 그런 후 가상 머신의 .vdi 파일에서(UTM 사용자의 경우 .qcow2) sha1 포맷의 서명을 검색한다.
- 센토스 서버의 4가지 명령어의 예시는 다음과 같다.
    - MacOS: shasum centos_serv.vdi
    - 기타 OS
        - Windows: certUtil -hashfile centos_serv.vdi sha1
        - Linux: sha1sum centos_serv.vdi
        - For Mac M1: shasum Centos.utm/Images/disk-0.qcow2
    
    얻을 수 있는 출력은 다음과 같음
    
    - 6e657c4619944be17df3c31faa030c25e43e40af

가상 머신의 서명이 첫 평가 이후로 변경될 수 있으므로, 해당 문제를 위해 **가상 머신을 복사**하거나 혹은 **저장 상태를 사용**할 수 있음.

- 깃 저장소에 가상머신을 넣는 것은 금지되며, 평가 중 Signature.txt 파일의 서명이 가상머신의 서명과 비교된다.

# Contents

---

- [**Subject**](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
- [Contents](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
- [Mandatory part](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [Project overview](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [Check](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [User](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [Hostname and Partitions](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [SUDO](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [UFW](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [SSH](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
    - [Script monitoring](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)
- [Bonus](https://www.notion.so/Born2beroot-39243dd262b94b8b93e66cf69ebdeb68)

**참고 사이트**

- [Virtualbox Debian 설치](https://velog.io/@appti/born2beroot-Virtualbox-Debian-%EC%84%A4%EC%B9%98)
- [mandatory & bonus 참고](https://velog.io/@augus-xury/%EA%B0%80%EC%83%81%EB%A8%B8%EC%8B%A0Debian-%EC%84%B8%ED%8C%85%ED%95%98%EA%B8%B0#sudo-%EC%84%A4%EC%B9%98)
- [개념 참고](https://velog.io/@pearpearb/42%EC%84%9C%EC%9A%B8-Born2berootSSH%EC%99%80-%ED%8F%AC%ED%8A%B8%ED%8F%AC%EC%9B%8C%EB%94%A9)
- [개념 참고2](https://www.notion.so/2ce1177e08904c329fb437c7fdcd7113)

# Mandatory part

---

## Project overview

---

### ✅ Virtual Machine이란? (가상머신)

*컴퓨터 환경을 소프트웨어로 구현한 것.* 

*즉 특정 물리적 컴퓨터 위에 가상화한 컴퓨터 환경을 구축하여 어떠한 운영체제라도 설치할 수 있게 하는 소프트웨어. (`aws`서비스와 비슷한 개념.)*

<aside>
💿 host OS : 실물 컴퓨터에 설치된 OS
guest OS : VM으로 만든 컴퓨터에 설치된 OS

</aside>

- **종류 (가상화 범위에 따라 두 가지로 나뉨.)**
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c3a251f3-f92e-46d4-8a32-6c8551dfb92d/Untitled.png)
    
1. **시스템 가상 머신 - `Virtualbox`, `Oracle VM` 등**

---

- 완전한 시스템 플랫폼을 제공
- 완전한 운영 체제(OS)의 실행을 지원
1. **프로세스 가상 머신 - `JVM(JAVA Virtual Machine)` 등**

---

- 하나의 단일 프로그램 실행 환경 제공
- 즉 단일 프로세스를 제공

**시스템 가상 머신**

---

- 가상화를 제공하는 소프트웨어 계층은 **가상 머신 모니터(VMM)** 또는 [하이퍼바이저](https://ko.wikipedia.org/wiki/%ED%95%98%EC%9D%B4%ED%8D%BC%EB%B0%94%EC%9D%B4%EC%A0%80)라고 한다.
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/000bc163-7462-4580-adb3-9e2dc4d59c13/Untitled.png)
    
- 일반적으로 하드웨어 위에 **가머모(VMM)**를 올리고 그위에 여러개의 OS가 올라간 형태를 가진다.

**시스템 가상 머신의 이점**

- host 하드웨어에 영향을 주지 않고 guest 환경의 것을 게스트 밖으로 내보낼 수 없다. aka. 가상머신은 가상머신 안에서만
    - 하나의 물리 서버에서 여러개의 운영체제를 구동할 수 있음. → 다양한 운영체제에 맞게 개발할 수 있음.
    - 컴퓨터의 다른 부분에 영향을 주지 않는 독립 환경을 만들고 싶을 때. → 악성 코드 분석, 신뢰할 수 없는 운영 체제 설치.
    - 배포 시 소량의 리소스만 사용하기 때문에 서버를 가상화하여 각 물리 서버에 수 많은 가상 서버를 배치하여 하드웨어 활용률을 개선할 수 있음 → 하나의 컴퓨터의 자원을 여러명에게 나누어주고, 각 사용자간의 상호간섭을 없애고 싶을 때.

**하이퍼바이저 (Hypervisor)**

---

*하드웨어에서 [리소스](https://ko.wikipedia.org/wiki/%EB%A6%AC%EC%86%8C%EC%8A%A4)를 사용자가 원하는 만큼 (즉 각 VM에 맞는 리소스를 할당) 사용하여 **VM**을 생성하고 구동하는 소프트웨어.*

- **가머모(VMM)**라고도 불리며 **하이퍼바이저** 운영체제와 가상머신의 리소스를 분리해 **VM**의 생성과 관리를 지원한다.
- 그니까 메모리 및 리소스를 Guest OS에 할당하는 역할을 한다. (직접 하드웨어와 소통한다.)
- GuestOS마다 말하는 것이 달라 하드웨어가 명령을 이해할 수 없는 경우가 있다. 하이퍼바이저는 각 OS마다 말하는 명령을 하드웨어가 이해할 수 있게 하나의 명령어로 번역해준다.
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/363fe600-bcc9-4343-b739-7c3899380919/Untitled.png)
    
- **Hypervisor 유형**
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1630470d-3ced-4875-b4e1-b2c441a645fe/Untitled.png)
    

**Type 1(Native or Bare-metal Hypervisor)**

---

- 하드웨어 위에 바로 **Hypervisor**가 설치되는 형태이다.
- [`KVM](https://namu.wiki/w/KVM)/[QEMU](https://namu.wiki/w/QEMU)`, [`XEN`](https://en.wikipedia.org/wiki/Xen)
- 맥북의 부트캠프와 같이 부팅시 윈도우로 접속.

**Type 2(Hosted Hypervisor)**

---

- 호스트 운영 체제 위에 **Hypervisor**가 설치되는 형태이다.
- [`VMware Fusion`](https://en.wikipedia.org/wiki/VMware_Fusion), [`VMware Workstation`,](https://namu.wiki/w/VMware%20Workstation) `[Parallels Workstation](https://namu.wiki/w/Parallels%20Desktop)`, [`VirtualBox`](https://namu.wiki/w/VirtualBox)

### ✅ Debian vs CentOS

**리눅스** 🐧

- *UNIX운영체제를 기반으로 만들어진 운영체제.*
    - 리누즈 토발즈(Linus Torvalds)에 의해 만들어진 컴퓨터                                                                                                                                                           운영체제로, **자유 소프트웨어와 오픈 소스 개발**의 가장 유명한 표본.
    - 공개 소프트웨어이기 때문에 그룹이나 회사 등에서 **커널소스를 받아 OS를 직접 제작**하여 사용된다.
    - 따라서 특정 기관이 배포를 책임지는게 아니어서 드럽게 많은 배포판이 나오게 된다.
    
    <aside>
    💿 **GUI : Graphical User Interface
    CLI : Command Line Interface
    *대부분의 리눅스가 GUI와 CLI를 지원하고 있다.**
    
    </aside>
    
    **네트워크 운영체제**
    
    ---
    
    - 다중 사용자, 다중 작업(멀티 테스킹), 다중 스레드를 지원하는 네트워크 운영체제.
    - 리눅스 원형인 유닉스가 통신 네트워크를 지향하여 설계되었듯, 리눅스 역시 **서버로 작동하는데 최적화되어 있다.**
    - **Linux와 Unix는 서버 시장을 장악하고 있다.**
    
    **Unix**
    
    ---
    
    - 유료
    - 유닉스 서버는 독점적이고 폐쇄적이라 안정성이 높지만, 서버 자체가 비싸다.
    
    **Linux**
    
    ---
    
    - 무료
    - 리눅스는 기업 입맛에 맞게 재구성해서 사용할 수 있다.
    - 버그 수정과 버전 업데이트가 유닉스보다 매우 빠르다.
    - 금융권을 제외한 현제 서버 시장의 OS는 대부분 리눅스가 차지하고 있다.
    
    **리눅스 파일 시스템**
    
    ---
    
    *파일 : 주기억장치나 디스크처럼 하드웨어 저장공간에 저장되는 데이터의 집합. 대부분의 파일 시스템은 **디렉토리**와 **파일**의 형태로 구성.*
    
    - 파일시스템 종류
        - FAT : File Allocate Table → 메모리 카드와 수많은 컴퓨터 시스템에 널리 쓰임.
        - NTFS : New Technology File System → Window NT 계열의 새로운 파일 시스템. 기존 FAT 구조 대체하기 위함.
        - EXT : EXTended file system → 리눅스 기본 파일 시스템.
    - 리눅스 디렉토리 구조
        - bin : 기본 명령어들이 저장된 폴더
        - boot : 리눅스의 boot(시작)와 관련한 명령이 들어간 폴더
        - etc : 리눅스의 거의 모든 설정 파일이 들어간 폴더
        - home : 말그대로 홈 폴더, 로그인한 계정에 따라 폴더가 만들어짐
        - lib : 리눅스 및 각종 프로그램에서 사용되는 라이브러리들의 폴더
    
    **Mount**
    
    ---
    
    *물리적인 저장장치(디스크 공간)를 디렉토리(폴더)에 연결시켜주는 것을 말한다.*
    
    ***리눅스의 경우 PnP(Plug and Play) 기능이 작동하지 않아서** mount 작업을 수행해야 한다.*
    

**리눅스 종류**

*[크게 슬렉웨어, 데비안, 레드햇 계열로 나눌 수 있다.](https://upload.wikimedia.org/wikipedia/commons/1/1b/Linux_Distribution_Timeline.svg)*

- 간단 족보
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/226e3442-1110-4ced-bc7f-d0234e81814a/Untitled.png)
    
- Slackware → 가장 오래된 배포판.
- Debian → Ubuntu의 어머니? (오픈소스쪽에 가깝다.)
- Redhat → 현재는 RHEL(Red Hat Enterprise Linux) 상용 버전만 존재. (상용쪽에 가깝다.)

**CentOS**

---

- 기업용 서버OS로 주로 사용한다. (네이버, 카카오)
- RHEL에서 사후 기술지원과 상표권을 배제하고 제작한 무료 오픈소스이다. (유료화 반발)
- Redhat의 기술을 그대로 사용할 수 있다.
- 문제 발생시 패치가 다소 느림.
- 패키지 포맷으로 `.rpm` 확장자를 사용하고, `yum`을 패키지 관리 툴로 사용한다.

**Debian**

---

- 무료 개인 사용자 서버용으로 인기가 높다.
- 온라인 커뮤니티에서 개발한 리눅스 배포판.
- 패키지 설치 및 업그레이드가 단순하고 편하다.
- 사용법이 온라인 웹사이트나 커뮤니티에 자세히 기술되어 있다.
- 초보 리눅스유저들이 접근하기 쉽다.
- 패키지 포맷으로 `.deb` 확장자를 사용하고, `dpkg`와 `APT`를 패키지 관리 툴로 사용한다.

**커널**❓

*운영체제의 핵심 기능 부로 컴퓨터 자원들을 관리하는 역할을 한다.*

*즉 사용자가 `system call`을 통해 컴퓨터 자원을 사용할 수 있게해주는 자원 관리자이다.*

- 운영체제 - 커널, 시스템 프로그램으로 구분된다.
- 커널은 항상 컴퓨터 자원들만 바라보고 있어서, 사용자와 상호작용을 하는 시스템 프로그램(ex : `Shell`)이 필요하다.
- 리눅스 커널은 모든 소스가 모든 사용자에게 오픈이 된다.
- 커널의 구성요소
    1. 태스크(Task) 관리자
        - 물리적 자원인 CPU를 추상적 자원인 태스크로 제공
        - task에는 사용자의 명령이 담겨져 있다. 컴퓨팅 언어로 작성된 프로그램 파일이 결국 task들이 된다.
    2. 메모리(Memory) 관리자
        - 물리적 자원인 메모리를 추상적 자원인 페이지나 세그먼트로 제공
    3. 파일 시스템(File System) 관리자
        - 물리적 자원인 디스크를 추상적 자원인 파일로 제공
    4. 네트워크(Network) 관리자
        - 물리적 자원인 네트워크 장치를 추상적 자원인 소켓으로 제공
    5. 디바이스 드라이버(Device Driver) 관리자
        - 각종 외부 장치에대한 접근

### ✅ Apt and aptitude

*패키지 관리 프로그램의 한 유형*

**패키지**❓

*시스템에서 소프트웨어를 실행하는데 필요한 파일(실행 파일, 설정 파일, 라이브러리 등)들이 담겨있는 설치 파일 묶음이다.*

*코드의 배포를 위해서 사용되는 코드의 묶음.*

- 라이브러리는 코드 작성을 위해 필요한 코드 모임이라면, 패키지는 코드의 배포를 위해 사용되는 코드 모음이다.

**패키지 매니저**❓

*패키지를 다루는 작업(설치, 업데이트, 수정, 삭제)을 편리하고 안전하게 수행하기 위해 사용되는 툴.*

ex) apt, aptitude, homebrew(macOS)

**APT (Advanced Packaging Tool)**

---

- `GUI`가 없고 `CLI`로 사용한다.
- 과거에는 설치, 제거, 업데이트에서 `apt-get`을, 검색과 확인에서는 `apt-cache`를 따로 사용했지만, 최근에는 모두 `apt`로 통일되었다.
- **데비안 리눅스 또는 파생된 배포판(우분투)에서** 소프트웨어를 설치, 제거, 업데이트할 때 사용한다.

**Aptitude**

---

- `GUI`와 `CLI` 모두 제공한다.
- `APT`의 프론트엔드 프로그램.
- `APT` 보다 기능면에서 광범위하다.
- `higher-level` 패키지 매니저로 번거로운 작업을 자동화해주어, `apt`나 `dpkg`보다 쉽게 사용 할 수 있다.

**APPArmor (Application Armor)**❓

*시스템 관리자가 프로그램 프로필 별로 프로그램 보안을 세팅 할 수 있게 해주는 리눅스 커널 보안 모듈이다.*

- Mandatory Access Control(MAC)로 관리자가 특정 프로그램에 대한 네트워크, 소켓, 입출력 등에 대한 접근을 제한할 수 있게 한다.
- AppArmor는 정책 파일을 통해 어떤 응용 프로그램이 어떤 파일/경로에 접근 가능한지 허용해준다.
- `/etc/apparmor.d`디렉토리에 저장되며, `enforce 모드`와 `complain 모드`두 가지 모드가 존재한다.
    - enforce 모드 : 응용 프로그램이 허가되지 않은 파일에 접근하는 것을 거부함
    - complain 모드 : 응용 프로그램을 제한하지 않아 실질적으로 보안을 제공하는 것은 아니지만, 위반 사항을 보고하는 로그를 남겨줌(중지하지는 않음)

```bash
$ sudo apt --installed list apparmor #apparmor 설치 확인
$ sudo apt install apparmor #apparmor 설치(없다면)
$ sudo apt install apparmor-utils #apparmor utils 설치

$ aa-enabled #활성화 여부 확인
$ sudo aa-status #현재 상태 확인 가능(enforced, complain, unconfined)
```

**접근통제 (Access Control)** 🚫

- *시스템 자원을 적절한 권한을 가진 사용자나 그룹이 접근하고 사용할 수 있게 통제하는 것.*
    
    <aside>
    💡 **시스템 자원 : 객체(object)
    자원에 접근하는 사용자나 프로세스 : 주체(subject)**
    
    </aside>
    
    - 주체가 객체를 참조할 때는 직접 참조하지 않고, **보안 커널**을 통해 참조한다.
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/832b2f21-80fc-4b2e-b718-b366dea0ef90/Untitled.png)
        
    
    **접근통제 단계**
    
    - **식별**(사용자 ID, 계정 번호, 메모리 카드 확인 등) → **인증**(패스워드, 토큰, 생체 인증 확인 등) → **인가**(접근 제어 목록; ACL, 보안 등급)
    
    **접근통제 정책**
    
    *세 가지 주요 접근 통제 정책으로 `DAC`, `MAC`, `RBAC`가 있다.*
    
    - **DAC**
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f154a6f2-0fed-468a-b841-c32c8f3b621a/Untitled.png)
        
    
    ---
    
    - 임의 접통(Discretionary Access Control)
    - **사용자나 그룹의 신분으로 통제: 사용자나 그룹의 신분을 기준으로 시스템 객체에 대한 접근을 제한한다.**
    - 객체의 소유자인 사용자나 그룹의 판단에 의해 다른 주체에게 이 객체의 접근 권한을 줄 수 있다.
    - 대부분의 OS가 DAC에 기반한다.
    
    - **MAC**
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/80c23157-34a5-436d-b1f2-c776018a5c69/Untitled.png)
        
    
    ---
    
    - 강제 접통 (Mandatory Access Control)
    - **보안 등급으로 통제: 미리 정해진 정책과 보안 등급(보안 레이블, 보안 허가증)에 의거해 주체에게 허용된 접근 권한과 객체에게 부여된 허용 등급을 비교해 접근을 통제한다.**
    - 낮은 보안 등급의 주체는 더 높은 보안 등급의 객체에 접근이 불가하다.
    
    *전통적으로 Linux와 UNIX 시스템은 DAC를 사용해왔다. 하지만 **SELinux(Security-Enhanced Linux)와 AppArmor는 Linux용 MAC 시스템의 대표적인 예이다.***
    

## Check

---

### ✅ GUI 환경 🙅🏻‍♂️ Password requested 🙆🏻‍♂️

### ✅ Password policy

- *길이 10자 이상, 대문자, 숫자 포함, 같은 문자 최대 3번.*
    
    **패스워드 만료일 =** /etc/login.defs
    
    PASS_MAX_DAYS 30 → 30일 후 만료
    PASS_MIN_DAYS 2  → 최소 사용기간 2일
    PASS_WARN_AGE 7  → 7일전에 경고 보내기
    
    **패스워드 정책** = /etc/pam.d/common-password
    minlen=10 → 최소 길이 10
    difok=7 → 기존 패스워드와 달라야 하는 문자 수 7
    maxrepeat=3 → 동일한 문자를 반복 가능한 최대 횟수 3
    ucredit=-1 → 대문자 한개 이상 포함
    dcredit=-1 → digit 한개 이상 포함
    reject_username → username이 그대로 혹은 reversed 된 문자는 패스워드로 사용 불가
    enforce_for_root → root 계정도 위의 정책들 적용
    
    ```bash
    sudo apt install libpam-pwdquality #추가 패스워드 정책에 필요한 패키지
    ```
    
    [추가 패스워드 정책 참조](https://manpages.debian.org/bullseye/libpam-pwquality/pam_pwquality.8.en.html#Contains)
    

```bash
$ sudo passwd -e [username] #패스워드 만기
```

### ✅ Check UFW service

```bash
$ sudo ufw status #+numbered 숫자표시
```

### ✅ Check SSH service

```bash
$ systemctl status ssh #openserver 실행 중인지 확인
$ ss -tunpl #정보확인
```

### ✅ Check Debian

```bash
$ hostnamectl #정보확인
```

## User

---

### ✅ sudo와 user42 group에 속해있는지 확인

```bash
$ getent group sudo user42 #그룹의 모든 구성원 나열 명령어
#or
$ id #사용자 이름(uid), 사용자 기본 그룹(gid), 사용자의 보조 그룹(groups) 표시
#or 
$ groups # id -nG랑 같은 결과
```

### ✅ Passwd policy 적용 여부 확인

```bash
$ chage -l [user] #패스워드 만기 정보 표시
$ sudo vi /etc/login.defs #패스워드 만기 수정
$ sudo vi /etc/pam.d/common-password #패스워드 정책 수정
$ sudo vi /etc/shadow #패스워드 관련 설정이 저장되어 있음
```

### ✅ Create new user

```bash
$ sudo adduser [newuser] #user 생성성
$ sudo passwd [newuser] #newuser 패스워드 설정
$ sudo addgroup [newgroup] #group 생성
$ sudo usermod -aG [newgroup] [newuser] #newuser를 newgroup에 배정
# -G는 user가 명시된 그룹에만 속하게 된다. -aG는 기존에 속한 그룹 + 명시된 그룹에 속하게 된다.
$ sudo userdel -f [user] #강제삭제
```

## Hostname and partition

---

### ✅ Hostname check

```bash
$ hostnamectl #정보확인
```

### ✅ Modify hostname and restart

```bash
$ sudo hostnamectl set-hostname <HOST_NAME> #호스트 네임 변경
$ sudo reboot #가상머신 reboot
```

### ✅ Partitions

*수박 한 통(디스크 하나)을 원하는 크기의 여러 조각(파티션)으로 나누는 것.*

- *하나의 디스크에 대한 영역을 나누거나 여러 개의 디스크를 통합하는 것이다.*
    
    **설치과정**
    
    *암호화된 파티션(sda5_crypt) **(변환)→** 물리볼륨(PV, sda5_crypt) **(생성)→** 볼륨그룹(VG, LVMGroup)**(나누어 크기 설정)→** 논리볼륨(LV, root•swap•home 등) **(연결)→** 마운트 포인트(/•/home•/var•/srv 등)*
    
    ```
    $ lsblk # 리눅스 디바이스 정보 출력, 트리형식으로 모든 스토리지 디바이스를 출력
    ```
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/11de85d9-2a78-4afc-aa8a-65755e279489/Untitled.png)
    
    논리그룹과 각각의 디렉토리에 마운트포인트로 연결해 사용한다.
    
    - /root : 최상위 마운트 파티션으로 최상위 디렉토리
    - /swap : 가상 메모리로 사용되는 파티션(실제 물리적인 램이 부족할 때 대신 사용됨), 루트와 함께 꼭 필요한 파티션임
    - /home : 사용자 계정 파티션, 사용자 계정이 위치함
    - /var : 로그 파일 파티션, 시스템의 로그 파일들이 저장됨
    - /srv : 서버 파티션, 프로토콜을 이용하여 외부 사용자와의 공유를 위해 사용됨
    - /tmp : 임시 파티션, 임시 파일들을 저장하거나 시스템에서 임시로 작업을 진행할 때 사용하는 파티션
    - /var/log : 프로그램 로그파일들이 따로 저장되는 디렉토리
    - /boot : 커널 부트 이미지 파티션으로 부팅 시스템 파일들이 설치됨

### ✅ **LVM(Logical Volume Manager, 논리 볼륨 관리자)**

*여러개의 과일(디스크 공간)이나 짜투리 과일(짜투리 공간)을 합쳐서, 하나의 화체 (LV)를 만든 것.*

- *리눅스의 저장 공간을 효율적으로 관리하고 사용하기 위한 커널의 한 부분이다.*
    
    **볼륨(Volume)**❓
    
    *컴퓨터가 인식할 수 있는 파일 시스템을 사용하여 접근할 수 있는 저장 영역.*
    
    - LVM은 물리적인 디스크를 논리적인 디스크로 할당하여 유연하게 관리할 수 있게 해준다.
    - 즉, 여러개의 하드 디스크 공간을 합쳐서 **하나의 디스크처럼** 사용할 수 있고 기존에 사용중인 디스크의 공간을 자유롭게 확장할 수 있다. 또한 `partitions`의 애매한 공간을 활용 할 수 있다.
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e97f20e8-2663-4165-aec2-49b88c64ef9c/Untitled.png)
    
    - `Partition`: 고정적이고 물리적인 개념이 강해 한 번 크기를 설정하면 변경이나 추가가 어렵다. 운영체제는 이 파티션을 디스크처럼 인식한다.
    - `PV(Physical Volume)`: LVM에서 사용할 수 있도록 파티션을 물리적 볼륨으로 변환하는 것이다. 디스크의 파티션을 PV로 초기화시키고 일정한 크기의 `PE(Physical Extent)`(PV 최소 단위, 기본 4MB)로 구성된다.
    - `VG(Volume Group)`: PV가 모여 만들어진 그룹으로, LV를 할당할 수 있는 공간이다.
    - `LV(Logical Volume)`: 사용자가 최종적으로 다루는 논리 볼륨이다. 마운터 포인터로 사용할 실질적인 파티션이다. 크기를 확장하고 축소시킬 수 있으며, 일정 크기의 `LE(Logical Extent)`(LV 최소 단위, 기본 단위는 PE와 같음)로 구성된다.
    
    *LVM은 볼륨이라는 단위로 저장장치를 다루고, 물리적인 디스크를 VG로 묶어 다시 LV로 나누어 파일 시스템을 만든다. 파일 시스템은 이 LVM이 만든 가상의 블록 장치에 읽고 쓰기를 한다.*
    

[LVM 참고](https://mamu2830.blogspot.com/2019/12/lvmpv-vg-lv-pe-lvm.html)

## SUDO

---

### ✅ Check sudo

```bash
$ sudo --version
#or
$ dpkg -l sudo #패키지 리스트 확인
```

### ✅ sudo 그룹에 newuser 할당

```bash
$ sudo usermod -aG sudo [newuser] #newuser를 sudo에 배정
# -G는 user가 명시된 그룹에만 속하게 된다. -aG는 기존에 속한 그룹 + 명시된 그룹에 속하게 된다.
```

### ✅ sudo의 가치와 작동 설명, 과제의 엄격한 룰과 함께

👑 **sudo(Super User Do 또는 substitute user do)**

*임시 root 권한으로, 루트가 아닌 다른 유저에게 제한적으로 관리자 권한을 부여하는 용도로 사용한다.*

❓**root**

- *유닉스 계열에서 모든 제어권한을 가지고 있는 최고관리자의 ID 혹은 관리자 그 자체.*
    - ‘#’ 프롬포트 (일반 사용자는 ‘$’(’%’) 프롬포트)
    - 유닉스 계열의 모든 운영체제에는 root 유저가 존재한다
    - 컴퓨터 주인의 계정도 root보다 권한이 낮다.
    - 시스템 관리 작업을 할 때는 sudo를 통해 임시 root 권한을 얻는다.

❓**su (switch user)**

- *계정 전환 명령어*
    
    sudo (명령어)
    
    - *일반 사용자가 root권한을 잠시 빌려 명령을 실행한다.*
    
    su (계정명)
    
    - *현재 사용자를 로그아웃하지 않은 상태에서 다른 사용자의 계정으로 전환하는 명령어.*
    
    su - (계정명)
    
    - *다른 사용자의 계정으로 완전히 전환하고, 전환한 사용자의 환경설정을 불러온다.*
    - 기본 /root 디렉토리로 이동한다.

🛠️ **sudo 사용**

```bash
sudo [command] #현재 사용자의 패스워드 필요
```

*하나의 명령에 대해 일시적으로 root 권한을 사용한다.*

- sudo 명령어는 `/etc/sudoers`설정 파일에 명시 되어 있는 유저만 사용 가능하다.

🛠️ **sudo 설정**

```bash
$ whoami #현재 사용자 확인
$ su - #root계정의 홈으로 전환
$ apt install sudo #sudo 패키지 설치
$ apt --installed list sudo #sudo 패키지 설치 여부 확인
$ mkdir /var/log/sudo #sudo log를 저장할 디렉토리 생성
$ sudo visudo #sudo 설정하러 가기
```

- subject sudo edit
    
    ```
    1. `sudo` 인증시에는 비밀번호가 틀렸을 때 3번의 기회만이 주어져야 합니다. ⇒ passwd
    2. `sudo` 권한 사용 중에는 비밀번호가 틀렸을 때 여러분이 설정한 오류 메시지가 출력되어야 합니다.
    3. `sudo` 권한을 이용하여 수행한 명령어들은 입출력 모두 기록되어야 합니다. 해당 기록은 log 파일로 /var/log/sudo 폴더에 저장되어야 합니다.
    4. 보안상의 문제 때문에, TTY 모드는 활성화되어 있어야 합니다.
    5. 마찬가지로 보안상 문제 때문에, `sudo` 권한으로 이용할 수 있는 폴더 경로는 반드시 제한되어야 합니다.
    ```
    
    env_reset #HOME, LOGNAME, PATH, SHELL, TERM, USER을 제외한 모든 환경 변수를 reset
    
    mail_badpass #잘못된 패스워드로 sudo 실행 시, 지정된 메일로 보고
    
    secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin" #끝에 /snap/bin 추가
    
    authfail_message="원하는 에러메세지" #권한 획득 실패 시 출력 (sudo 인증 실패 시)
    
    badpass_message="원하는 에러메세지" #sudo인증에서 비밀번호 틀리면 출력
    
    log_input #sudo명령어 실행 시 입력된 명령어 log로 저장
    
    log_output #sudo명령어 실행 시 출력 결과를 log로 저장
    
    requiretty #sudo명령어 실행 시 tty강제
    
    - iolog_dir="/var/log/sudo/" #sudo log 저장 디렉토리 설정
        
        ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/42a7e659-83d5-4025-afa4-e37cc29d84e4/Untitled.png)
        
        `log` : sudo 실행 시 **실행한 위치와 명령어**의 위치
        
        `stderr` : sudo로 실행한 명령어가 오류일 때의 **에러메세지** 저장
        
        `stdin` : sudo로 실행한 명령어가 **표준입력** 받은 내용
        
        `stdout` : sudo로 실행한 명령어의 **표준출력** 내용
        
        `timing` : **session timing file**
        
        `ttyin` : sudo로 실행한 명령어가 **tty로 입력받은 내용**
        
        `ttyout` : sudo로 실행한 명령어가 **tty로 출력한 결과**
        
    
    passwd_tries=3 #sudo 패스워드 입력 3회 제한.
    

❓**secure_path**

- *sudo에서 제공하는 보안 기능 중 하나*
    - sudo 명령어를 실행 할 때 쉘 명령어를 secure_path로 저장된 경로에서 찾아 실행한다.
    - **secure_path에 해당하지 않는다면 이를 무시한다.**
    - secure_path는 트로이목마 해킹 공격에 대한 일차적인 방어 기능을 제공한다.
    
    [트로이목마 참고 사이트](https://www.tuwlab.com/ece/24044)
    

**❓ visudo**

- *sudo의 설정파일 편집기*
    - sudo 권한 편집 가능.
    - visudo를 쓰지 않고 vi /etc/sudoers를 편집하다 실수하면 sudo를 쓰지 못하게 되어 문법체크를 해주는 visudo를 권장한다.
    - sudoers 파일은 소유자인 root도 쓰기 권한이 없다. (있으면 심각한 보안상의 문제 야기 가능)

**❓ TTY (Teletypewriter)**

- *리눅스의 콘솔 및 터미널을 의미한다. (현재 커널과 연결된 가상 터미널 장치 확인 가능)*
    
    ❓콘솔(console): 서버의 로컬 장치에서 직접 명령어를 작성하는 입출력 장치
    
    ❓쉘(shell): 커널과 사용자를 연결하는 인터페이스, 명령어를 해석해 전달해줌
    
    ❓터미널(terminal): 콘솔의 한 종류, 컴퓨터와 사용자 간에 서로 상호작용 할 수 있는 CLI 인터페이스
    
    ❓pty(Pseudo-terminal): 가상 tty, 가상 터미널 환경
    
    ❓pts(Pseudo-terminal slave): 원격 터미널 환경
    
    - tty 모드를 활성화하면, 아래와 같이 터미널을 할당하지 않은 상태에서는 sudo 명령어를 실행할 수 없다.
    
    ex) 터미널에서 바로 sudo 명령어를 사용해서 ssh로 연결할 수 없다. tty가 할당이 된 상태에서만 sudo 명령어 사용 가능.
    

**🛠️ sudo 사용 이유**

- sudo 사용시에 `sudoers`에 노출되고 log가 남아서 추적이 쉬워진다.
- root 패스워드 공유 불필요.
- root 계정에 장시간 머무를 일이 없어져서 위험한 command 실행 가능성이 낮아진다.

### ✅ /var/log/sudo 폴더 확인 및 업데이트 확인

```bash
$ sudo ls /var/log/sudo #폴더에 한 개 이상 파일 존재 확인
$ sudo [명령어]
$ sudo ls /var/log/sudo/00/00 #로그 파일 업데이트 확인
```

## UFW

---

### ✅ UFW 설치 및 작동 여부 확인

```bash
$ sudo apt install ufw #ufw 방화벽 설치
$ ✅ sudo ufw status #+verbose 상태 확인(디폴트는 inactive)
$ sudo ufw enable #부팅시 ufw 활성화 하기 disable=비활성화
$ sudo ufw default deny #기본 incoming deny //allow는 허용
$ sudo ufw allow 4242 #4242port로 ssh 연결 허용 //deny는 차단
$ sudo ufw status numbered #규칙번호 확인
$ sudo ufw delete 규칙번호 # 해당 번호 규칙 삭제
$ sudo ufw allow from 127.0.0.1 to any port 4242 # 로컬호스트만 4242포트로 들어오는 것 허용
$ sudo ufw allow from 127.0.0.1 to any port 4242 proto tcp # tcp기능만 허용함을 추가
```

### ✅ [UFW](https://ko.wikipedia.org/wiki/UFW) (Uncomplicated FireWall)

*데비안 계열 및 다양한 리눅스 환경에서 작동되는 사용하기 쉬운 방화벽 관리 프로그램.*

- *외부에서 내부로 접속을 시도할 때 내부 시스템으로 허용하거나 차단하는 용도로 사용된다.*
    - Linux 커널은 서버에 대한 `client`의 네트워크 접속을 제어하는 `netfilter Module`을 가지고 있다. 이것을 이용하여 서버 접속에 대한 `network policy`를 세우는 프로그램이 바로 `Firewall`(방화벽)이다.
    - 리눅스에서 가장 많이 사용하는 것이 `iptables` 인데, 설정과 관리가 겁나 복잡하기 때문에 이 작업을 간편화 해주는 소프트웨어가 바로 `UFW`(Uncomplicated FireWall)이다.
    
    **UFW 기본 rules**
    
    - deny : 들어오는 [패킷](https://ko.wikipedia.org/wiki/%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC_%ED%8C%A8%ED%82%B7#:~:text=%ED%8C%A8%ED%82%B7(packet%2C%20%EB%AC%B8%ED%99%94%EC%96%B4%3A%20%ED%8C%8C,%EC%9D%B4%EB%8A%94%20%ED%8E%98%EC%9D%B4%EB%A1%9C%EB%93%9C%EB%9D%BC%EA%B3%A0%EB%8F%84%20%ED%95%9C%EB%8B%A4.)에 대해서는 전부 거부
    - allow : 나가는 패킷에 대해서는 전부 허가

**사용이유**

- 서버와 서버간 or 서버와 단말 사이에서, 유해하거나 잠재적으로 원치 않는 컨텐츠와 통신을 필터링 가능.
- 사용자 인증, 주소변환, 감사기록 등이 장점.
- 강력한 접근제어를 제공하기 위해 외부망과 내부망의 구성을 위한 별개의 네트워크를 가진다.

### ✅ active rules 확인 및 새로운 rule 추가 & 삭제

```bash
$ sudo cat /etc/ufw/user.rules #rule존재 확인
$ sudo ufw allow 8080 #8080포트를 열어줌
$ sudo cat /etc/ufw/user.rules #다시 확인
$ sudo ufw status numbered #포트 번호 확인
$ sudo ufw delete <NUMBER> #포트 삭제
```

## SSH

---

### ✅ SSH 설치 및 작동 확인

```bash
$ apt --installed list openssh-server # openssh가 깔려 있는지 확인(기본적으로 깔려있음)
$ apt install openssh-server # openssh 설치(없다면)
$ sudo ufw allow 4242 # 4242 포트 허용
$ sudo vim /etc/ssh/sshd_config # 포트 번호 변경과 외부에서 루트 로그인 허용을 위해 파일 열어 수정
$ sudo systemctl restart ssh # 수정 후, 다시 시작해서 설정 적용
$ systemctl status ssh # openssh 실행 여부, 사용 포트 확인
```

- ❓**OpenBSD Secure Shell server(openssh)**
    
    *ssh 프로토콜을 이용해서 암호화된 통신세션을 컴퓨터 네트워크에 제공하는 컴퓨터 프로그램의 모임을 말한다.*
    

### ✅ SSH (Secure Shell)

*원격으로 호스트(Shell)에 접속하기 위해 사용 되는 보안 프로토콜.*

ex) 데이터 전송(git push), 원격제어 (aws같은 클라우드 서비스)

🔐 **작동방식**

- *SSH는 한 쌍의 Key를 통해 접속하고자 하는 컴퓨터와 인증 과정을 거치고, 안전한 통신 채널을 만든다.*
    
    (`ssh-keygen`명령어를 사용해 한쌍의 key(`public key`/`private key`)를 생성할 수 있다.)
    
    - `public key` (id_rsa.pub): 메세지를 전송하기 전 **암호화**(복호화는 불가능)
    - `private key` (is_rsa): 암호화된 메세지를 **복호화(**절대 노출되어선 안됨)
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6e939c22-cc63-4630-9f33-2954e791be59/Untitled.png)
    
    1. 클라이언트가 통신하고자 하는 서버에 요청을 보낸다.
    2. 응답을 하는 서버가 저장하고 있던 `public key`를 보낸다.
    3. 클라이언트는 해당 공개키가 자신의 `private key`와 한 쌍의 키가 맞는 지 검사한다.(클라이언트에서 자물쇠와 키를 만들어 키를 서버에 보내고, 통신하고자 할 때 다시 그 키가 자물쇠에 맞는 지 확인하는 것이라고 이해하면 쉽다.)
    4. 한 쌍의 키가 맞는 것이 증명되면 드디어 두 컴퓨터 사이에 암호화된 채널이 생성된다.
    
    [SSH 참고](https://overcome-the-limits.tistory.com/310)
    

🔐 **사용이유**

- 보안보안보안보안보안보안보안보안보안
    - 일반적으로 FTP, Telnet 등의 프로토콜은 메시지들이 암호화 되지 않은 방식이므로 해킹에 매우 취약하다.
    - SSH는 해커가 public key를 알아냈다 하더라도, private key가 없으면 접근이 불가능하기 때문에 훨씬 안전하다.

### ✅ SSH service only uses port 4242

```bash
$ sudo vi /etc/ssh/sshd_config #포트 번호 확인
#sshd_config는 server 설정, ssh_config는 client 설정
```

### ✅ New user login

```bash
$ ssh <NEW_USER>@<MAC_IP> -p <HOST_PORT> 
#ifconfig = 로컬 IP 확인 명령어, hostname -I = 가상환경 IP주소 확인 명령어
```

**❓SSH를 이용한 root 연결을 허용하면 절대 안되는 이유**

- 보안보안보안보안보안보안보안보아보아보아
    
    1. 관리자가 원격에서 시스템 관리를 위해 [telnet](http://wiki.hash.kr/index.php/%ED%85%94%EB%84%B7)을 사용하는 경우, [스니핑](https://www.ahnlab.com/kr/site/securityinfo/secunews/secuNewsView.do?menu_dist=3&seq=5185)에 의해 관리자의 비밀번호가 유출될 수 있습니다.
    2. 다수의 관리자가 원격에서 하나의 관리자 ID를 사용하면, 시스템에 문제 발생 시 책임 소재 규명이 어렵다.
    

📂 **Port Forwarding**

- *특정한 포트로 들어오는 데이터 패킷을 다른 포트로 바꿔서 다시 전송해주는 작업을 하는 것이다.*
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f2ef0a8b-18e0-4711-9394-aae89d1738d7/Untitled.png)
    
    - `HOST IP`: 127.0.0.1(localhost, 자기 자신) 또는 `ifconfig`의 값
    - `GuestIP`: `hostname -I`의 값
    - `HOST PORT`: 4242(임의로 설정해줌)
    - `GUEST PORT`: 4242(앞서 가상머신에서 허용해 준 포트번호)

❓**TCP (transmission control protocol)**

*TCP와 UDP는 네트워크 계층들 중 전송계층에서 사용하는, 데이터를 보내기 위해 사용하는 프로토콜이다.*

**❓IP**

[컴퓨터가 연결된 네트워크 끝단의 주소](https://www.youtube.com/watch?v=GK3h936Co-k&t=14s)

## Script monitoring

---

### ✅ Script

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7f90dd1c-660f-401a-8173-20ac375526b8/Untitled.png)

- **설명**
    
    ```bash
    Architecture : 운영 체제 및 해당 커널 버전의 아키텍처
    CPU physical : 물리적 프로세서의 수
    VCPU : 가상 프로세서의 수
    Memory Usage : 서버에서 현재 사용 가능한 RAM 및 사용률(백분율)
    Disk Usage : 서버의 현재 사용 가능한 메모리 및 사용률(백분율)
    CPU load : 프로세서의 현재 사용률을 백분율로 표시
    Last boot : 마지막 재부팅 날짜 및 시간
    LVM use : LVM이 활성 상태인지 여부
    Connections TCP : 활성 연결 수
    User log : 서버를 사용하는 사용자 수
    Network : 서버의 IPv4 주소 및 해당 MAC(Media Access Control) 주소
    Sudo : sudo 프로그램으로 실행된 명령 수
    ```
    
- **코드**
    
    ```bash
    #!/bin/bash
    
    printf "#Architecture: "
     uname -a #시스템 정보 출력 명령어
    
    printf "#CPU physical : "
     nproc --all #설치된 모든 코어/프로세스 수 출력
    
    printf "#vCPU : "
     cat /proc/cpuinfo | grep processor | wc -l #CPU 정보가 담겨있는 파일 중 프로세스만 찾아 개수 출력
    
    printf "#Memory Usage: "
     free -m | grep Mem |awk '{printf"%d/%dMB (%.2f%%)\n", $3, $2, $3/$2 * 100}' 
    #free : 시스템 메모리 사용 현황 출력 명령어 메가바이트 단위 표시
    
    printf "#Disk Usage: "
    df -a -BM | grep /dev/map | awk '{sum+=$3}END{print sum}' | tr -d '\n'
    printf "/"
    df -a -BM | grep /dev/map | awk '{sum+=$4}END{print sum}' | tr -d '\n'
    printf "MB ("
    df -a -BM | grep /dev/map | awk '{sum1+=$3 ; sum2+=$4 }END{printf "%d", sum1 / sum2 * 100}' | tr -d '\n'
    printf "%%)\n"
    #df: 파일시스템 디스크 공간의 사용량을 출력하는 명령어 
    #-a: 0 블록의 파일시스템을 포함해 모든 파일시스템을 출력하는 옵션 
    #-B: 지정한 크기(SIZE)를 블록단위로 정하여 용량 표시하는 옵션
    #-BM: 크기를 1M으로 블록단위를 정해 용량을 표시
    
    printf "#CPU load: "
    mpstat | grep all | awk '{printf "%.2f%%\n", 100-$13}'
    #mpstat: 사용가능한 CPU와 Core 별 사용량을 출력하는 명령어 (sysstat 설치 필요)
    
    printf "#Last boot: "
    who -b | awk '{printf $3" "$4"\n"}'
    #who: 호스트에 로그인한 사용자 정보 출력 // -b: 마지막 시스템 부팅 시간을 출력하는 옵션
    
    printf "#LVM use: "
    if [ "$(lsblk | grep lvm | wc -l)" -gt 0 ] ; then printf "yes\n" ; else printf "no\n" ; fi
    
    printf "#Connections TCP : "
    ss | grep -i tcp | wc -l | tr -d '\n'
    printf " ESTABLISHED\n"
    #ss: 소켓 상태를 조회할 수 있는 유틸리티로 netstat와 비슷한 역할을 수행한다.
    
    printf "#User log: "
    who | wc -l
    
    printf "#Network: IP "
    hostname -I | tr -d '\n'
    printf "("
    ip link show | awk '$1 == "link/ether" {print $2}' | sed '2, $d' | tr -d '\n'
    printf ")\n"
    #ip : IP 유틸리티는 모든 최신 Linux 배포 환경에 설치된 iproroute2 패키지의 일부로, 인터페이스를 위/아래로 가져오고, 주소와 경로를 할당 및 제거하고, ARP 캐시를 관리하는 등 다양한 용도로 사용된다.
    #link: 네트워크 인터페이스를 표시하고 수정한다.
    #show: 관련 인터페이스 출력한다.
    
    printf "#Sudo : $(cat /var/log/auth.log | grep 'COMMAND=' | wc -l) cmd\n"
    
    exit 0
    ```
    

### ✅ Cron

*특정 작업을 특정 시간에 자동으로 실행시키기 위한 시간 기반 `job scheduler`형 `daemon`이다.*

- cron 프로세스는 `/etc/crontab` 파일에 설정된 것을 읽어 작업을 수행한다.
- crontab은 cron작업을 설정하는 파일이다.

**❓daemon**

- *사용자가 직접적으로 제어하지 않고, 백그라운드에서 돌면서 여러 작업을 하는 프로그램을 말한다.*
    
    *백그라운드 프로세스와 다른점은 사용자와 상호작용하지 않는 독자적인 프로세스란 것이다.*
    

**❓Wall**

```bash
$ sudo crontab -l #크론탭 리스트 확인
$ sudo crontab -e #크론탭 수정
$ sudo service cron restart #수정하고 다시시작
$ sudo systemctl disable cron #cron disable
$ sudo reboot #재시작
$ sudo service cron status #cron status
$ sudo systemctl enable cron #cron enable
```

# Bonus

---

### ✅ WordPress with : lighttpd, MariaDB, and PHP

*워드프레스(WordPress)는 오픈 소스 블로그 소프트웨어이다.*

🛠️ **워드프레스 설치**

*설치하려면 PHP를 사용할 수 있는 웹서버와 데이터베이스 서버가 필요하다.*

❓**PHP**

- 서버측에서 실행되는 프로그램 언어로 스크립트 형식으로 작성돼 있다.
    - 웹개발에 특화된 언어로, 개인이 홈페이지를 쉽게 만들기 위해 개발됐다.
    - HTML에 추가해 주면 서버에서 웹 페이지를 렌더링해준다.

웹서버 : **Lighttpd**

---

웹서버 : 우리가 인터넷에서 사용하는 웹 페이지가 들어있는 파일(HTML)을 사용자에게 제공(렌더링)해주는 서버 프로그램.

- 적은 자원을 사용하여 높은 성능을 내는 오픈소스 웹 서버 애플리케이션.

데이터베이스 서버 : **MariaDB**

---

데베서 : DB, 여러 사람에 의해 공유되어 사용될 목적으로 통합하여 관리 되는 데이터의 집합이다. 

ex) 쇼핑몰 웹사이트는 사용자 이름,나이,키 같은 데이터 정보를 저장. 

- 오픈소스(무료) [RDBMS](https://ko.wikipedia.org/wiki/%EA%B4%80%EA%B3%84%ED%98%95_%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4)(관계형 데이터베이스)입니다.

🧑🏻‍💻 **관련명령어**

```bash
$ sudo apt install lighttpd  #설치
$ lighttpd -v #버전확인
$ sudo systemctl stop lighttpd.service	#서버 중지
$ sudo systemctl start lighttpd.service	#서버 시작
$ sudo systemctl enable lighttpd.service	#서버 부팅 (enable with start up)
$ sudo systemctl status lighttpd #상태 확인
$ vi /etc/lighttpd/lighttpd.conf #lighttpd 설정 확인
```

[워드프레스 설치 참고](https://nostressdev.tistory.com/11)

[참고2](https://story-of-flower.tistory.com/456)

### ✅ Free choise service

fail2ban : 일정 시간 내에 암호가 다르면 ip차단.

ntp : 시간 동기화.

ftp : 파일 전송

php my admin : mria db 행열 테이블을 그래픽으로 설정해줄 수 있는 서비스. 한글이나 엑셀하듯이.

✋🏻 **fail2ban**

*무작위로 ssh를 통한 로그인을 시도할 경우, 해당 IP를 커널 방화벽에 등록하여 차단해준다.*

[설치 및 설정 참고](https://yumserv.tistory.com/158)

```bash
[DEFAULT]
bantime = 86400 # 인증 실패 시 차단 시간(단위 : 초) // -1로 설정 시 영구 차단
ignoreip = 127.0.0.1/8 # 관리자 IP. 이 IP는 차단되지 않습니다.
findtime = 86400 # 입력한 시간안에 허용횟수 초과시 차단(위:초)
maxretry = 5 # 차단되기 전까지 인증시도를 위한 허용횟수. 허용횟수 초과시 차단
bandaction = iptables-multiport # IP 차단 방법. 
# firewalld의 경우 firewalldcmd-new
# iptables의 경우 iptables-multiport
[sshd] #서비스 명
enabled = true # enable = true : 차단할 서비스
```

fail2ban 확인

```bash
$ sudo fail2ban-client status sshd
```
