pipeline {

    agent any

    environment {

        IMAGE_NAME = "devops-build"

        DOCKERHUB_USERNAME = "anushperamaiyang"

        DEV_REPOSITORY =
            "${DOCKERHUB_USERNAME}/devops-build-dev"

        PROD_REPOSITORY =
            "${DOCKERHUB_USERNAME}/devops-build-prod"

        DOCKER_CREDENTIALS =
            "dockerhub-credentials"
    }

    stages {

        stage('Checkout') {

            steps {

                echo "========================================"
                echo "Checking out source code"
                echo "========================================"

                checkout scm
            }
        }


        stage('Verify Files') {

            steps {

                sh '''
                    echo "========================================"
                    echo "Build Information"
                    echo "========================================"

                    echo "Branch:"
                    echo "${BRANCH_NAME}"

                    echo ""
                    echo "Commit:"
                    git rev-parse HEAD

                    echo ""
                    echo "Project files:"
                    ls -la

                    echo ""
                    echo "Docker version:"
                    docker --version
                '''
            }
        }


        stage('Build Docker Image') {

            steps {

                echo "========================================"
                echo "Building Docker Image"
                echo "========================================"

                sh '''
                    chmod +x build.sh

                    ./build.sh

                    echo ""
                    echo "Docker image:"
                    docker images | grep devops-build
                '''
            }
        }


        stage('Push DEV Image') {

            when {

                branch 'dev'
            }

            steps {

                echo "========================================"
                echo "DEV BRANCH"
                echo "Pushing image to DEV Docker Hub repository"
                echo "========================================"

                withCredentials([

                    usernamePassword(

                        credentialsId:
                            "${DOCKER_CREDENTIALS}",

                        usernameVariable:
                            'DOCKER_USERNAME',

                        passwordVariable:
                            'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        set -e

                        echo "Logging in to Docker Hub..."

                        echo "$DOCKER_PASSWORD" | \
                        docker login \
                        --username "$DOCKER_USERNAME" \
                        --password-stdin


                        echo "Tagging DEV image..."

                        docker tag \
                        ${IMAGE_NAME}:latest \
                        ${DEV_REPOSITORY}:latest


                        echo "Pushing DEV image..."

                        docker push \
                        ${DEV_REPOSITORY}:latest


                        echo "DEV image pushed successfully."

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

                echo "========================================"
                echo "MASTER BRANCH"
                echo "Pushing image to PROD Docker Hub repository"
                echo "========================================"

                withCredentials([

                    usernamePassword(

                        credentialsId:
                            "${DOCKER_CREDENTIALS}",

                        usernameVariable:
                            'DOCKER_USERNAME',

                        passwordVariable:
                            'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        set -e

                        echo "Logging in to Docker Hub..."

                        echo "$DOCKER_PASSWORD" | \
                        docker login \
                        --username "$DOCKER_USERNAME" \
                        --password-stdin


                        echo "Tagging PROD image..."

                        docker tag \
                        ${IMAGE_NAME}:latest \
                        ${PROD_REPOSITORY}:latest


                        echo "Pushing PROD image..."

                        docker push \
                        ${PROD_REPOSITORY}:latest


                        echo "PROD image pushed successfully."

                        docker logout
                    '''
                }
            }
        }
    }


    post {

        success {

            echo """
            ========================================
            PIPELINE SUCCESS
            ========================================

            Branch:
            ${BRANCH_NAME}

            Docker build completed successfully.

            ========================================
            """
        }

        failure {

            echo """
            ========================================
            PIPELINE FAILED
            ========================================

            Branch:
            ${BRANCH_NAME}

            Please check Jenkins console output.

            ========================================
            """
        }

        always {

            sh '''
                echo "========================================"
                echo "Docker Images"
                echo "========================================"

                docker images | head -20
            '''
        }
    }
}
