package main

import (
	lapi "back/api"
	ldb "back/db"
	"back/auth"
	"back/config"
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

	// Preload main static file for quick response
	file, err := os.ReadFile("./static/index.html")
	staticIndexFile = file

	if err != nil {
		fmt.Fprint(gin.DefaultErrorWriter, "Could not load static index file\n")
	}

	database := ldb.NewDatabase(db)
	api := lapi.NewApi(&database)

	authHandler := auth.Handler {
		Db : &database,
	}

	authMiddleware := authHandler.RequireJWT()
	adminMiddleware := authHandler.RequireAdmin()


	v1 := router.Group(config.API_PATH)
	{
		// Anonymous
		v1.PUT("sign-up", authHandler.Register)
		v1.POST("login", authHandler.Login)

		// API
		v1.GET("regions", api.Regions)
		v1.GET("regions/:regionID", api.RegionById)

		// Auth-guarded
		v1.GET("hello", authMiddleware, hello)
		v1.GET("admin", authMiddleware, adminMiddleware, admin)
	}

	router.Use(lapi.ApiFallback())


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
