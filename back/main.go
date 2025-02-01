package main

import (
	lapi "back/api"
	"back/auth"
	"back/config"
	ldb "back/db"
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
	conf := config.Config

	// TODO: make configurable (through env)
	// --> gin.SetMode(gin.ReleaseMode)
	router := gin.New()

	logger := gin.Logger()
	recovery := gin.Recovery()
	router.Use(logger, recovery)

	dsn := fmt.Sprintf(
		"host=%s port=%d user=%s password=%s dbname=%s",
		conf.Database.Host,
		conf.Database.Port,
		conf.Database.Username,
		conf.Database.Password,
		conf.Database.Database,
	)

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})

	if err != nil {
		panic(err)
	}

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
		v1.GET("/products", api.Products)
		v1.GET("/stores", api.Stores)
		//v1.GET("/reports", api.Reports)

		// contribs

		v1.GET("contribs/:contribId", api.ContribsGetById)
		v1.GET("contribs", api.ContribsGetAll)
		v1.GET("contribs/group", api.ContribsGetByGroup)

		v1.POST("contribs/:contribId", authMiddleware, api.ContribsUpdate)
		v1.PUT("contribs", authMiddleware, api.ContribsCreate)

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

	addr := fmt.Sprintf("%s:%d", conf.Server.Address, conf.Server.Port)
	panic(router.Run(addr))
}
