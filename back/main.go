package main

import (
	"back/config"
	"net/http"

	"strconv"
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

func main() {

	conf := config.Config
	addr := conf.Server.Address + ":" + strconv.Itoa(conf.Server.Port)
	
	router := gin.Default()
	router.GET("/hello", hello)
	router.Run(addr)
}
