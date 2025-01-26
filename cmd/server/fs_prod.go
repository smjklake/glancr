//go:build prod

package main

import (
	"github.com/smjklake/glancr/ui"
	"io/fs"
)

func getUIAssets() fs.FS {
	return ui.GetUIFS()
}
