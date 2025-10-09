# FK Maven

Common Maven stuff.

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
      <id>github--Forsakringskassan--fk-maven</id>
      <username>${env.GITHUB_ACTOR}</username>
      <password>${env.GITHUB_TOKEN}</password>
    </server>
  </servers>
</settings>
```

And in `pom.xml`:

```xml
  <distributionManagement>
    <repository>
      <id>github--Forsakringskassan--fk-maven</id>
      <name>GitHub Packages</name>
      <url>https://maven.pkg.github.com/Forsakringskassan/fk-maven</url>
    </repository>
  </distributionManagement>
```

And also the actual dependency:

```xml
<parent>
  <groupId>se.fk.maven</groupId>
  <artifactId>fk-maven-parent</artifactId>
  <version>1.1.0</version>
</parent>
```

And build it with `./mvnw -s settings.xml verify`.
