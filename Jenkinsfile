def CONTAINER_NAME="node-mongo"
def DOCKER_HUB_USER="vashi9"
def CONTAINER_TAG="latest"
def HTTP_PORT="5005"
def HTTP_PORT_2="5004"
pipeline {
  environment {
    registry = "vashi9/node-mongo"
    registryCredential = 'dockerhub'
    dockerImage = ''
    
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
         checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'new-key-2', url: 'git@github.com:vashi9/node-mongo-app.git']]])
        /*git 'git@github.com:vashi9/node-mongo-app.git'*/
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
   stage('Run service'){
        steps{
            script{
                runApp(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT)
                
            }
        }
   }
    
  }
}
def runApp(containerName, tag, dockerHubUser, httpPort){
  sh "docker-compose up"
     
  
     
     
}
    
