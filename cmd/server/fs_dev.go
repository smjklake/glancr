//go:build !prod

package main

import (
	"io/fs"
	"os"
)

func getUIAssets() fs.FS {
	return os.DirFS("ui/dist")
}
