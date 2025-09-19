package main

import (
	"fmt"
	"log"
	"net/http"
	"sort"
)

func handler(w http.ResponseWriter, r *http.Request) {
	var headerNames []string

	for name := range r.Header {
		headerNames = append(headerNames, name)
	}
	sort.Strings(headerNames)

	fmt.Fprintln(w, "--- Request Headers ---")
	for _, name := range headerNames {
		values := r.Header[name]
		sort.Strings(values)

		for _, value := range values {
			fmt.Fprintf(w, "%s: %s\n", name, value)
		}
	}
	fmt.Fprintln(w, "-----------------------")
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server listening on :8008")
	log.Fatal(http.ListenAndServe(":8008", nil))
}
