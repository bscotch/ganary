{
  "$GMExtension":"",
  "%Name":"_olympus_extension",
  "androidactivityinject":"\r\n   <intent-filter>\r\n       <action android:name=\"com.google.intent.action.TEST_LOOP\"></action>\r\n       <category android:name=\"android.intent.category.DEFAULT\"></category>\r\n       <data android:mimeType=\"application/javascript\"></data>\r\n   </intent-filter>\r\n",
  "androidclassname":"Olympus",
  "androidcodeinjection":"<YYAndroidManifestActivityInject>\r\n   <intent-filter>\r\n       <action android:name=\"com.google.intent.action.TEST_LOOP\"/>\r\n       <category android:name=\"android.intent.category.DEFAULT\"/>\r\n       <data android:mimeType=\"application/javascript\"/>\r\n   </intent-filter>\r\n</YYAndroidManifestActivityInject>\r\n\r\n<YYAndroidManifestApplicationInject>\r\n<meta-data\r\n  android:name=\"com.google.test.loops\"\r\n  android:value=\"5\" />\r\n</YYAndroidManifestApplicationInject>\r\n",
  "androidinject":"\r\n<meta-data android:name=\"com.google.test.loops\" android:value=\"5\"></meta-data>\r\n",
  "androidmanifestinject":"",
  "androidPermissions":[],
  "androidProps":true,
  "androidsourcedir":"",
  "author":"",
  "classname":"Olympus",
  "ConfigValues":{
    "gamepipe_test":{
      "copyToTargets":"3035461389054378222",
    },
  },
  "copyToTargets":12,
  "description":"",
  "exportToGame":true,
  "extensionVersion":"0.0.1",
  "files":[
    {"$GMExtensionFile":"","%Name":"_olympus_extension.ext","ConfigValues":{
        "dev":{
          "copyToTargets":"12",
        },
      },"constants":[],"copyToTargets":12,"filename":"_olympus_extension.ext","final":"","functions":[
        {"$GMExtensionFunction":"","%Name":"_olympus_android_init","argCount":0,"args":[],"documentation":"","externalName":"_olympus_android_init","help":"","hidden":false,"kind":4,"name":"_olympus_android_init","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_android_game_end","argCount":0,"args":[],"documentation":"","externalName":"_olympus_android_game_end","help":"","hidden":false,"kind":4,"name":"_olympus_android_game_end","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_ios_finish_loop","argCount":0,"args":[],"documentation":"","externalName":"_olympus_ios_finish_loop","help":"","hidden":false,"kind":4,"name":"_olympus_ios_finish_loop","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_android_get_init_confirmation","argCount":0,"args":[],"documentation":"","externalName":"_olympus_android_get_init_confirmation","help":"","hidden":false,"kind":4,"name":"_olympus_android_get_init_confirmation","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_android_get_intent","argCount":0,"args":[],"documentation":"","externalName":"_olympus_android_get_intent","help":"","hidden":false,"kind":4,"name":"_olympus_android_get_intent","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_ios_get_init_confirmation","argCount":0,"args":[],"documentation":"","externalName":"_olympus_ios_get_init_confirmation","help":"","hidden":false,"kind":4,"name":"_olympus_ios_get_init_confirmation","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_ios_get_intent","argCount":0,"args":[],"documentation":"","externalName":"_olympus_ios_get_intent","help":"","hidden":false,"kind":4,"name":"_olympus_ios_get_intent","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_android_write_custom_output","argCount":0,"args":[1,],"documentation":"","externalName":"_olympus_android_write_custom_output","help":"_olympus_android_write_custom_output(data)","hidden":false,"kind":4,"name":"_olympus_android_write_custom_output","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
        {"$GMExtensionFunction":"","%Name":"_olympus_ios_get_available_ram","argCount":0,"args":[],"documentation":"","externalName":"_olympus_ios_get_available_ram","help":"","hidden":false,"kind":4,"name":"_olympus_ios_get_available_ram","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":2,},
        {"$GMExtensionFunction":"","%Name":"_olympus_android_copy_files_to_SD_card","argCount":0,"args":[],"documentation":"","externalName":"_olympus_android_copy_files_to_SD_card","help":"","hidden":false,"kind":4,"name":"_olympus_android_copy_files_to_SD_card","resourceType":"GMExtensionFunction","resourceVersion":"2.0","returnType":1,},
      ],"init":"","kind":4,"name":"_olympus_extension.ext","order":[
        {"name":"_olympus_android_init","path":"extensions/_olympus_extension/_olympus_extension.yy",},
        {"name":"_olympus_android_game_end","path":"extensions/_olympus_extension/_olympus_extension.yy",},
      ],"origname":"","ProxyFiles":[],"resourceType":"GMExtensionFile","resourceVersion":"2.0","uncompress":false,"usesRunnerInterface":false,},
  ],
  "gradleinject":"",
  "hasConvertedCodeInjection":true,
  "helpfile":"",
  "HTML5CodeInjection":"",
  "html5Props":false,
  "IncludedResources":[],
  "installdir":"",
  "iosCocoaPodDependencies":"",
  "iosCocoaPods":"",
  "ioscodeinjection":"<YYIosPlist>\r\n  <key>UIFileSharingEnabled</key>\r\n  <true/>\r\n  <key>CFBundleURLTypes</key>\r\n    <array>\r\n        <dict>\r\n            <key>CFBundleURLName</key>\r\n            <string></string>\r\n            <key>CFBundleTypeRole</key>\r\n            <string>Editor</string>\r\n            <key>CFBundleURLSchemes</key>\r\n            <array>\r\n                <string>firebase-game-loop</string>\r\n                <string>$(PRODUCT_BUNDLE_IDENTIFIER).echo</string>\r\n            </array>\r\n        </dict>\r\n    </array>\r\n</YYIosPlist>",
  "iosdelegatename":"OlympusDelegate",
  "iosplistinject":"\r\n  <key>UIFileSharingEnabled</key>\r\n  <true></true>\r\n  <key>CFBundleURLTypes</key>\r\n    <array>\r\n        <dict>\r\n            <key>CFBundleURLName</key>\r\n            <string></string>\r\n            <key>CFBundleTypeRole</key>\r\n            <string>Editor</string>\r\n            <key>CFBundleURLSchemes</key>\r\n            <array>\r\n                <string>firebase-game-loop</string>\r\n                <string>$(PRODUCT_BUNDLE_IDENTIFIER).echo</string>\r\n            </array>\r\n        </dict>\r\n    </array>\r\n",
  "iosProps":true,
  "iosSystemFrameworkEntries":[],
  "iosThirdPartyFrameworkEntries":[],
  "license":"",
  "maccompilerflags":"",
  "maclinkerflags":"",
  "macsourcedir":"",
  "name":"_olympus_extension",
  "options":[],
  "optionsFile":"options.json",
  "packageId":"",
  "parent":{
    "name":"Olympus",
    "path":"folders/Modules/Olympus.yy",
  },
  "productId":"",
  "resourceType":"GMExtension",
  "resourceVersion":"2.0",
  "sourcedir":"",
  "supportedTargets":-1,
  "tvosclassname":null,
  "tvosCocoaPodDependencies":"",
  "tvosCocoaPods":"",
  "tvoscodeinjection":"",
  "tvosdelegatename":null,
  "tvosmaccompilerflags":"",
  "tvosmaclinkerflags":"",
  "tvosplistinject":"",
  "tvosProps":false,
  "tvosSystemFrameworkEntries":[],
  "tvosThirdPartyFrameworkEntries":[],
}