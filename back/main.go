package main

import (
	"back/auth"
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
func admin(c *gin.Context) {
	c.JSON(http.StatusOK,
	gin.H {
		"message" : "hello admin",
	})
}


func main() {
	router := gin.Default()

	var authHandler auth.Handler

	router.POST("/login", authHandler.Login)

	router.Use(authHandler.RequireJWT())

	router.GET("/api/hello", hello)

	router.GET("/api/admin", authHandler.RequireAdmin(), admin)

	router.Run(ADDR)
}
