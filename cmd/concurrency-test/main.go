package main

import (
	"fmt"
	"log"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	time.Sleep(time.Second)
	fmt.Println(time.Now())
	fmt.Fprintln(w, time.Now())
}

func main() {
	http.HandleFunc("/", handler)
	fmt.Println("Server listening on :8008")
	log.Fatal(http.ListenAndServe(":8008", nil))
}
