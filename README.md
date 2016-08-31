# electron-abi-fix
Fixes "Module version mismatch. Expected x, got x." errors.

Installation: Drop into your project's root directory where your package.json file is located.

Usage: sh electron-abi-fix.sh 49

or: sh electron-abi-fix.sh 49 1.3.4
   
The first example will figure out your Electron version for you by detecting it in your package.json. All you have to pass is the target ABI version. If you want you can pass the Electron version as the second parameter.
