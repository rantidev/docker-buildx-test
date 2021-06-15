node {
    // reference to maven
    // ** NOTE: This 'maven-3.8.1' Maven tool must be configured in the Jenkins Global Configuration.   
    def mvnHome = tool 'maven-3.8.1'

    // holds reference to docker image
    def dockerImage
    // ip address of the docker private repository(nexus)
    
    def dockerRepoUrl = "192.168.1.9:5000"
    def dockerImageName = "docker-buildx-test"
    def dockerImageTag = "${dockerRepoUrl}/${dockerImageName}:${env.BUILD_NUMBER}"
    
    stage('Clone Repo') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/rantidev/docker-buildx-test.git'
      // Get the Maven tool.
      // ** NOTE: This 'maven-3.6.1' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'maven-3.8.1'
    }    
  
    stage('Build Project') {
      // build project via maven
      sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
    }
	
	stage('Publish Tests Results'){
      parallel(
        publishJunitTestsResultsToJenkins: {
          echo "Publish junit Tests Results"
		  junit '**/target/surefire-reports/TEST-*.xml'
		  archive 'target/*.jar'
        },
        publishJunitTestsResultsToSonar: {
          echo "This is branch b"
      })
    }
		
    stage('Build Docker Image') {
      // build docker image
      sh "whoami"
      sh "ls -all /var/run/docker.sock"
      sh "cp ./target/docker-buildx-test*.jar ./data" 
      sh "pwd"
      script {
            sh """
               docker buildx build --platform linux/arm/v7 -t "${dockerRepoUrl}/${dockerImageName}:latest" .
	       """
      }
     // dockerImage = sh docker.build("docker-buildx-test")
    }
   
    stage('Deploy Docker Image'){
      //sh "docker push ${dockerRepoUrl}/${dockerImageName}:latest"
      sh "docker run -name -p 8888:8080 ${dockerRepoUrl}/${dockerImageName}:latest"
    }
	
    stage('Run Functinal And Performance Test'){

    }
	
    stage('Remove Test Container'){
      sh "docker stop ${dockerImageName}"
      sh "docker rm ${dockerImageName}"
    }
	
    stage('Push Docker Image'){
      sh "docker push ${dockerRepoUrl}/${dockerImageName}:latest"
    }
}
