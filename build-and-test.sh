#!/bin/bash
set -ex

scriptdir=$(pwd)

rm -rf ~/.m2/repository/se/fk
find . -name target | xargs rm -rf

./mvnw install
parentVersion=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

subprojects=(
"test-example|./mvnw -s settings.xml initialize spotless:apply"
)

run_subproject() {
    local name="$1"
    local cmds="$2"
    local testitem="examples/$name"

    echo
    echo "|"
    echo "| Testing $testitem"
    echo "|"

    pushd "$testitem" >/dev/null

    cp -r "$scriptdir/.mvn" .
    cp "$scriptdir/mvnw" .
    cp "$scriptdir/mvnw.cmd" .
    cp "$scriptdir/settings.xml" .

    while IFS= read -r c || [ -n "$c" ]; do
        c=$(echo "$c" | xargs)
        if [ -n "$c" ]; then
            echo "| Running: $c"
            sed -i "s|<version>latest-SNAPSHOT</version>|<version>$parentVersion</version>|" pom.xml

            bash -c "$c"
            echo
        fi
    done <<< "$cmds"

    popd >/dev/null
}

for entry in "${subprojects[@]}"; do
    IFS="|" read -r sub cmd <<< "$entry"
    run_subproject "$sub" "$cmd"
done

git diff | cat

git checkout HEAD examples

echo "OK"
echo
