# Base Image - ubuntu latest
FROM ubuntu

# Upgrade and Update the Linux Packages
RUN apt-get -y upgrade && apt-get -y update

# Setup Development Environment

## Install Java
RUN apt install -y openjdk-11-jre-headless
RUN java --version

## Install Apache Maven
RUN apt install -y maven
RUN mvn --version

# Install Tree to see the maven directory structure
RUN apt install -y tree

# Create a Maven Skeleton Project using the Command line
RUN mvn archetype:generate -DgroupId=nish -DartifactId=nish -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false

# Change Working Directory to the [Artifact_Id/]
WORKDIR /nish/

# Add all java source files from GitHub repository to current working directory in /[artifact_id]/src/main/java/[group_id]/
ADD java/*.java /nish/src/main/java/nish/
RUN tree

# RUN Maven Goals
RUN mvn clean
RUN mvn compile
RUN mvn test
RUN mvn install
RUN mvn site
