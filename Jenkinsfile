
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
                def workspace = "Test_${env.BRANCH_NAME}"
                sh """
                cd terraform_files/

                terraform init
               # terraform destroy -auto-approve || echo "no enviroment was running"

                terraform workspace new ${workspace} || terraform workspace select ${workspace}

                mkdir production
                docker save -o ./production/docker_image tedsearch
                cp -r ../app/docker-compose.yml ../app/static/ ../app/nginx/ ./production/

                terraform apply -var aws_region=eu-central-1 -auto-approve
                   """
             }
        }

        stage('E2E test'){
            when { expression { return provision_test }  }
            steps{
                script{
                
                sh "echo 'Starting E2E now'"
                def IP = sh (
                    script: 'cat terraform_files/ip.txt',
                    returnStdout: true
                ).trim()
                sh "sleep 10"
                sh "bash app/e2e.sh ${IP}"

                }
            }
            post{
                always{
                    sh """
                        cd terraform_files/
                        terraform workspace select ${workspace}
                        terraform destroy -var aws_region=eu-central-1 -auto-approve
                       """
                }
            }
        }

        stage("deploy"){
            when { expression {{ return (provision_test && env.BRANCH_NAME == "main") } } }
            steps{
                sh "echo 'should deploy here"
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
