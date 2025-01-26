package api

import (
	"back/db"
	"back/model"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)
func NewApi(db db.DbHandler) Api {
	return Api {
		Regions: Regions,
		RegionById: RegionById,
	}
}

type Api struct {
	Db db.DbHandler
	Regions func(c *gin.Context, db *db.DbHandler)
	RegionById func(c *gin.Context, db *db.DbHandler)
}

func Regions(c *gin.Context, dbHandler *db.DbHandler) {
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

	////
	for i := 0; i < len(regions); i++ {
		length := len(regions[i].Name)
		if length % 2 == 0 {
			regions[i].ParentsNumber = 1
		} else {
			regions[i].ParentsNumber = 2
		}
	}
	////

	c.JSON(http.StatusOK, regions)
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
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error":   "Failed to fetch region",
			"message": err.Error(),
		})
		c.Abort()
		return
	}

	////
	length := len(region.Name)
	if length % 2 == 0 {
		region.ParentsNumber = 1
	} else {
		region.ParentsNumber = 2
	}
	////

	c.JSON(http.StatusOK, region)
	c.Abort()
}

