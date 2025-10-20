package com.example.flutter_hello2

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import com.yandex.mapkit.MapKitFactory
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("8d654503-f6d3-467c-bb60-62c55598bd8a")
        super.configureFlutterEngine(flutterEngine)
    }
}
