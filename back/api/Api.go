package api

import (
	"back/db"
	"back/model"
	"fmt"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
)
func NewApi(db db.DbHandler) Api {
	return Api {
		Region: Region,
	}
}

type Api struct {
	Db db.DbHandler
	Region func(c *gin.Context, db db.DbHandler)
}


func regions(c *gin.Context, db db.DbHandler){
	var regions []model.Region
	var err error
	regions, err = db.Region.SelectAll()
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
}

func regionById(c *gin.Context, db db.DbHandler, id string) {
	regionIDasStr := id
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

	region, err := db.Region.SelectById(uint(regionID))
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
}

func Region(c *gin.Context, db db.DbHandler) {
	id := c.Query("id")
	fmt.Println(id)
	if id != "" {
		regionById(c, db, id)
		return
	}
	regions(c, db)
}


