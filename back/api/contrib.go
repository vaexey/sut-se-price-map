package api

import (
	"back/db"
	"back/model"
	"errors"
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// contribs/{contribId}
// updates contribution
func (a *Api) ContribsByIdPost(c *gin.Context) {

}

// contribs/{contribId}
// returns contribution
func (a *Api) ContribsByIdGet(c *gin.Context) {
	contribId := c.Param("contribId")
	id, err := strconv.ParseUint(contribId, 10, 0)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : "Invalid contribution id",
		})
		return
	}

	contrib, err := a.Db.Contrib.SelectById(uint(id))
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H {
			"message" : "There is no contribution with this id",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H {
			"message" : "Service failure",
			"dbg": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, contrib)
}


// contribs
// TODO: regions
// TODO: timespan filter
// TODO: apply sort, status, pagination
const FILTERS_LEN = 5
func (a *Api) ContribsGet(c *gin.Context) {
	var entries []model.Contrib
	filters := make([]db.Filter, FILTERS_LEN)
	total := 0
	returned := 0
	pages := 0
	afterMany := uint(0)
	limit := uint(10)
	// timespanBefore
	// timespanAfter
	getUintParam(&afterMany, c.Query, "afterMany")
	getUintParam(&limit, c.Query, "limit")

	sortBy := c.Query("sortBy")
	if sortBy != "id" && sortBy != "date" && sortBy != "price" && sortBy != "status" {
		sortBy = ""
	}

	status := make([]string, 3)
	statuses := c.Query("status")
	if statuses != "" {
		status = strings.Split(statuses, ",")
		for _, s := range status {
			if s != "ACTIVE" && s != "REVOKED" && s != "REMOVED" {
				c.JSON(http.StatusBadRequest, gin.H {
					"message": "Invalid status value",
				})
				return
			}
		}
	}


	idFilter, err := getFilterParam(c.Query, "id")
	authorsFilter, err := getFilterParam(c.Query, "authors")
	storesFilter, err := getFilterParam(c.Query, "stores")
	productsFilter, err := getFilterParam(c.Query, "products")
	// regionsFilter, err := getFilterParam(c.Query, "regions")
	filters[0] = idFilter
	filters[1] = authorsFilter 
	filters[2] = storesFilter
	filters[3] = productsFilter
	// filters[4] = regionsFilter

	entries, err = a.Db.Contrib.SelectWithFilters(filters)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H {
			"message": "Invalid values in paramateres",
		})
		return
	}


	c.JSON(http.StatusOK, gin.H {
		"total": total,
		"returned": returned,
		"pages": pages,
		"entries": entries,
	})
}

// contribs
// creates new contribution
// authorized user = author
// status only changeable by admin
func (a *Api) ContribsPut(c *gin.Context) {

}


// contribs/group
// returns group of contribution based on filters provided in url params
// pagination
func (a *Api) ContribsGroup(c *gin.Context) {

}




