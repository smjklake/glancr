//go:build prod

package fs

import (
	"embed"
	"io/fs"
)

//go:embed dist
var embedUI embed.FS

// / GetUIFS returns an embed FS for the UI components in the dist dir.
func getUIAssets() fs.FS {
	f, err := fs.Sub(embedUI, "dist")
	if err != nil {
		panic(err)
	}

	return f
}
