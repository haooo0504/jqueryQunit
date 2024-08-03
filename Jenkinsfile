pipeline {
    agent any
    environment {
        DOCKER_TOOL_NAME = 'docker'
        IMAGE_NAME = 'my-jqunit'
        CONTAINER_NAME = 'jqunit'
    }

    stages {
        stage('Checkout') {
            steps {
                // 從版本控制系統中檢出代碼
                checkout([$class: 'GitSCM', branches: [[name: '*/master']],
                          userRemoteConfigs: [[url: 'https://github.com/haooo0504/jqueryQunit.git']]])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // 構建 Docker 映像
                    sh 'docker build -t ${IMAGE_NAME} .'
                }
            }
        }

        stage('Run QUnit Tests') {
            steps {
                script {
                    // 運行 QUnit 測試
                    sh 'docker run --rm ${IMAGE_NAME} npm install'
                    sh 'docker run --rm ${IMAGE_NAME} npm test'
                }
            }
        }

        stage('Deploy') {
            when {
                expression {
                    // 只有當上一步驟的測試成功時才執行部署
                    currentBuild.result == null || currentBuild.result == 'SUCCESS'
                }
            }
            steps {
                script {
                    // 確保 deploy.sh 有執行權限
                    sh 'chmod +x deploy.sh'
                    // 執行部署腳本
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        always {
            // 清理工作區
            cleanWs()
        }
    }
}
