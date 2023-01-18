
def provision_test

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
                script {
                    if (lastCommitIsTest()) {
                        echo '#test detected'
                        provision_test = true
                    } else {
                        provision_test = false
                    }
                }
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

        stage('provision test enviroment') {
             when { expression { return provision_test }  }
             steps{
                sh """
                cd terraform_files/
                mkdir production
                docker save -o ./production/ tedsearch
                
                   """

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

def lastCommitIsTest() {
    lastCommit = sh([script: 'git log -1', returnStdout: true])
    if (lastCommit.contains('#test')) {
        return true
    } else {
        return false
    }
}
