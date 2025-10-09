# FK Maven

Common Maven stuff.

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
      <id>github--Forsakringskassan</id>
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
      <id>github--Forsakringskassan</id>
      <url>https://maven.pkg.github.com/Forsakringskassan/fk-maven</url>
    </repository>
  </repositories>
```

Many repositories can have same ID. And every repository with that same ID can share same credentials from `settings.xml`.

And also the actual dependency:

```xml
<parent>
  <groupId>se.fk.maven</groupId>
  <artifactId>fk-maven-parent</artifactId>
  <version>a.b.c</version>
</parent>
```

And build it with `./mvnw -s settings.xml verify`.
