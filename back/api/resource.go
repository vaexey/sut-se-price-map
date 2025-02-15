package api

import (
	"errors"
	"net/http"
	"strconv"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func (a *Api) ResourceById(c *gin.Context) {
	resId := c.Param("id")
	id, err := strconv.ParseUint(resId, 10, 0)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid id",
		})
		return
	}

	resource, err := a.Db.Resource.SelectById(uint(id))
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "There is no resource with this id",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	c.Header("Content-Type", "image/png")
	c.String(http.StatusOK, resource.Blob)
}


