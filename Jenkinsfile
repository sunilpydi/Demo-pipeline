pipeline {
  agent any
  stages {
    stage('gitclone') {
      steps {
	    cleanWs()
    	checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/sunilpydi/Demo-pipeline.git']]])
      // One or more steps need to be included within the steps block.
    }} 
	stage('Maven clean') {
      steps {
	    sh 'mvn clean install'
    	
    }}
	stage('Docker build') {
      steps {
	    sh 'docker build -t demo -f  Dockerfile_1 .' 
        sh 'docker tag demo sunilpydi/hyd:latest'
		}
	}
	stage('publish image to Docker hub') {
      
	  
	   steps {
	   withDockerRegistry([credentialsId: 'dockerhub1', url: ""]) {
      
	    sh 'docker push sunilpydi/hyd:latest'
		}
	 }
	  
    
	     }
	
       }
     }
