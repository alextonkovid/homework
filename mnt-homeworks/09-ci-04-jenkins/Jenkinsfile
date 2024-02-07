pipeline {
    agent any

    environment {
        GIT_REPO = 'git@github.com:alextonkovid/netology-molecule.git'
        CREDENTIALS_ID = '747dcb7b-637f-455d-ac48-61ec393ea56e'
        GIT_BRANCH = 'master'
    }

    stages {
        stage('Clone Repository') {
            steps {
                script {
                    git credentialsId: CREDENTIALS_ID, url: GIT_REPO, branch: GIT_BRANCH
                }
            }
        }

        stage('Setup Environment') {
            steps {
                script {
                    dir('tasks') {
                        sh 'ansible-galaxy role init nginx --force'
                        sh 'molecule init scenario'
                    }
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    dir('tasks') {
                        sh 'molecule test'
                    }
                }
            }
        }
    }
}
