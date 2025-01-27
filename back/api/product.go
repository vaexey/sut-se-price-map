package api

import (
	"back/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (a *Api) Products(c *gin.Context) {
	var products []model.Product
	var err error
	products, err = a.Db.Product.SelectAll()
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H {
			"message": "Service failure",
		})
		return
	}

	c.JSON(http.StatusOK, products)
}