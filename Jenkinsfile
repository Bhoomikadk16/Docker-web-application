pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove docker container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=web", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop web"
                    sh "docker rm web"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create  docker image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/task/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app bhoomika720/project'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "dockeraccount" | docker login -u "bhoomika720" --password-stdin'
                sh 'docker push bhoomika720/project'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull bhoomika720/project'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name web -p 8081:8080 bhoomika720/project'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f web'
        }
        always{
            echo 'Deployed'
        }
    }

}
