pipeline {
    agent any

    stages {
        stage ('git checkout') {
            steps {
                git credentialsId: 'github', url: 'https://github.com/Angelsroy/Demo-pipeline.git'
            }
        }
        
        stage ('Maven Build') {
            steps {
                sh 'mvn clean install'
            }
        }
        
        stage ('Remove old container') {
            steps {
                sh 'docker stop $(docker ps -aq)'
                echo 'stopped all containers'
                sh 'docker stop $(docker ps -aq)'
                echo 'removed all containers'
                sh 'docker ps -a'
            }
        }
        
        stage ('Docker build') {
            steps {
                sh 'docker build -t ${BUILD_NUMBER} .'
            }
        }
        
        stage ('Docker run') {
            steps {
                sh 'docker run -it -d -p 8090:8080 ${BUILD_NUMBER}'
            }
        }
        
    }
}
