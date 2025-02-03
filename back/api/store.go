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

	for i := range stores {
		region, err := a.Db.Region.SelectById(stores[i].RegionID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"message": "Failed to fetch region",
			})
			return
		}

		parentCount, err := a.Db.Region.CountParents(region.Id)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{
				"message": "Failed to count parents",
			})
			return
		}

		region.ParentCount = uint(parentCount)
		stores[i].Region = region
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
