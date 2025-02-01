package auth

import (
	"regexp"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
	"golang.org/x/crypto/bcrypt"
)

type loginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}


type registerRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
	DisplayName string `json:"displayName"`
}

func (h *Handler) HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}

func (h* Handler) CompareHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func isUsernameValid(name string) bool {
	_, err := regexp.MatchString("^[a-zA-Z\\d_]+$", name)
	return err == nil
}


func CtxIsAdmin(c *gin.Context) bool {
	claims := c.MustGet("claims").(jwt.MapClaims)
	role := claims["role"].(string)

	if role == "admin" {
		return true
	}
	return false
}

func CtxId(c *gin.Context) *uint {
	claims := c.MustGet("claims").(jwt.MapClaims)
	id := uint(claims["id"].(float64))
	return &id
}




