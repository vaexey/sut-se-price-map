package auth

import (
	"errors"
	"net/http"
	"time"

	jwt "github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)
func (h *Handler)login(username string, password string) (int, gin.H, *string) {

	if username == "" || password == "" {
		return http.StatusUnauthorized, gin.H { "message" : "Invalid credentials"}, nil
	}
	// query user from db
	dbUser, err  := h.Db.User.SelectByUsername(username)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		return http.StatusUnauthorized, gin.H { "message" : "Invalid credentials"}, nil
	}

	if err != nil {
		return http.StatusServiceUnavailable, gin.H { "message" : "Service failure"}, nil
	}

	if !h.CompareHash(password, dbUser.Password) || dbUser.Login != username {
		return http.StatusUnauthorized, gin.H { "message" : "Invalid credentials"}, nil
	}

	var role string = "user"
	if dbUser.IsAdmin {
		role = "admin"
	}


	// token object
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"username": username,
		"id" : dbUser.Id,
		"role":     role,
		"exp":      time.Now().Add(time.Hour * 1).Unix(),
	})

	// sign and get encoded token as str
	tokenString, err := token.SignedString([]byte(secret))
	if err != nil {
		return http.StatusServiceUnavailable, gin.H { "message" : "Service failure"}, nil
	}
	return http.StatusOK, gin.H { "message" : "success" , "id": dbUser.Id, "role": role}, &tokenString
}

func (h *Handler) Login(c *gin.Context) {
	var req loginRequest
	err := c.BindJSON(&req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : err.Error(),
		})
		return
	}
	code, json, tokenString := h.login(req.Username, req.Password)
	if tokenString == nil {
		c.JSON(code, json)
		return
	}
	isAdmin := false
	if json["role"] == "admin" {
		isAdmin = true
	}

	c.JSON(http.StatusOK, gin.H{
		"token" : *tokenString,
		"id": json["id"],
		"isAdmin" : isAdmin, 
	})
}



