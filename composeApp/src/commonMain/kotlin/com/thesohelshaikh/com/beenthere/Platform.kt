package com.thesohelshaikh.com.beenthere

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform