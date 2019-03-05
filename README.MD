# Syndesis Extension for Trace Transformer

This project details a Syndesis Extension which can transform any file using Trace Transformer.

The extension exposes three configurable fields:
- **PROJECT_KEY** The name of the transformer project e.g. com.redhat.flatfile-to-xml
- **OPERATION_NAME** The name of the exposed service operation e.g. MapHoldingsToXML

## Prerequisites

The required runtime Trace library files can be sourced from your Trace Transformer tooling installation:

1. currencylib-1.0.11
2. transformer-runtime-skinny-3.6.9-SNAPSHOT

Request both Trace library files and copy them to the `/lib` directory in your `syndesis-extension-trace-transformer` project.

Via the command-line, install both Trace JAR files to your local Maven repository using the following commands:

```
mvn install:install-file -DgroupId=com.tracegroup.transformer -DartifactId=transformer-runtime-skinny -Dversion=3.6.9-SNAPSHOT -Dfile=lib/transformer-runtime-skinny-3.6.9-SNAPSHOT.jar -Dpackaging=jar
mvn install:install-file -DgroupId=com.tracegroup.transformer.libraries -DartifactId=currencylib -Dversion=1.0.11 -Dfile=lib/currencylib-1.0.11.jar -Dpackaging=jar
```

## Create the Transformation Exposed Service

### Step 1: Generate Exposed Service in Trace

1. Open Trace Transformer, select Project > Project Properties from the menu, and verify the Project Key:

    ![design-login](img/1-1-project-properties.png "Project Properties")
    
1. In the same window, click on the *Libraries* tab and ensure that `Use Camel Library` is selected.

    ![design-login](img/1-2-camel-library.png "Use Camel Library")
    
1. On the Services tab, right-click the pallet and select *New Exposed Service*.

    ![design-login](img/1-3-new-exposed-service.png "New Exposed Service")
    
1. In the *New Exposed Service* window, select the *ProjectJarBuilder* and set *Java Language Level* to *8*.

    ![design-login](img/1-4-new-exposed-service.png "New Exposed Service")
    
1. Right-click on the Exposed Service and select *New Exposed Service Operation*.  In the pop-up window, enter an *Operation Name* and select *OneToOneMapping* as the Service Performer.

    ![design-login](img/1-5-new-exposed-operation.png "New Exposed Operation")

1. Select the *Definition Group* and *Mapping Definition*.  

    ![design-login](img/1-6-exposed-operation.png "New Exposed Operation")
    
1. Right-click on the exposed operation, and select *Build Exposed Operation*

    ![design-login](img/1-7-build-exposed-service.png "Build Exposed Operation")
    
    
### Step 2: Install the Exposed Service to your local Maven repostiory


1. Once the exposed service is built, click on the file link and copy the generated file to your `/lib` directory in the `syndesis-extension-trace-transformer` project.

    ![design-login](img/1-8-copy-exposed-service.png "Copy Exposed Service")

1. Via the command-line, install your Transformation Map to your local Maven repository:

```
mvn install:install-file -DgroupId=com.redhat -DartifactId=holdings-transform -Dversion=1.0.0 -Dfile=lib/holdings-transform-1.0.0.jar -Dpackaging=jar
```

### Step 3: Update your Transformer mapping service

Whenever you make a change to your Trace Transformer map, you need to re-generate the exposed service in Transformer, redeploy it to your local maven repository and re-import it into Syndesis.  The best way to do this is to update the following install script and run it:

```
./install.sh
```

Once you have updated the Maven repository, you can continue to generate the Syndesis extension


### Step 4: Generate the Syndesis extension

To create the step extension, compile the project using:

```
mvn clean package
```

Import the `target/trace-transformer-extension-1.0.0.jar` JAR file into Syndesis as a Step Extension.  Build a Syndesis Integration to test out your map.  An easy integration is AMQ -> Trace Transformer -> AMQ.  Here is sample test data:

```
ABGH1456900ABC001GB01849356841500.0000000    GBP4.5600000  2003123120030812ABC123456720030712ABB134287920030710ABA547968020030708ABA658748920030707AAB1346849
```

![iPaaS screenshot](images/screenshot.png)
