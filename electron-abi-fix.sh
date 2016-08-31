#!/bin/bash
# Let's fix your project!

printHelp () {
  printf "\nThe Elecron ABI fixer resolves module mismatch errors.\n\nUsage: electron-abi-fix 49 1.3.4\n\nIn this example 49 is the target abi version and 1.3.4 is the Electron version. If you don't specify the Electron version, this script will try to determine it by your package.json.\n\n"
  exit
}

if [ $# -eq 0 ]; then
  printHelp
elif [ $# -gt 2 ]; then
  printHelp
elif [ $# -eq 2 ]; then
  electronVersion=$2
fi

abiVersion=$1
echo $abiVersion

if ! command -v jq >/dev/null; then
  echo "I couldn't find jq but I need it. Perhaps try 'apt-get install jq' or 'yum install jq' then run me again."
  exit 2
fi

if [ ! -f "package.json" ]; then
  echo "I don't see your package.json file. Perhaps you're in the wrong directory."
  exit 1
fi

if [ $# < 2 ]; then
  electronVersion=$(cat package.json | jq -r '.dependencies.electron')

  if [ $electronVersion = "null" ]; then
    electronVersion=$(cat package.json | jq -r '.devDependencies.electron')
  fi

  if [ $electronVersion = "null" ]; then
    electronVersion=$(cat package.json | jq -r '.devDependencies.electron-prebuilt')
  fi

  if [ $electronVersion = "null" ]; then
    electronVersion=$(cat package.json | jq -r '.dependencies.electron-prebuilt')
  fi

  if [ $electronVersion = "null" ]; then
    echo "I couldn't find your electron version specified in package.json. Pass it to me if you need to like: electron-abi-fix 49 1.3.4"
    exit 1
  else
    npm rebuild --runtime=electron --target=$electronVersion --disturl=https://atom.io/download/atom-shell --abi=$abiVersion
  fi
fi
