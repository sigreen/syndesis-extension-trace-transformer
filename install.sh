#!/bin/bash

echo Installing Trace libraries...

mvn install:install-file -DgroupId=com.tracegroup.transformer -DartifactId=transformer-runtime-skinny -Dversion=3.6.9-SNAPSHOT -Dfile=lib/transformer-runtime-skinny-3.6.9-SNAPSHOT.jar -Dpackaging=jar
mvn install:install-file -DgroupId=com.tracegroup.transformer.libraries -DartifactId=currencylib -Dversion=1.0.11 -Dfile=lib/currencylib-1.0.11.jar -Dpackaging=jar
mvn install:install-file -DgroupId=com.redhat -DartifactId=holdings-transform -Dversion=1.0.0 -Dfile=lib/holdings-transform-1.0.0.jar -Dpackaging=jar

echo Finished installing Trace libraries.