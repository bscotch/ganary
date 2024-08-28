
package ${YYAndroidPackageName};

import ${YYAndroidPackageName}.R;
import com.yoyogames.runner.RunnerJNILib;
import ${YYAndroidPackageName}.RunnerActivity;

import android.app.Activity;
import android.util.Log;
import android.content.Intent;

import android.content.ContentResolver;
import android.net.Uri;
import java.io.OutputStream;
import java.io.IOException;

import android.os.Environment;
import java.io.File;

import java.nio.file.StandardCopyOption.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;



public class Olympus extends RunnerSocial {
  public static Activity activity = null;
  public static Intent launchIntent = null;

  public void _olympus_android_init() {
    Log.i("yoyo", "_olympus_android_init");
    activity = RunnerActivity.CurrentActivity;
    launchIntent = activity.getIntent();
    Log.i("yoyo", "launchIntent: " + launchIntent);
  }

  public void _olympus_android_game_end() {
    activity.finish();
  }

  public String _olympus_android_get_init_confirmation() {
    return "initialized";
  }

  public String _olympus_android_get_intent() {
    Log.i("yoyo", "getIntent");
    return launchIntent.toString();
  }

  public void _olympus_android_write_custom_output(String data) {
      Uri logFileUri = launchIntent.getData();
      if (logFileUri == null) {
          Log.e("yoyo", "Log file URI is null");
          return;
      }
      else{
          Log.i("yoyo", "Log file URI: " + logFileUri);
      }

      ContentResolver contentResolver = activity.getContentResolver();
      OutputStream outputStream = null;
      try {
          outputStream = contentResolver.openOutputStream(logFileUri);
          if (outputStream != null) {
              outputStream.write(data.getBytes());
              outputStream.flush();
              Log.i("yoyo", "Data written to log file successfully");
          } else {
              Log.e("yoyo", "Failed to open OutputStream");
          }
      } catch (IOException e) {
          Log.e("yoyo", "Error writing to log file", e);
      } finally {
          if (outputStream != null) {
              try {
                  outputStream.close();
              } catch (IOException e) {
                  Log.e("yoyo", "Error closing OutputStream", e);
              }
          }
      }
  }

    private  void copyFolder(Path src, Path dest) throws IOException {
        try (Stream<Path> stream = Files.walk(src)) {
            stream.forEach(source -> copy(source, dest.resolve(src.relativize(source))));
        }
    }

    private void copy(Path source, Path dest) {
        try {
            Files.copy(source, dest, REPLACE_EXISTING);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }

    // Function to copy all files from internal storage to SD card
    public void _olympus_android_copy_files_to_SD_card() {
        File sourceDir = activity.getFilesDir(); // Get internal files directory
        Log.i("yoyo", "Source directory: " + sourceDir);
        String externalStorageState = Environment.getExternalStorageState();
        if (!externalStorageState.equals(Environment.MEDIA_MOUNTED)) {
            Log.e("yoyo", "External storage not mounted");
            return;
        }
        else{
            Log.i("yoyo", "External storage state: " + externalStorageState);
        }

        File[] externalStorageVolumes = activity.getExternalFilesDirs(null);
        File primaryExternalStorage = externalStorageVolumes[0];
        File secondaryExternalStorage = externalStorageVolumes[1];
        Log.i("yoyo", "Primary external storage: " + primaryExternalStorage);
        Log.i("yoyo", "Secondary external storage: " + secondaryExternalStorage);


        File targetDir = new File(secondaryExternalStorage, "MyAppFiles"); // Destination on SD card
        Log.i("yoyo", "Target directory: " + targetDir);        
        if (!targetDir.exists()) {
            if (!targetDir.mkdirs()) {
                Log.i("yoyo", "Failed to create target directory");
                return;
            }
        }

        try {
            copyFolder(sourceDir.toPath(), targetDir.toPath());
        } catch (IOException e) {
            Log.e("yoyo", "Error copying files", e);
        }
    }
}