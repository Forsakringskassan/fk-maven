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

# For visual inspection of diffs
git diff | cat

# Define the test file and approved diff file
test_file="examples/test-example/src/main/java/example/Example.java"
approved_diff_file="examples/test-example/Example.java.approved.diff"

# Generate the current diff
current_diff=$(git diff "$test_file")

# Check if approved diff file exists
if [ -f "$approved_diff_file" ]; then
    # Compare current diff with approved diff
    approved_diff=$(cat "$approved_diff_file")
    
    if [ "$current_diff" != "$approved_diff" ]; then
        echo "❗️ERROR: The diff of $test_file does not match the approved diff!"
        echo "Expected diff (from $approved_diff_file):"
        echo "$approved_diff"
        echo ""
        echo "Actual diff:"
        echo "$current_diff"
        echo ""
        echo "♻️ To approve this diff, run:"
        echo "  git diff $test_file > $approved_diff_file"
        exit 1
    else
        echo "✅ Diff matches approved diff for $test_file"
    fi
else
    # Create the approved diff file if it doesn't exist
    echo "♻️ Creating approved diff file: $approved_diff_file"
    git diff "$test_file" > "$approved_diff_file"
    echo "Approved diff file created. Review and commit it."
fi

git checkout HEAD examples

echo "OK"
echo
