package api

import (
	"back/model"
	"errors"
	"net/http"
	"strconv"

	"gorm.io/gorm"

	"github.com/gin-gonic/gin"
)

func (a *Api) Regions(c *gin.Context) {
	var regions []model.Region
	var err error
	regions, err = a.Db.Region.SelectAll()
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	c.JSON(http.StatusOK, regions)
}

func (a *Api) RegionById(c *gin.Context) {
	regionIDasStr := c.Param("regionID")
	if regionIDasStr == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Region ID is required",
		})
		return
	}

	regionID, err := strconv.Atoi(regionIDasStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid region id type",
		})
		return
	}

	region, err := a.Db.Region.SelectById(uint(regionID))
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "No matching region for provided id",
		})
		return
	} else if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	c.JSON(http.StatusOK, region)
}
