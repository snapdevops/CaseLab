node {
    def mvnHome
    try {
        stage('Checkout') { //(1)
            git 'https://github.com/piomin/sample-code-for-ci.git'
            mvnHome = tool 'maven3'
        }
        stage('Build') { //(2)
            dir('service-1') {
                sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package"
            }
        }
        stage('Tests') { //(3)
            junit '**/target/surefire-reports/TEST-*.xml'
            archive 'target/*.jar'
            step([$class: 'JacocoPublisher', execPattern: '**/target/jacoco.exec'])
        }
        stage('Report') { //(4)
            if (currentBuild.currentResult == 'UNSTABLE') {
                currentBuild.result = "UNSTABLE"
            } else {
                currentBuild.result = "SUCCESS"
            }
            step([$class: 'InfluxDbPublisher', customData: null, customDataMap: null, customPrefix: null, target: 'grafana'])
        }
    } catch (Exception e) {
        currentBuild.result = "FAILURE"
        step([$class: 'InfluxDbPublisher', customData: null, customDataMap: null, customPrefix: null, target: 'grafana'])
    }
}
