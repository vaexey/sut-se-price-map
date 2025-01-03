package main

import (
	"net/http"
	"github.com/gin-gonic/gin"
)

const ADDR = "127.0.0.1:6969"

func hello(c *gin.Context) {
	message := c.Query("msg")
	c.JSON(http.StatusOK,
	gin.H {
		"message": "hello",
		"error": nil,
		"msg": message,
		},
	)
}

func main() {
	router := gin.Default()
	router.GET("/hello", hello)
	router.Run(ADDR)
}
