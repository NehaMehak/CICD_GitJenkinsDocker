node {
	
    def application = "cicd_gitjenkinsdocker"
    
    //Its mandatory to change the Docker Hub Account ID after this Repo is forked by an other person
    def dockerhubaccountid = "nehamehak"
	

    // holds reference to docker image
    def dockerImage
 
    def dockerImageTag = "${dockerhubaccountid}/${application}:${env.BUILD_NUMBER}"
    
    stage('Clone Repo') { 
      // Get some code from a GitHub repository
      git url:'https://github.com/NehaMehak/CICD_GitJenkinsDocker.git',branch:'main' //update your forked repo
    }    
  
    stage('Build Docker Image with new code') {
      // build docker image
      dockerImage = docker.build("${dockerhubaccountid}/${application}:${env.BUILD_NUMBER}")
    }
	//push image to remote repository , in your jenkins you have to create the global credentials similar to the 'dockerHub' (credential ID)
    stage('Push Image to Remote Repo'){
	 echo "Docker Image Tag Name ---> ${dockerImageTag}"
	     docker.withRegistry('', 'dockerhub') {
             dockerImage.push("${env.BUILD_NUMBER}")
             dockerImage.push("latest")
            }
	}
   
   stage('Remove running container with old code'){
	   //remove the container which is already running, when running 1st time named container will not be available so we are usign 'True'
	   //added -a option to remove stopped container also
	  sh "docker rm -f \$(docker ps -a -f name=devopsexample -q) || true"   
	       
    }
	
    stage('Deploy Docker Image with new changes'){
	        
	    //start container with the remote image
	  sh "docker run --name devopsexample -d -p 5000:5000 ${dockerhubaccountid}/${application}:${env.BUILD_NUMBER}"  
	  
    }
	
    
stage('Remove old images') {
		// remove docker old images
		sh("docker rmi ${dockerhubaccountid}/${application}:latest -f")
   }
}
