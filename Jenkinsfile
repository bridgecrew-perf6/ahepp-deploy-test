pipeline {
    agent { dockerfile true }
    stages {
        stage('Build') {
            steps {
                sh 'mkdir -p /ws/output/'
                sh 'cat /proc/cpuinfo > /ws/output/cpuinfo'
            }
        }
        stage('Package') {
            steps {
                sh 'tar cf "/ws/deploy-test-${GIT_BRANCH}b${BUILD_NUMBER}-${GIT_COMMIT}.tar" /ws/output/'
            }
        }
        stage('Deploy') {
            steps {
                sshagent(credentials : ['jenkins']) {
                    sh '[ -d ~/.ssh ] || mkdir ~/.ssh && chmod 0700 ~/.ssh'
                    sh 'ssh-keyscan -t rsa,dsa ahepp.dev >> ~/.ssh/known_hosts'
                    sh 'scp -v /ws/deploy-test* root@ahepp.dev:/usr/local/www/iso/'
                }
            }
        }
    }
}
