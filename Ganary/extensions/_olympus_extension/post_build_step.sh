#!/bin/bash
# Break the YYruntimeVersion into major and minor components
YYruntimeVersionMajor=${YYruntimeVersion%%.*}
YYruntimeVersionMinor=${YYruntimeVersion#*.}


env

input_platform="";
temp_folder="";

case "$(uname -s)" in
    Linux)
        input_platform="$INPUT_PLATFORM"
        temp_folder="$YYtempFolder"
        ;;
    Darwin)
        input_platform="$YYPLATFORM_name"
        temp_folder="$GMAssetLogLoc"
        ;;
    *)
        echo "Warning: unrecognized OS '$(uname -s)'"
        ;;
esac

# If $YYAndroidPackageName is not set, provide a default
if [ -z "$YYAndroidPackageName" ]; then
    YYAndroidPackageName=com.bscotch.ganary
fi

# Break YYAndroidPackageName into a path string
YYAndroidPackagePath="${YYAndroidPackageName//.//}"

dest_dir="$temp_folder/$input_platform/$YYconfig/$YYAndroidPackageName/src/main/java/$YYAndroidPackagePath/DemoGLSurfaceView.java"
source_dir="$YYprojectDir/extensions/bs_android_input_pre_lts_compatibility/DemoGLSurfaceView.java"
echo "$dest_dir"
echo "$source_dir"
# Copy DemoGLSurfaceView.java to the correct location
# cp "$source_dir" "$dest_dir"