# FK Maven

A Maven parent pom. Some of the features it provides:

- **Code Quality & Static Analysis**
  - **SpotBugs** - Static analysis for bug detection
  - **PMD** - Source code analyzer for programming flaws
  - **Checkstyle** - Code style checker
  - **Violations Plugin** - Aggregated violation reporting
  - **FK Code Standard** - Forsakringskassan's code formatting standards

- **Development Tools**
  - **Eclipse Integration** - IDE configuration with source/javadoc downloads
  - **UTF-8 Encoding** - Consistent character encoding across all phases
  - **Java 21** - Modern Java version support
  - **Parameter Names** - Preserved for better debugging

- **Build & Release Management**
  - **Maven Surefire** - Unit test execution
  - **Javadoc Generation** - Automatic API documentation
  - **Source JAR Creation** - Source code packaging
  - **Maven Release Plugin** - Automated versioning and releases
  - **SortPOM** - Consistent POM formatting

- **Pre-configured Dependencies**
  - **AssertJ** - Fluent assertions for testing
  - **SpotBugs Annotations** - Static analysis annotations

It is published to: https://github.com/Forsakringskassan/repository

## Example usage

Quarkus application: https://github.com/Forsakringskassan/template-quarkus

## Setup

This is published on Github Packages and you need Github credentials to download it.

- Go to <https://github.com/settings/tokens>
- You only need `read:packages`
- Add the environment variables:
  - `GITHUB_TOKEN=the-token`
  - `GITHUB_ACTOR=your-github-user`

A user may create a `settings.xml` like:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 
                              http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <servers>
    <server>
      <id>github--Forsakringskassan--repository</id>
      <username>${env.GITHUB_ACTOR}</username>
      <password>${env.GITHUB_TOKEN}</password>
    </server>
  </servers>
</settings>
```

And in `pom.xml`:

```xml
  <repositories>
    <repository>
      <id>github--Forsakringskassan--repository</id>
      <url>https://maven.pkg.github.com/Forsakringskassan/repository</url>
    </repository>
  </repositories>

  <pluginRepositories>
    <pluginRepository>
      <id>github--Forsakringskassan--repository</id>
      <url>https://maven.pkg.github.com/Forsakringskassan/repository</url>
    </pluginRepository>
  </pluginRepositories>
```

And also the actual dependency:

```xml
<parent>
  <groupId>se.fk.maven</groupId>
  <artifactId>fk-maven-parent</artifactId>
  <version>a.b.c</version>
</parent>
```

Or if Quarkus:

```xml
<parent>
  <groupId>se.fk.maven</groupId>
  <artifactId>fk-maven-quarkus-parent</artifactId>
  <version>a.b.c</version>
</parent>
```

And build it with `./mvnw -s settings.xml verify`.
