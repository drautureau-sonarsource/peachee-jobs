def repoURL = "http://hg.openjdk.java.net/jdk8u/jdk8u-dev/"
def dockerImageName = "c-family/openjdk:latest"

input message: 'Check workspaces', ok: 'OK'
// 1st time
// on master:
// [root@peach-jenkins workspace@script]# pwd 
// /sonarsource/var/opt/sonarsource/ssjenkins/jobs/samples-jobs/branches/InvestigatingDeleteWorkspaceIssue/workspace@script
// [root@peach-jenkins workspace@script]# ls
// cfamily-analyze.sh  cfamily-build.sh  Jenkinsfile  README.md
// on slave:
// 0

node('linux') {
    
    stage 'install'
    // without ws - "unable to prepare context: unable to evaluate symlinks in Dockerfile path: lstat /home/ssjenka/peach-jenkins/workspace/CFamily/wip-docker/Dockerfile: no such file or directory"
    ws {
      checkout scm
      stash includes: 'cfamily-build.sh, cfamily-analyze.sh', name: 'materials'
    }

    input message: 'Check workspaces', ok: 'OK'
    // 1st time
    // on master:
    // [root@peach-jenkins workspace@script]# pwd 
    // /sonarsource/var/opt/sonarsource/ssjenkins/jobs/samples-jobs/branches/InvestigatingDeleteWorkspaceIssue/workspace@script
    // [root@peach-jenkins workspace@script]# ls
    // cfamily-analyze.sh  cfamily-build.sh  Jenkinsfile  README.md
    // on slave:
    // [ssjenka@peach-slave-centos7-1 samples-jobs]$ pwd
    // /home/ssjenka/peach-jenkins/workspace/samples-jobs
    // [ssjenka@peach-slave-centos7-1 samples-jobs]$ ls InvestigatingDeleteWorkspaceIssue\@2/
    // cfamily-analyze.sh  cfamily-build.sh  Jenkinsfile  README.md

    stage 'checkout'
    checkout scm: [$class: 'MercurialSCM', source: "${repoURL}"]
    unstash 'materials'
    // 1st time
    // on master:
    // [root@peach-jenkins workspace@script]# pwd 
    // /sonarsource/var/opt/sonarsource/ssjenkins/jobs/samples-jobs/branches/InvestigatingDeleteWorkspaceIssue/workspace@script
    // [root@peach-jenkins workspace@script]# ls
    // cfamily-analyze.sh  cfamily-build.sh  Jenkinsfile  README.md
    // on slave:
    // [ssjenka@peach-slave-centos7-1 samples-jobs]$ pwd
    // /home/ssjenka/peach-jenkins/workspace/samples-jobs
    // [ssjenka@peach-slave-centos7-1 samples-jobs]$ ls InvestigatingDeleteWorkspaceIssue\@2/
    // cfamily-analyze.sh  cfamily-build.sh  Jenkinsfile  README.md
    // [ssjenka@peach-slave-centos7-1 samples-jobs]$ ls InvestigatingDeleteWorkspaceIssue
    // ASSEMBLY_EXCEPTION  cfamily-analyze.sh  cfamily-build.sh  common  configure  get_source.sh  LICENSE  make  Makefile  README  README-builds.html  test  THIRD_PARTY_README
}
