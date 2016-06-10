node('docker') {

    stage 'Checkout'
    git url: "https://github.com/SonarSource/sonar-maven", branch: "master"

    stage 'Build'
    def build = docker.image("maven:3.2.5-jdk-8")
    build.pull()
    build.inside {
        // Tip (redirect the maven cache to the slave workspace)
        writeFile file: 'settings.xml', text: "<settings><localRepository>${pwd()}/.m2repo</localRepository></settings>"
        sh "mvn org.jacoco:jacoco-maven-plugin:prepare-agent verify -B -e"
    }
    
    def scan = docker.image("maven:3.2.5-jdk-8")
    scan.pull()
    scan.inside {
        // Tip (redirect the maven cache to the slave workspace)
        writeFile file: 'settings.xml', text: "<settings><localRepository>${pwd()}/.m2repo</localRepository></settings>"
        // The bad way
        // sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:LATEST:sonar -B -e -Dsonar.host.url=https://peach.sonarsource.com -Dsonar.login=XXX'
        // The workaroud until https://jira.sonarsource.com/browse/SONARJNKNS-213 is fixed
        // This need credentials-binding-plugin (https://cloudbees.zendesk.com/hc/en-us/articles/204897020-Fetch-a-userid-and-password-from-a-Credential-object-in-a-Pipeline-job-)
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'af31d5fa-f22c-42d8-b6e4-177686ec44d5', usernameVariable: 'PEACH_URL', passwordVariable: 'PEACH_TOKEN']]) {
            sh "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:LATEST:sonar -B -e -Dsonar.projectKey=dav-sonar-maven -Dsonar.projectName=\"DAV-Sonar-Maven\" -Dsonar.host.url=${env.PEACH_URL} -Dsonar.login=${env.PEACH_TOKEN}"
        }
    }
}
