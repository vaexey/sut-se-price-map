package api

import (
	"back/model"
	"net/http"
	"strconv"

	"gorm.io/gorm"

	"github.com/gin-gonic/gin"
)

type RegionResponse struct {
	ID          uint   `json:"id"`
	Name        string `json:"name"`
	Parent      string `json:"parent"`
	ParentCount uint   `json:"parentCount"`
}

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

	var regionResponses []RegionResponse
	for _, region := range regions {
		regionResponse, err := a.TransformRegion(region)
		if err != nil {
			c.JSON(http.StatusServiceUnavailable, gin.H{
				"error": "Failed to transform region",
			})
			return
		}
		regionResponses = append(regionResponses, regionResponse)
	}

	c.JSON(http.StatusOK, regionResponses)
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
	if err == gorm.ErrRecordNotFound {
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

	//log.Printf("parentcount %d", parentsNumber)
	regionResponse, err := a.TransformRegion(region)
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"error": "Failed to transform region",
		})
		return
	}

	c.JSON(http.StatusOK, regionResponse)
}

func (a *Api) TransformRegion(region model.Region) (RegionResponse, error) {
	parentsNumber, err := a.Db.Region.CountParents(region.Id)
	if err != nil {
		return RegionResponse{}, err
	}

	var parentName string
	if region.ParentID != nil {
		parentRegion, err := a.Db.Region.SelectById(*region.ParentID)
		if err != nil {
			return RegionResponse{}, err
		}
		parentName = parentRegion.Name
	}

	return RegionResponse{
		ID:          region.Id,
		Name:        region.Name,
		Parent:      parentName,
		ParentCount: uint(parentsNumber),
	}, nil
}
