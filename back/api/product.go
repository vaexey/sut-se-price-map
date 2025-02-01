package api

import (
	"back/model"
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func (a *Api) Products(c *gin.Context) {
	var products []model.Product
	var err error
	products, err = a.Db.Product.SelectAll()
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			c.JSON(http.StatusNotFound, gin.H {
				"message": "Record not found",
			})
			c.Abort()
			return
		}
		c.JSON(http.StatusServiceUnavailable, gin.H {
			"message": "Service failure",
		})
		return
	}

	c.JSON(http.StatusOK, products)
}