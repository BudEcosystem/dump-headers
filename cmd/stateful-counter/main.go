package main

import (
	"fmt"
	"log"
	"net/http"
	"sync"
)

var mu sync.Mutex
var count int

func handler(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	count += 1
	mu.Unlock()

	s := fmt.Sprintf("count : %v", count)
	fmt.Println(s)
	fmt.Fprintln(w, s)
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server listening on :8008")
	log.Fatal(http.ListenAndServe(":8008", nil))
}
