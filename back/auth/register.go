package auth

import (
	"back/model"
	"errors"
	"fmt"
	"net/http"
	"regexp"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func (h *Handler) Register(c *gin.Context) {
	// parse request
	var req registerRequest
	c.BindJSON(&req)
	if req.Username == "" || req.Password == "" {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : "no username or password provided",
		})
		c.Abort()
		return
	}

	if !isUsernameValid(req.Username) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "username contains illegal characters",
		})
	}

	hash, err := h.HashPassword(req.Password)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : "bad password",
		})
		c.Abort()
		return
	}
	// default displayName
	if req.DisplayName == "" {
		req.DisplayName = req.Username
	}

	newUser := model.User {
		DisplayName: req.DisplayName,
		Login : req.Username,
		Password : hash,
		IsAdmin: false,
		Avatar: nil,
	}

	// check if username with same username exists in db
	var dbUser model.User
	dbUser.Login = req.Username
	dbUser, err = h.Db.User.SelectByUsername(req.Username)
	if !errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : "username taken",
		})
		c.Abort()
		return
	}

	// insert user
	id, err := h.Db.User.CreateUser(newUser)
	if err != nil {
		fmt.Fprintf(gin.DefaultErrorWriter, "Failed to insert user at /register, err: %s\n", err.Error())
		c.JSON(http.StatusServiceUnavailable, gin.H {
			"message" : "service failure",
		})
		c.Abort()
		return
	}
	// response ok
	fmt.Fprintf(gin.DefaultWriter, "User with id [%d] inserted successfully\n", id)
	c.JSON(http.StatusOK, gin.H {
		"message" : "success",
	})
}


func isUsernameValid(name string) bool {
	_, err := regexp.MatchString("^[a-zA-Z\\d_]+$", name)
	return err == nil
}



