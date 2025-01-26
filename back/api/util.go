package api

import (
	"net/http"
	"strings"
	"github.com/gin-gonic/gin"
)

func ApiFallback() gin.HandlerFunc {
	return func(c *gin.Context) {
		if strings.HasPrefix(c.Request.URL.String(), "/api") {
			c.JSON(http.StatusNotFound, gin.H {"message": "Requested resource not found"})
			c.Abort()
		}
	}
}
