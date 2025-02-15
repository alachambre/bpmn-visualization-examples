#! /bin/bash
set -e

############################################################
# update all html files in the examples folder
############################################################
if [ $# -ne 1 ]; then
	echo "Mandatory parameter <new_version> missing."
	exit 1
fi
NEW_VERSION=$1
echo "Updating examples to make them use demo@$NEW_VERSION"

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
EXAMPLES_DIRECTORY="$SCRIPT_DIRECTORY/../examples"
pushd "$EXAMPLES_DIRECTORY" > /dev/null

echo "Search for files in $(pwd)"

rexep_npm="s/\"bpmn-visualization\": \".*\"/\"bpmn-visualization\": \"$NEW_VERSION\"/"
# lines to update contains substring like "bpmn-visualization@x.y.z"
rexep_others="s/\/bpmn-visualization@.*\/dist/\/bpmn-visualization@$NEW_VERSION\/dist/"

if [[ "$OSTYPE" == "darwin"* ]]; then
	sed -i '' -E "${rexep_others}" **/**/*.{html,md,js}
	sed -i '' -E "${rexep_npm}" **/**/package.json
else
	sed -i -E "${rexep_others}#" **/**/*.{html,md,js}
	sed -i -E "${rexep_npm}#" **/**/package.json
fi

echo "Files updated"
popd > /dev/null
pwd
