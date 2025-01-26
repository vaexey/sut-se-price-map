package main

import (
	"back/auth"
	"back/config"
	dbh "back/db"
	model "back/model/db"
	"fmt"
	"net/http"
	"os"

	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

func hello(c *gin.Context) {
	message := c.Query("msg")
	c.JSON(http.StatusOK,
		gin.H{
			"message": "hello",
			"error":   nil,
			"msg":     message,
		},
	)
}
func admin(c *gin.Context) {
	c.JSON(http.StatusOK,
		gin.H{
			"message": "hello admin",
		})
}

var staticIndexFile []byte

func serveStaticIndex(c *gin.Context) {
	if staticIndexFile == nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"error": "Unavailable",
		})

		return
	}

	c.Data(200, "text/html", staticIndexFile)
}

func main() {
	// TODO: make configurable (through env)
	// --> gin.SetMode(gin.ReleaseMode)
	router := gin.New()

	logger := gin.Logger()
	recovery := gin.Recovery()
	router.Use(logger, recovery)

	// TODO: derive from env variables
	dsn := "postgres://docker:root@localhost:5432/docker"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	if err != nil {
		fmt.Fprint(gin.DefaultErrorWriter, "Could not open connection with DB\n")
	}

	// example db interface usage
	dbHandler := dbh.NewDbHandler(db)
	var users []model.User

	users, err = dbHandler.User.SelectAll()

	for i, user := range users {
		fmt.Printf("[%d] id: %d, name: %s, password: %s\n", i, user.Id, user.DisplayName, user.Password)
	}

	// Preload main static file for quick response
	file, err := os.ReadFile("./static/index.html")
	staticIndexFile = file

	if err != nil {
		fmt.Fprint(gin.DefaultErrorWriter, "Could not load static index file\n")
	}

	var authHandler auth.Handler
	authMiddleware := authHandler.RequireJWT()
	adminMiddleware := authHandler.RequireAdmin()

	// Anonymous
	router.POST("/api/v1/login", authHandler.Login)

	// Auth-guarded
	router.GET("/api/v1/hello", authMiddleware, hello)
	router.GET("/api/v1/admin", authMiddleware, adminMiddleware, admin)

	// Static files
	router.GET("/", serveStaticIndex)
	router.GET("/index.html", serveStaticIndex)
	// TODO: cache
	router.Use(static.Serve("/", static.LocalFile("./static", false)))
	router.NoRoute(serveStaticIndex)

	conf := config.Config
	addr := fmt.Sprintf("%s:%d", conf.Server.Address, conf.Server.Port)
	panic(router.Run(addr))
}
