package api

import (
	"back/db"
	model "back/model/db"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)

func Regions(c *gin.Context, dbHandler *db.DbHandler){
	var regions []model.Region
	var err error
	regions, err = dbHandler.Region.SelectAll()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "Failed to fetch regions",
			"message": err.Error(),
		})
		c.Abort()
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"regions": regions,
	})
	c.Abort()
}


func RegionById(c *gin.Context, dbHandler *db.DbHandler) {
	regionIDasStr := c.Param("regionID")
	if regionIDasStr == "" {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "Bad request",
			"message": "Region ID is required",
		})
		c.Abort()
		return
	}

	regionID, err := strconv.Atoi(regionIDasStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   "Invalid region ID",
			"message": err.Error(),
		})
		c.Abort()
		return
	}

	region, err := dbHandler.Region.SelectById(uint(regionID))
	fmt.Println(err)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "Failed to fetch region",
			"message": err.Error(),
		})
		c.Abort()
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"region": region,
	})
	c.Abort()
}