package api

import (
	"back/db"
	"back/model"
	"errors"
	"math"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

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
// TODO: inclusive regions
const FILTERS_LEN = 5
const DATE_PATTERN = time.RFC3339
func (a *Api) ContribsGet(c *gin.Context) {
	util := contribUtil {}

	filters := make([]db.Filter, FILTERS_LEN)
	var entries []model.Contrib

	// pagination params
	util.GetPaginationParams(c.Query)

	// timespans
	err := util.GetTimespanFilters(c.Query)

	// sortBy param
	err = util.GetSortStatusParams(c.Query)


	// filter params
	err = util.GetFilters(&filters, c.Query)


	// fetch from db applying filters
	entries, err = a.Db.Contrib.SelectWithFilters(filters)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H {
			"message": "Invalid values in paramateres",
			"details": err.Error(),
		})
		return
	}

	total := len(entries)

	util.ReadyResponse(&entries)

	returned := len(entries)
	pages := uint(math.Ceil(float64(total)/float64(util.Limit)))


	c.JSON(http.StatusOK, gin.H {
		"total": total,
		"returned": returned,
		"pages": pages,
		"entries": entries,
	})
}

// contribs/group
// returns group of contribution based on filters provided in url params
// pagination
func (a *Api) ContribsGroup(c *gin.Context) {
	util := contribUtil{}

	filters := make([]db.Filter, FILTERS_LEN)
	var entries []model.Contrib

	// pagination params
	util.GetPaginationParams(c.Query)

	// timespans
	err := util.GetTimespanFilters(c.Query)

	// sortBy param
	err = util.GetSortStatusParams(c.Query)


	// filter params
	err = util.GetFilters(&filters, c.Query)

	entries, err = a.Db.Contrib.SelectWithFilters(filters)
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H {
			"message": "Invalid values in paramateres",
			"details": err.Error(),
		})
		return
	}

	total := len(entries)

	util.ReadyResponse(&entries)

	returned := len(entries)
	pages := uint(math.Ceil(float64(total)/float64(util.Limit)))

	groups := util.Group(&entries)




	c.JSON(http.StatusOK, gin.H {
		"total": total,
		"returned": returned,
		"pages": pages,
		"entries": groups,
	})
}

// contribs
// creates new contribution
// authorized user = author
// status only changeable by admin
func (a *Api) ContribsPut(c *gin.Context) {

}


// contribs/{contribId}
// updates contribution
func (a *Api) ContribsByIdPost(c *gin.Context) {

}




