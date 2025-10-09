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
      <id>github--Forsakringskassan--template-api</id>
      <username>${env.GITHUB_ACTOR}</username>
      <password>${env.GITHUB_TOKEN}</password>
    </server>
  </servers>
</settings>
```

And build it with `./mvnw -s settings.xml verify`.
