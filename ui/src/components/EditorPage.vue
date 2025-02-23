<script setup lang="ts">
import { ref, defineAsyncComponent } from 'vue'

const MonacoEditor = defineAsyncComponent(() => import('@/components/MonacoEditor.vue'))

const code = ref('# Hello from markdown\n\n\t> this is a markdown note')
</script>

<template>
  <Suspense>
    <MonacoEditor v-model="code" language="markdown" :options="{ readOnly: false }" />
    <template #fallback>
      <div>Loading editor...</div>
    </template>
  </Suspense>
</template>
