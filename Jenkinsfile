pipeline {
    agent any
    tools{
        jdk 'java-8'
        maven 'mvn-3.6.2'
    }
    stages {
        stage('checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('build + unit test'){
            steps{
                sh """
                cd app
                mvn verify
                   """
            }
        }
    }
}
