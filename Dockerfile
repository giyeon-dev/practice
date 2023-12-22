# 베이스 이미지로 반드시 최상단에 위치해야 한다.
# FROM openjdk:17-jdk
# 경량화 버전 사용
FROM openjdk:17-alpine

# 젠킨스가 빌드한 백엔드 프로젝트 Jar 파일을 컨테이너 외부에서 컨테이너 내부로 복사한다.
COPY build/libs/*.jar application.jar

# 컨테이너 외부에서 사용할 포트 번호를 설정한다.
EXPOSE 8180

# 이 컨테이너가 실행될 경우 수행할 스크립트를 지정한다.
ENTRYPOINT ["java","-jar", "-Duser.timezone=Asia/Seoul", "application.jar"]