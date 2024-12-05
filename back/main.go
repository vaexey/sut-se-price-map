package main

import (
	"encoding/json"
	"fmt"
	"net/http"
)

const ADDR = ":6969"

func hello(w http.ResponseWriter, req *http.Request) {
	id := req.PathValue("id")
	param := req.URL.Query().Get("param")

	data := map[string]any{
		"message":     "hello",
		"error":       nil,
		"id":          id,
		"query-param": param,
	}

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK) // 200

	json.NewEncoder(w).Encode(data)
}

func main() {
	fmt.Printf("listening on: %s\n", ADDR)
	http.HandleFunc("GET /hello/{id}", hello)
	http.HandleFunc("/", hello)
	http.ListenAndServe(ADDR, nil)
}
