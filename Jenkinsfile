pipeline {
    agent any
    stages {
        stage("Set Variable") {
            steps {
                script {
                    IMAGE_NAME_BE = "spring"
                    CONTAINER_NAME_BE = "spring-container"
                }
            }
        }

        // 백엔드 프로젝트 빌드
        stage("be build") {
            // build
            steps {
                sh """
                chmod 777 ./gradlew
                ./gradlew clean build
                """
            }
        }

        // 컨테이너 클리닝
        stage("container cleaning") {
            steps {
                sh "docker ps -q -f name=${CONTAINER_NAME_BE} | xargs --no-run-if-empty docker container stop"
                sh "docker container ls -a -q -f name=${CONTAINER_NAME_BE} | xargs --no-run-if-empty docker rm"
            }
        }

        // 이미지 삭제
        stage("image cleaning") {
            steps {
                sh "docker images ${IMAGE_NAME_BE} -q | xargs -r docker rmi -f"
            }
        }

        // 도커 이미지 빌드
        stage("be image build") {
            steps {
                sh """
                docker build --no-cache -t ${IMAGE_NAME_BE} .
                """
            }
        }

        // 컨테이너 실행
        stage("be container run") {
            steps {
                sh "docker run -d -p 8180:8080 --name ${CONTAINER_NAME_BE} ${IMAGE_NAME_BE}"
            }
        }
    }
}