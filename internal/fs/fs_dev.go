//go:build !prod

package fs

import (
	"io/fs"
	"os"
)

func getUIAssets() fs.FS {
	return os.DirFS("ui/dist")
}
