package io.flutter.plugins

import io.flutter.plugin.common.PluginRegistry
import com.baseflow.geolocator.GeolocatorPlugin
import com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin
import io.flutter.plugins.googlemaps.GoogleMapsPlugin
import com.baseflow.location_permissions.LocationPermissionsPlugin
import io.flutter.plugins.pathprovider.PathProviderPlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
import com.tekartik.sqflite.SqflitePlugin

/**
 * Generated file. Do not edit.
 */
object GeneratedPluginRegistrant {
    fun registerWith(registry: PluginRegistry) {
        if (alreadyRegisteredWith(registry)) {
            return
        }
        GeolocatorPlugin.registerWith(registry.registrarFor("com.baseflow.geolocator.GeolocatorPlugin"))
        GoogleApiAvailabilityPlugin.registerWith(registry.registrarFor("com.baseflow.googleapiavailability.GoogleApiAvailabilityPlugin"))
        GoogleMapsPlugin.registerWith(registry.registrarFor("io.flutter.plugins.googlemaps.GoogleMapsPlugin"))
        LocationPermissionsPlugin.registerWith(registry.registrarFor("com.baseflow.location_permissions.LocationPermissionsPlugin"))
        PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"))
        SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"))
        SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"))
    }

    private fun alreadyRegisteredWith(registry: PluginRegistry): Boolean {
        val key = GeneratedPluginRegistrant::class.java!!.getCanonicalName()
        if (registry.hasPlugin(key)) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}
