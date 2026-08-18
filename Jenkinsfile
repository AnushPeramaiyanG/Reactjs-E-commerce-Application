pipeline {

    agent any

    environment {
        IMAGE_NAME = "devops-build"
        DOCKERHUB_USERNAME = "anushperamaiyang"

        DEV_REPOSITORY = "${DOCKERHUB_USERNAME}/devops-build-dev"
        PROD_REPOSITORY = "${DOCKERHUB_USERNAME}/devops-build-prod"

        DOCKER_CREDENTIALS = "dockerhub-credentials"
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out source code..."
                checkout scm
            }
        }

        stage('Verify Files') {
            steps {
                sh '''
                    echo "Current branch:"
                    git branch --show-current

                    echo "Project files:"
                    ls -la

                    echo "Docker version:"
                    docker --version
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    chmod +x build.sh
                    ./build.sh
                '''
            }
        }

        stage('Push DEV Image') {
            when {
                branch 'dev'
            }

            steps {
                echo "Building DEV image..."

                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIALS}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            -u "$DOCKER_USERNAME" \
                            --password-stdin

                        docker tag ${IMAGE_NAME}:latest \
                            ${DEV_REPOSITORY}:latest

                        docker push ${DEV_REPOSITORY}:latest

                        docker logout
                    '''
                }
            }
        }

        stage('Push PROD Image') {
            when {
                branch 'master'
            }

            steps {
                echo "Building PROD image..."

                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIALS}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            -u "$DOCKER_USERNAME" \
                            --password-stdin

                        docker tag ${IMAGE_NAME}:latest \
                            ${PROD_REPOSITORY}:latest

                        docker push ${PROD_REPOSITORY}:latest

                        docker logout
                    '''
                }
            }
        }
    }

    post {

        success {
            echo "========================================"
            echo "Pipeline completed successfully"
            echo "========================================"
        }

        failure {
            echo "========================================"
            echo "Pipeline failed"
            echo "========================================"
        }

        always {
            sh '''
                echo "Docker images:"
                docker images | head -20
            '''
        }
    }
}
