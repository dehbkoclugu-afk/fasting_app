package com.dehbkoclugu.fasttrack

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class FastingWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            val views = getRemoteViews(context)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }

    override fun onEnabled(context: Context) {
        // First widget placed
    }

    override fun onDisabled(context: Context) {
        // Last widget removed
    }

    companion object {
        private fun getRemoteViews(context: Context): RemoteViews {
            val views = RemoteViews(context.packageName, R.layout.fasting_widget)
            val prefs: SharedPreferences = HomeWidgetPlugin.getData(context)

            val isFasting = prefs.getBoolean("is_fasting", false)
            val planName = prefs.getString("plan_name", "") ?: ""
            val remainingTime = prefs.getString("remaining_time", "--:--:--") ?: "--:--:--"
            val phaseName = prefs.getString("phase_name", "") ?: ""

            if (isFasting) {
                views.setTextViewText(R.id.widget_status, "Fasting")
                views.setTextViewText(R.id.widget_time, remainingTime)
                views.setTextViewText(R.id.widget_plan, planName)
                views.setTextViewText(R.id.widget_phase, phaseName)
            } else {
                views.setTextViewText(R.id.widget_status, "Not Fasting")
                views.setTextViewText(R.id.widget_time, "--:--:--")
                views.setTextViewText(R.id.widget_plan, "")
                views.setTextViewText(R.id.widget_phase, "Tap to start")
            }

            return views
        }
    }
}
