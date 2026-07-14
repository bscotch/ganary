#!/bin/bash
env
# Break the YYruntimeVersion into major and minor components
YYruntimeVersionMajor=${YYruntimeVersion%%.*}
YYruntimeVersionMinor=${YYruntimeVersion#*.}
# If Major is larger than 2024, exit early
if [ "$YYruntimeVersionMajor" -gt 2024 ]; then
    exit 0
fi



# If $YYAndroidPackageName is not set, provide a default
if [ -z "$YYAndroidPackageName" ]; then
    YYAndroidPackageName=com.bscotch.gamepipe
fi

# Break YYAndroidPackageName into a path string
YYAndroidPackagePath="${YYAndroidPackageName//.//}"

dest_dir="$YYtempFolder/$INPUT_PLATFORM/$YYconfig/$YYAndroidPackageName/src/main/java/$YYAndroidPackagePath/DemoGLSurfaceView.java"
source_dir="$YYprojectDir/extensions/bs_ext_android_inputs/DemoGLSurfaceView.java"
echo "$dest_dir"
echo "$source_dir"
# Copy DemoGLSurfaceView.java to the correct location
cp "$source_dir" "$dest_dir"