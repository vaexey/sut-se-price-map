package main

import (
	"back/auth"
	"back/config"
  "fmt"
	"net/http"
	"github.com/gin-gonic/gin"
)

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

	conf := config.Config
  addr := fmt.Sprintf("%s:%d", conf.Server.Address, conf.Server.Port)
  
	router := gin.Default()

	var authHandler auth.Handler

	router.POST("/login", authHandler.Login)

	router.Use(authHandler.RequireJWT())

	router.GET("/api/hello", hello)

	router.GET("/api/admin", authHandler.RequireAdmin(), admin)
  
	router.Run(addr)
}
