pipeline {

    agent any
    tools {
        jdk 'java-8'
        maven 'mvn-3.6.2'
    }

    options {
        gitLabConnection('gitlab_connection')
        timestamps()
    }

    stages {
        stage('checkout') {
            steps {
                deleteDir()
                checkout scm
            }
        }

        stage('build + unit test') {
            steps {
                sh '''
                cd app
                mvn verify
                   '''
            }
        }
    }
    post {
        failure {
            updateGitlabCommitStatus name: 'build', state: 'failed'
        }

        success {
            updateGitlabCommitStatus name: 'build', state: 'success'
        }

        aborted {
            updateGitlabCommitStatus name: 'build', state: 'canceled'
        }
    }
}
