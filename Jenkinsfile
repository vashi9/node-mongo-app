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
        git 'https://github.com/vashi9/node-js-app.git'
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
    stage('Scale service'){
      steps{
        script{
          scaleApp(CONTAINER_NAME, CONTAINER_TAG, DOCKER_HUB_USER, HTTP_PORT_2)
        }
      }
    }
    
  }
}
def runApp(containerName, tag, dockerHubUser, httpPort)
     sh "docker pull $dockerHubUser/$containerName"
     sh "docker service rm ci-cd"
     sh "docker node update --availability drain ip-172-31-42-182"
     sh "docker service create --name node-mongo --replicas 4 --publish ${httpPort}:${httpPort} vashi9/node-mongo"
     sh "docker service create --name mongo --replicas 2 --publish 5006:27017 mongo"
     
  
  
  
}
      def scaleApp(containerName, tag, dockerHubUser, httpPort){
        sh label: ' ',script: 'ssh ubuntu@54.188.134.172 docker pull vashi9/ci-cd'
        sh label: ' ',script: 'ssh ubuntu@54.188.134.172 docker stop ci-cd_container'
        sh label: ' ',script: 'ssh ubuntu@54.188.134.172 docker run -d --rm --name ci-cd_container -p 5004:5004 vashi9/ci-cd'
        sh label: ' ',script: 'ssh -i "/id_rsa2" ubuntu@34.208.7.11 sudo docker pull vashi9/ci-cd '
         sh label: ' ',script: 'ssh -i "/id_rsa2" ubuntu@34.208.7.11 sudo docker stop ci-cd_container'
        sh label: ' ',script: 'ssh -i "/id_rsa2" ubuntu@34.208.7.11 sudo docker run -d --rm --name ci-cd_container -p 5004:5004 vashi9/ci-cd'
       
      }
