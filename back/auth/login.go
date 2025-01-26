package auth

import (
	"errors"
	"net/http"
	"time"

	jwt "github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

type loginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func (h *Handler) Login(c *gin.Context) {
	var req loginRequest
	c.BindJSON(&req)
	if req.Username == "" || req.Password == "" {
		c.JSON(http.StatusUnauthorized, gin.H {
			"message" : "invalid credentials",
		})
		return
	}

	// query user from db
	user, err  := h.Db.User.SelectByUsername(req.Username)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusUnauthorized, gin.H {
			"message" : "invalid credentials",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "service failure",
		})
		return
	}

	var role string = "user"

	// if username == "admin" && password == "password" {
	// 	role = "admin"
	// } else if username == "user" && password == "password" {
	// 	role = "user"
	// } else {
	// 	c.JSON(http.StatusUnauthorized, gin.H{
	// 		"error": "Invalid credentials",
	// 	})
	// 	return
	// }
	


	if !h.CompareHash(req.Password, user.Password) || user.DisplayName != req.Username {
		c.JSON(http.StatusUnauthorized, gin.H {
			"message": "invalid credentials",
		})
		return
	}


	// token object
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"username": req.Username,
		"role":     role,
		"exp":      time.Now().Add(time.Hour * 1).Unix(),
	})

	// sign and get encoded token as str
	tokenString, err := token.SignedString([]byte(secret))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"message": "failed to generate token"})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"token" : tokenString,
	})
}

func (h *Handler) Register(c *gin.Context) {

}
