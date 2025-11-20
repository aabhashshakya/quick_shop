package com.avas.quickshop.core.data

/// Created by Aabhash Shakya on 18/11/2025
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.stringPreferencesKey
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class DataStoreManager @Inject constructor(
    private val dataStore: DataStore<Preferences>
) {

    private val UUID_KEY = stringPreferencesKey("UUID")

    suspend fun saveUUID(uuid: String) {
        dataStore.edit { prefs ->
            prefs[UUID_KEY] = uuid
        }
    }

    val uuidFlow: Flow<String?> = dataStore.data.map { prefs ->
        prefs[UUID_KEY]
    }

    suspend fun clearUUID() {
        dataStore.edit { prefs ->
            prefs.remove(UUID_KEY)
        }
    }

}
