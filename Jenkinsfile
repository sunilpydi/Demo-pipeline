pipeline {
    agent any
    environment {
        registry = '******.***.ecr.us-east-1.amazonaws.com/myrepo'
    }
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
                sh 'docker rm $(docker ps -aq)'
                echo 'removed all containers'
                sh 'docker ps -a'
            }
        }
        
        stage ('Docker build') {
            steps {
                sh 'docker build -t ******.***.ecr.us-east-1.amazonaws.com/myrepo:tomcat-${BUILD_NUMBER} .'
            }
        }
        
        stage("Docker Push") {
            steps {
                withAWS(credentials:'Jenkins_AWS') {  
                    sh 'eval $(aws ecr get-login --region us-east-1 --no-include-email)'
                    sh 'docker push ******.***.ecr.us-east-1.amazonaws.com/myrepo:tomcat-${BUILD_NUMBER}'
            	}
            }
    	}       
        
        stage ('Docker run') {
            steps {
                sh 'docker run --name tomcat -d -it -p 8090:8080 ******.***.ecr.us-east-1.amazonaws.com/myrepo:tomcat-${BUILD_NUMBER}'
            }
        }
    }
    
    post {
        success {
            echo 'successfully pushed to ecr'
        }
    }        
}
