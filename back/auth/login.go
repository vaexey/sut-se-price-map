package auth

import (
	"errors"
	"fmt"
	"net/http"
	"time"
	jwt "github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

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


	fmt.Println(user)

	if !h.CompareHash(req.Password, user.Password) || user.Login != req.Username {
		c.JSON(http.StatusUnauthorized, gin.H {
			"message": "invalid credentials",
		})
		return
	}

	var role string = "user"
	if user.IsAdmin {
		role = "admin"
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



