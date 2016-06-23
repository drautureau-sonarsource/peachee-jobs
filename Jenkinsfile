def repoURL = "http://hg.openjdk.java.net/jdk8u/jdk8u-dev/"
def dockerImageName = "c-family/openjdk:latest"

input message: 'Check workspaces', ok: 'OK'

node('linux') {
    
    stage 'install'
    // without ws - "unable to prepare context: unable to evaluate symlinks in Dockerfile path: lstat /home/ssjenka/peach-jenkins/workspace/CFamily/wip-docker/Dockerfile: no such file or directory"
    ws {
      checkout scm
      stash includes: 'cfamily-build.sh, cfamily-analyze.sh', name: 'materials'
    }
    unstash 'materials'

    input message: 'Check workspaces', ok: 'OK'

    stage 'checkout'
    checkout scm: [$class: 'MercurialSCM', source: "${repoURL}"]
}
