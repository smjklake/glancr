package main

import (
	"log"
	"net/http"
	"os"
	"path"
	"strings"
)

func spaHandler() http.HandlerFunc {
	fs := getUIAssets()
	fileServer := http.FileServer(http.FS(fs))

	return func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/" {
			fileServer.ServeHTTP(w, r)
			return
		}
		f, err := fs.Open(strings.TrimPrefix(path.Clean(r.URL.Path), "/"))
		if err == nil {
			defer f.Close()
		}
		if os.IsNotExist(err) {
			r.URL.Path = "/"
		}
		fileServer.ServeHTTP(w, r)
	}
}

func main() {

	log.Println("Starting glancr on port 8080")
	http.HandleFunc("/", spaHandler())
	log.Fatal(http.ListenAndServe(":8080", nil))
}
