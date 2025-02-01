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

	// count number of parents
	for i := 0; i < len(regions); i++ {
		parentsNumber, err := a.Db.Region.CountParents(regions[i].Id)
		if	err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"error": "Failed to count parents",
			})
			return
		}
		regions[i].ParentsNumber = uint(parentsNumber)
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

	// count number of parents
	parentsNumber, err := a.Db.Region.CountParents(region.Id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Failed to count parents",
		})
		return
	}
	region.ParentsNumber = uint(parentsNumber)

	c.JSON(http.StatusOK, region)
}