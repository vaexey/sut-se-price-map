package auth

import (
	"back/config"
	"back/db"
	"fmt"
	"net/http"
	"strings"

	jwt "github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

var secret = config.Config.Server.Secret

type Handler struct {
	Db *db.Database
}

func (h *Handler) RequireJWT() gin.HandlerFunc {
	return func(c *gin.Context) {

		tokenHeader := c.GetHeader("Authorization")

		if tokenHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": "Authorization header does not exists",
			})
			c.Abort()
			return
		}

		authHeaderParts := strings.Split(tokenHeader, " ")

		if len(authHeaderParts) != 2 {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": "Header contains an invalid number of segments",
			})
			c.Abort()
			return
		}

		authorizationType := authHeaderParts[0]
		tokenString := authHeaderParts[1]

		if authorizationType != "Bearer" {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": "Wrong type of authorization",
			})
			c.Abort()
			return
		}

		token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
			if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
				return nil, http.ErrAbortHandler
			}
			return []byte(secret), nil
		})

		if err != nil || !token.Valid {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": fmt.Sprintf("%s", err),
			})
			c.Abort()
			return
		}

		if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
			c.Set("claims", claims)
		} else {
			c.JSON(http.StatusUnauthorized, gin.H{
				"message": "Bad claims",
			})
			c.Abort()
			return
		}

		c.Next()
	}
}

func (h *Handler) RequireAdmin() gin.HandlerFunc {

	return func(c *gin.Context) {
		if !CtxIsAdmin(c) {
			c.JSON(http.StatusForbidden, gin.H{
				"message": "Admin access only",
			})
			c.Abort()
			return
		}
		c.Next()
	}

}

