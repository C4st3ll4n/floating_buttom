package br.com.castellan.floating_buttom

import android.os.Bundle
import android.os.PersistableBundle
import android.widget.ImageView
import androidx.annotation.NonNull
import com.yhao.floatwindow.FloatWindow
import com.yhao.floatwindow.Screen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private final val CHANNEL = "floating_buttom"
    private val channel = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "create" -> {
                    val img: ImageView = ImageView(applicationContext)
                    img.setImageResource(R.mipmap.ic_back_add_round)
                    FloatWindow.with(applicationContext).setView(img)
                            .setWidth(Screen.width, 0.15f)
                            .setHeight(Screen.width, 0.15f)
                            .setX(Screen.width, 0.8f)
                            .setY(Screen.height, 0.3f)
                            .setDesktopShow(true)
                            .build()

                    img.setOnClickListener {
                        channel.invokeMethod("touch",null)
                    }
                }
                "show" -> FloatWindow.get().show()
                "hide" -> FloatWindow.get().hide()
                "isShowing" -> result.success(FloatWindow.get().isShowing)
                else -> result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        FloatWindow.destroy()
        super.onDestroy()

    }
}
