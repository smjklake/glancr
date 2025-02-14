<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="flex min-h-screen flex-col">
    <header class="bg-black shadow-lg">
      <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <nav class="flex h-16 items-center justify-between">
          <div class="flex items-center">
            <span class="text-xl font-bold text-white">Glancr</span>
          </div>
          <div class="flex space-x-4">
            <RouterLink
              to="/"
              class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 transition-colors duration-200 hover:text-white"
              active-class="bg-gray-900 text-white"
            >
              Home
            </RouterLink>
            <RouterLink
              to="/about"
              class="rounded-md px-3 py-2 text-sm font-medium text-gray-300 transition-colors duration-200 hover:text-white"
              active-class="bg-gray-900 text-white"
            >
              About
            </RouterLink>
          </div>
        </nav>
      </div>
    </header>

    <main class="flex-grow">
      <div class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
        <RouterView />
      </div>
    </main>

    <footer class="bg-gray-100">
      <div class="mx-auto max-w-7xl px-4 py-4 sm:px-6 lg:px-8">
        <p class="text-center text-sm text-gray-500">© {{new Date().getFullYear()}} Glancr. All rights reserved.</p>
      </div>
    </footer>
  </div>
</template>

<style scoped></style>
