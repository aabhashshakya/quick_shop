package com.avas.quickshop.features.login.data

/// Created by Aabhash Shakya on 18/11/2025
import com.avas.quickshop.core.data.DataStoreManager
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.firstOrNull
import kotlinx.coroutines.withContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class AuthRepository @Inject constructor(
    private val dataStoreManager: DataStoreManager
) {
    val uuidFlow: Flow<String?> = dataStoreManager.uuidFlow

    suspend fun saveUUID(uuid: String) {
        dataStoreManager.saveUUID(uuid)
    }

    suspend fun logout(){
        dataStoreManager.clearUUID()
    }

    suspend fun isUserLoggedIn(): Boolean {
        return withContext(Dispatchers.IO) {
            !uuidFlow.firstOrNull().isNullOrBlank()
        }
    }
}
