package api

import (
	"back/model"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

func (a *Api) Stores(c *gin.Context) {
	var stores []model.Store
	var err error

	regionsInclude := c.Query("regionsInclude")
	regionsExclude := c.Query("regionsExclude")

	includeRegions := parseRegionParams(regionsInclude)
	excludeRegions := parseRegionParams(regionsExclude)

	stores, err = a.Db.Store.SelectAllWithFilters(includeRegions, excludeRegions)
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	// Preload the associated Region for each Store and its nested Parent regions
	err = a.Db.Db.Preload("Region.Parent.Parent.Parent").Find(&stores).Error
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Failed to fetch regions",
		})
		return
	}

	// Calculate parentCount for each region and its parents
	for i := range stores {
		if stores[i].RegionID != 0 {
			err := a.Db.Region.CalculateParentCounts(&stores[i].Region)
			if err != nil {
				c.JSON(http.StatusServiceUnavailable, gin.H{
					"message": "Failed to calculate parent counts",
				})
				return
			}
		}
	}

	c.JSON(http.StatusOK, stores)
}

func parseRegionParams(params string) []uint {
	if params == "" {
		return nil
	}
	parts := strings.Split(params, ",")
	var result []uint
	for _, part := range parts {
		id, err := strconv.Atoi(part)
		if err != nil {
			return nil
		}
		result = append(result, uint(id))
	}
	return result
}
