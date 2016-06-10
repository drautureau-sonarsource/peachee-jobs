node('linux') {

    stage 'Checkout'
    git url: "https://bitbucket.org/atlassian/atlasboard.git", branch: "master"

    stage 'SQ Analysis'
    withScanner {
        // The bad way
        // sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:LATEST:sonar -B -e -Dsonar.host.url=https://peach.sonarsource.com -Dsonar.login=XXX'
        // The workaroud until https://jira.sonarsource.com/browse/SONARJNKNS-213 is fixed
        // This need credentials-binding-plugin (https://cloudbees.zendesk.com/hc/en-us/articles/204897020-Fetch-a-userid-and-password-from-a-Credential-object-in-a-Pipeline-job-)
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'af31d5fa-f22c-42d8-b6e4-177686ec44d5', usernameVariable: 'PEACH_URL', passwordVariable: 'PEACH_TOKEN']]) {
            sh "sonar-scanner -Dsonar.projectKey=dav.atlasboard -Dsonar.projectVersion=master -Dsonar.projectName=\"Dav Atlasboard\" -Dsonar.sources=. -Dsonar.language=js -Dsonar.sourceEncoding=UTF-8 -Dsonar.host.url=${env.PEACH_URL} -Dsonar.login=${env.PEACH_TOKEN}"
        }
    }
}

def withScanner(def body) {
    // ** NOTE: This 'SonarQube Scanner 2.6.1' Scanner tool must be configured in the global configuration.
    def scannerHome = tool name: "SonarQube Scanner 2.6.1", type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    withJava {
        withEnv(["PATH+SCANNER=${scannerHome}/bin"]) {
            body.call()
        }
    }
}

def withJava(def body) {
    // ** NOTE: This 'Java 8' JDK tool must be configured in the global configuration.
    def javaHome = tool name: 'Java 8', type: 'hudson.model.JDK'
    withEnv(["JAVA_HOME=${javaHome}"]) {
        body.call()
    }
}