package api

import (
	"back/db"
	"back/model"
	"errors"
	"fmt"
	"math"
	"net/http"
	"slices"
	"sort"
	"strconv"
	"strings"
	"time"

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
const FILTERS_LEN = 5
const DATE_PATTERN = time.RFC3339
func (a *Api) ContribsGet(c *gin.Context) {
	var entries []model.Contrib
	filters := make([]db.Filter, FILTERS_LEN)
	afterMany := uint(0)
	limit := uint(10)

	// timespans

	var endDate int64
	var startDate int64

	timespanBefore := c.Query("timespanBefore")
	timespanAfter := c.Query("timespanAfter")
	if timespanBefore == "" {
		endDate = time.Date(3000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(DATE_PATTERN, timespanBefore)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H {
				"message": "Invalid date format",
			})
			return
		}
		endDate = t.UnixMilli()
	}

	if timespanAfter == "" {
		startDate = time.Date(1000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(DATE_PATTERN, timespanAfter)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H {
				"message": "Invalid date format",
			})
			return
		}
		startDate = t.UnixMilli()
	}

	// pagination params

	getUintParam(&afterMany, c.Query, "afterMany")
	getUintParam(&limit, c.Query, "limit")
	if limit < 1 {
		limit = 10
	}

	// sortBy param

	sortBy := c.Query("sortBy")
	if sortBy != "id" && sortBy != "date" && sortBy != "price" && sortBy != "status" {
		sortBy = ""
	}

	status := []string{"ACTIVE", "REVOKED", "REMOVED"}
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

	// filter params

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

	// fetch from db applying filters

	entries, err = a.Db.Contrib.SelectWithFilters(filters)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H {
			"message": "Invalid values in paramateres",
		})
		return
	}

	// apply timespan filters

	timespanTest := func(c model.Contrib) bool { 
		t, _ := time.Parse(DATE_PATTERN, c.Date)
		mili := t.UnixMilli()
		return mili < endDate && mili > startDate
	}

	entries = filter(entries, timespanTest)

	// apply status filters
	statusTest := func(c model.Contrib) bool {
		return slices.Contains(status, c.Status)
	}

	entries = filter(entries, statusTest)


	// apply pagination

	page := paginate(entries, afterMany, limit)
	total := len(entries)
	returned := len(page)
	pages := uint(math.Ceil(float64(total)/float64(limit)))

	// sortBy key, supports: id, date, price, status

	// TODO: refactor to sort by dynamic field
	sort.Slice(page, func(i int, j int) bool {
		var con bool
		switch sortBy {
		case "id":
			con = page[i].Id < page[j].Id
		case "date":
			t1, _:= time.Parse(DATE_PATTERN, page[i].Date)
			t2, _:= time.Parse(DATE_PATTERN, page[j].Date)
			fmt.Println(t1)
			fmt.Println(t2)
			con = t1.UnixMilli() < t2.UnixMilli()
		case "price":
			con = page[i].Price < page[j].Price
		case "status":
			con = page[i].Status < page[j].Status
		default:
		}
		return con
	})


	c.JSON(http.StatusOK, gin.H {
		"total": total,
		"returned": returned,
		"pages": pages,
		"entries": page,
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




