#!/bin/bash

set -eu pipefail

sonar-scanner \
    -e \
    -Dsonar.verbose=true \
    -Dsonar.host.url=${SONARQUBE_URL} \
    -Dsonar.login=${SONARQUBE_TOKEN} \
    -Dsonar.links.ci=${JOB_URL} \
    -Dsonar.cfamily.build-wrapper-output=cfamily-compilation-database \
    -Dsonar.projectKey="c-family:openjdk" \
    -Dsonar.projectName="OpenJDK" \
    -Dsonar.projectVersion=tip \
    -Dsonar.sourceEncoding=UTF-8 \
    -Dsonar.sources=hotspot \
    -Dsonar.inclusions=**/*.c,**/*.cc,**/*.cpp,**/*.cxx,**/*.h,**/*.hpp \
    -Dsonar.cpd.exclusions=** \
    -Dsonar.scm.disabled=true
