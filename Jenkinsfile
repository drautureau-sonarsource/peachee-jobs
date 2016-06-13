node('docker') {

    stage 'Checkout'
    svn 'http://subversion.jfrog.org/artifactory/public/trunk'

    def myEnv

    // Use a dedicated workspace to build the Docker image
    // This way, we don't interfer with the workspace dedicated to the project to analyse.
    ws {
        stage 'Configure Maven settings'
        // - Checkout on the 'docker' slave what has been checked out on master (we need the Dockerfile)
        checkout scm
        // Build the docker image
        myEnv = docker.build "${env.JOB_NAME}:snapshot"

        stage 'Configure NPM'
        stash includes: '.npmrc', name: 'NPM'
    }
    unstash 'NPM'

    stage 'Build'
    myEnv.inside {
        sh "mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install -Dmaven.test.failure.ignore=true -V -Dcheckstyle.skip=true -Dpmd.skip=true  -Dgpg.skip=true -B -e "
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
            sh "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:LATEST:sonar -B -e -Dsonar.projectKey=dav-org.artifactory:artifactory-parent -Dsonar.projectName=\"DAV-Artifactory Parent\" -Dsonar.host.url=${env.PEACH_URL} -Dsonar.login=${env.PEACH_TOKEN}"
        }
    }
}
