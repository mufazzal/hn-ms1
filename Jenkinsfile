pipeline {
    agent { label 'slave-ec2-fleet' }
    tools {nodejs "nodejs"}
    environment {
        dockerHubCredId = "dockerHubPassword"
        dockerHubRepo = "mufazzal/hn-ms1"
    }
    stages {
        stage('Versioning') {
            steps {
                sh 'printenv'
            }
        }        
        stage('Installing') {
            steps {
                echo 'Installation in progress..'
                sh 'npm install'
                echo 'Installation Finished'
            }
        }         
        // mufazzal/hn-ms1:origin/master-latest

        stage('Dockerizing') {
            steps {
                script {
                    echo "Building docker image"
                    
                    sh """
                        docker build \
                            -f Docker/Dockerfile \
                            -t $dockerHubRepo:latest \
                            -t $dockerHubRepo:$BUILD_ID \
                            -t $dockerHubRepo:$GIT_COMMIT \
                            .
                    """
                    echo "Building docker image finish"
                    echo "Images build locally :-"
                    sh """
                        docker images
                    """
                }
            }
        } 

        stage('DockerHub Push') {
            steps {

                withCredentials([usernamePassword(credentialsId: "$dockerHubCredId", usernameVariable: 'USERNAME_DOCKER_HUB', passwordVariable: 'PASSWORD_DOCKER_HUB')]) {
                    sh """

                        docker login --username $USERNAME_DOCKER_HUB --password $PASSWORD_DOCKER_HUB

                        docker push $dockerHubRepo:latest
                        docker push $dockerHubRepo:$BUILD_ID
                        docker push $dockerHubRepo:$GIT_COMMIT
                    
                    """
                
                }
            }
        }        

        stage('Clean up') {
            steps {
                sh """
                    docker rmi $dockerHubRepo:latest
                    docker rmi $dockerHubRepo:$BUILD_ID
                    docker rmi $dockerHubRepo:$GIT_COMMIT
                """
            }
        }        


    }
}
