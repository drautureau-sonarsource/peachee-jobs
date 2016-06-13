# Analyse artifactory

* Checkout http://subversion.jfrog.org/artifactory/public/trunk
* Use a custom Docker image for the build (inject specific Maven settings)
* Scan with Maven scanner

Based on
* [maven Jenkinsfile template](https://github.com/drautureau-sonarsource/jenkinsfile-templates/blob/master/maven)
* [custom docker sample](https://github.com/drautureau-sonarsource/jenkinsfile-templates/tree/master/samples/custom-docker)
* [subversion sample](https://github.com/drautureau-sonarsource/jenkinsfile-templates/tree/master/samples/subversion)
