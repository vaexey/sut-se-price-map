package main

import (
	"back/config"
	"back/services"
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

func readConfig(){
	singleton := services.GetInstance()
	config, err := config.ReadConfig("config.json")
	if err != nil {
		return
	}
	singleton.SetConfig(config)
}

func main() {
	readConfig()
	address := services.GetInstance().GetConfig().Address
	port := services.GetInstance().GetConfig().Port
	
	ADDR := address + ":" + strconv.Itoa(port)
	
	router := gin.Default()
	router.GET("/hello", hello)
	router.Run(ADDR)
}
