pipeline {
    agent any
    stages {
        stage(" Maven Build") {
            steps {
                // Create a dummy file in the repo
                //sh('echo \$BUILD_NUMBER > example-\$BUILD_NUMBER.md')
		  sh 'git 'https://github.com/snapdevops/CaseLab.git'
                // Run Maven on a Unix agent.
                  sh "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
	stage(" Maven Test") {
            steps {
                // Create a dummy file in the repo
                //sh('echo \$BUILD_NUMBER > example-\$BUILD_NUMBER.md')
		//  sh 'git 'https://github.com/snapdevops/CaseStudy5.git'
                // Run Maven on a Unix agent.
                  sh "mvn test"
            }
        }    
	
        stage("Commit") {
            steps {
                sh('''
                    git checkout -B master
                    git config user.name 'snapdevops'
                    git config user.email 'my-ci-user@users.noreply.github.example.com'
                    git add . && git commit -am "[Jenkins CI] build file"
                ''')
            }
        }
        stage("Push") {
            environment { 
                GIT_AUTH = credentials('GITVAMSI') 
            }
            steps {
                sh('''
                    git config --local credential.helper "!f() { echo username=\\$GIT_AUTH_USR; echo password=\\$GIT_AUTH_PSW; }; f"
                    git push origin HEAD:master
                ''')
            }
        }
    }
}
