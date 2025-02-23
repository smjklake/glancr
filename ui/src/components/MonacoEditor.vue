<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount, watch } from 'vue'
import { editor } from 'monaco-editor/esm/vs/editor/editor.api.js'
import { setupMonaco } from '@/workers/monaco.workers'

import 'monaco-editor/esm/vs/basic-languages/markdown/markdown.contribution'

// Load common languages for code fences
const loadLanguage = async (language: string) => {
  switch (language) {
    case 'javascript':
      await import('monaco-editor/esm/vs/basic-languages/javascript/javascript.contribution')
      break
    case 'typescript':
      await import('monaco-editor/esm/vs/basic-languages/typescript/typescript.contribution')
      break
    case 'python':
      await import('monaco-editor/esm/vs/basic-languages/python/python.contribution')
      break
    // Add more languages as needed
  }
}

// Initialize monaco workers
setupMonaco()

const props = defineProps<{
  modelValue: string
  language?: string
  options?: editor.IStandaloneEditorConstructionOptions
}>()

const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void
}>()

const editorContainer = ref<HTMLElement | null>(null)
let editorInstance: editor.IStandaloneCodeEditor | null = null

// Function to detect and load languages from code fences
const loadLanguagesFromContent = async (content: string) => {
  const codeBlockRegex = /```(\w+)/g
  const matches = [...content.matchAll(codeBlockRegex)]
  const languages = [...new Set(matches.map((match) => match[1]))]

  await Promise.all(languages.map((lang) => loadLanguage(lang)))
}

onMounted(async () => {
  if (!editorContainer.value) return

  // Load initial languages from content
  await loadLanguagesFromContent(props.modelValue)
  // Create editor instance
  editorInstance = editor.create(editorContainer.value, {
    value: props.modelValue,
    language: 'markdown',
    theme: 'vs-dark',
    automaticLayout: true,
    minimap: { enabled: false },
    wordWrap: 'on',
    quickSuggestions: false,
    ...props.options,
  })

  // Handle content changes
  editorInstance.onDidChangeModelContent(() => {
    const value = editorInstance?.getValue() ?? ''
    emit('update:modelValue', value)
    loadLanguagesFromContent(value) // Load languages when content changes
  })
})

// Watch for external value changes
watch(
  () => props.modelValue,
  async (newValue) => {
    if (editorInstance && newValue !== editorInstance.getValue()) {
      await loadLanguagesFromContent(newValue)
      editorInstance.setValue(newValue)
    }
  },
)

// Cleanup
onBeforeUnmount(() => {
  if (editorInstance) {
    editorInstance.dispose()
  }
})
</script>

<template>
  <div ref="editorContainer" class="w-full h-full min-h-[300px]"></div>
</template>

