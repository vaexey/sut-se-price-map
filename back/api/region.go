package api

import (
	"back/model"
	"net/http"
	"strconv"
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

	//dev
	for i := 0; i < len(regions); i++ {
		length := len(regions[i].Name)
		if length % 2 == 0 {
			regions[i].ParentsNumber = 1
		} else {
			regions[i].ParentsNumber = 2
		}
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
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "No matching region for provided id",
		})
		return
	}

	//dev
	length := len(region.Name)
	if length % 2 == 0 {
		region.ParentsNumber = 1
	} else {
		region.ParentsNumber = 2
	}

	c.JSON(http.StatusOK, region)
}

