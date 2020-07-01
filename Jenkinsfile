pipeline {
    environment {
      registry = "username/reponame"
      registryCredential = 'credentials'
  }
    agent any
    tools {
        maven 'maven-3.5.4'
        jdk 'Java'
    }
    stages {
        stage('git clone') {
            steps {
                git credentialsId: 'git-pwd', url: 'https://github.com/Angelaroy/demo-java.git'
                echo "Successful"
            }
        }
        stage ('Maven Build') {
            steps {
                bat label: '', script: 'mvn -Dmaven.test.failure.ignore=true install'
                echo "War file created successfully"
            }
        }

        stage('Build dockerfile') {
            steps {
                echo "Starting to build docker image"
                git 'https://github.com/Angelaroy/demo-java.git'
                powershell label: '', script: 'docker build -t demo .'
                echo "docker image created successfully"
            }
        }
        stage('Build container') {
            steps {
                powershell label: '', script: 'docker run --name sample -p 9091:8080 -d demo'
                echo "container created successfully"
            }
        }
        stage('Publish to Dockerhub') {
            steps {
                withDockerRegistry([ credentialsId: "credentials", url: "" ]) {
                  powershell label: '', script: 'docker commit -m "jenkins-commit" sample angela97/jenkins-test:trial'
                  powershell label: '', script: 'docker push angela97/jenkins-test:trial'
                  echo "Pushed to DockerHub Successfully"
                  }
            }
       }
        stage('kubectl verify') {
            steps {
                powershell label: '', script: 'kubectl version'
                echo "Verified"
            }
        }
        stage ('Helm deploy') {
            steps {
                git 'https://github.com/Angelaroy/helm-tomcat.git'
                powershell label: '', script: 'helm install --name tomcat-app tomcat-app'
           }
       }
    }
}
