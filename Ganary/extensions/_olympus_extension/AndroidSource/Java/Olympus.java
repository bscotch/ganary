
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
}