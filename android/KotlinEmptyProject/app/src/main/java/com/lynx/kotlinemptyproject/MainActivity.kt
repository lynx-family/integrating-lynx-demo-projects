package com.lynx.kotlinemptyproject

import android.os.Bundle
import android.view.Gravity
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import com.lynx.kotlinemptyproject.ui.theme.KotlinEmptyProjectTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setupUI()
    }
    private fun setupUI() {
        val constraintLayout = ConstraintLayout(this)
        constraintLayout.id = View.generateViewId()
        setContentView(constraintLayout)

        val textView = TextView(this)
        textView.id = View.generateViewId()
        textView.text = "Hello Lynx!"
        textView.textSize = 30f
        textView.gravity = Gravity.CENTER

        val button = Button(this)
        button.id = View.generateViewId()
        button.text = "Go"
        button.setOnClickListener {
            // TODO: modify url to lynx bundle url here
            val url = ""
            if (url.isNotEmpty()) {
                LynxActivity.start(this, url)
            } else {
                Toast.makeText(this, "Please modify url", Toast.LENGTH_SHORT).show()
            }
        }

        constraintLayout.addView(textView)
        constraintLayout.addView(button)

        val set = ConstraintSet()
        set.clone(constraintLayout)

        set.connect(textView.id, ConstraintSet.TOP, ConstraintSet.PARENT_ID, ConstraintSet.TOP, 16)
        set.connect(textView.id, ConstraintSet.START, ConstraintSet.PARENT_ID, ConstraintSet.START, 16)
        set.connect(textView.id, ConstraintSet.END, ConstraintSet.PARENT_ID, ConstraintSet.END, 16)

        set.connect(button.id, ConstraintSet.TOP, textView.id, ConstraintSet.BOTTOM, 32)
        set.connect(button.id, ConstraintSet.START, ConstraintSet.PARENT_ID, ConstraintSet.START, 16)
        set.connect(button.id, ConstraintSet.END, ConstraintSet.PARENT_ID, ConstraintSet.END, 16)

        set.applyTo(constraintLayout)
    }
}

@Composable
fun Greeting(name: String, modifier: Modifier = Modifier) {
    Text(
        text = "Hello $name!",
        modifier = modifier
    )
}

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    KotlinEmptyProjectTheme {
        Greeting("Android")
    }
}