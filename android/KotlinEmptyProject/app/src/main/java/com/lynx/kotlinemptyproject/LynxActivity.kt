package com.lynx.kotlinemptyproject

import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity

class LynxActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        render(intent.getStringExtra(INTENT_EXTRA_URL))
    }

    private fun render(url: String?) {
        // TODO: render lynx view here
    }

    companion object {
        private const val TAG = "LynxActivity"
        private const val INTENT_EXTRA_URL = "url"

        fun start(context: Context, url: String) {
            val intent = Intent(context, LynxActivity::class.java)
            intent.putExtra(INTENT_EXTRA_URL, url)
            context.startActivity(intent)
        }

    }
}