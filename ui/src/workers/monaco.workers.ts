import editorWorker from 'monaco-editor/esm/vs/editor/editor.worker?worker';

self.MonacoEnvironment = {
  getWorker() {
    return new editorWorker();
  },
};

export function setupMonaco() {
  // This function is intentionally empty - it just needs to be imported
  // to set up the workers
}
