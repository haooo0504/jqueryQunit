pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // 從版本控制系統中檢出代碼
                git 'https://github.com/haooo0504/jqueryQunit.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // 構建 Docker 映像，假設 Dockerfile 在倉庫根目錄下
                    docker.build('jquery-qunit', '.')
                }
            }
        }

        stage('Run QUnit Tests') {
            steps {
                script {
                    docker.image('jquery-qunit').inside {
                        sh 'npm install' // 安裝依賴
                        sh 'npm test' // 運行 QUnit 測試
                    }
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
