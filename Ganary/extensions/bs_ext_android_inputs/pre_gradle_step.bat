@echo off

@REM Break the YYruntimeVersion into major and minor components
for /f "tokens=1,2 delims=." %%a in ("%YYruntimeVersion%") do (
    set YYruntimeVersionMajor=%%a
    set YYruntimeVersionMinor=%%b
)
@REM If Major is larger than 2024, exit early
if %YYruntimeVersionMajor% GTR 2024 exit /b 0

set
setlocal
if "%YYAndroidPackageName%"=="" set YYAndroidPackageName=com.company.game

@REM Break YYAndroidPackageName into a path string
set YYAndroidPackagePath=%YYAndroidPackageName:.=\%

set dest_dir=%YYMACROS_asset_compiler_cache_directory%\%YYMACROS_project_cache_directory_name%\%YYPLATFORM_name%\%YYconfig%\%YYAndroidPackageName%\src\main\java\%YYAndroidPackagePath%\DemoGLSurfaceView.java
set source_dir=%YYMACROS_project_dir%\extensions\bs_ext_android_inputs\DemoGLSurfaceView.java
echo %dest_dir%
echo %source_dir%
REM Copy the GameCredentials_Android.jwe file to the correct location
copy "%source_dir%" "%dest_dir%"