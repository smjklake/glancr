// +build !prod

package server

import (
  "io/fs"
  "os"
)

func getUIAssets() fs.FS {
  return os.DirFS("ui/dist")
}

