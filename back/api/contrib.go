package api

import (
	"back/db"
	"back/model"
	"errors"
	"fmt"
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
	// check id in db

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

func getFilterParam(query func(string) string, prefix string) (db.Filter, error) {
	includeParam := query(fmt.Sprintf("%sInclude", prefix))
	excludeParam := query(fmt.Sprintf("%sExclude", prefix))
	var include *[]uint
	var exclude *[]uint
	include = nil
	exclude = nil

	if includeParam != "" {
		values := strings.Split(includeParam, ",")
		if len(values) > 0 {
			include = new([]uint)
			for _, val := range values {
				id, err := strconv.ParseUint(val, 10, 0)
				if err != nil {
					return db.NewFilter(include, exclude, prefix),  err
				}
				*include = append(*include, uint(id))
			}
		}
	}

	if excludeParam != "" {
		values := strings.Split(excludeParam, ",")
		if len(values) > 0 {
			exclude = new([]uint)
			for _, val := range values {
				id, err := strconv.ParseUint(val, 10, 0)
				if err != nil {
					return db.NewFilter(include, exclude, prefix), err
				}
				*exclude = append(*exclude, uint(id))
			}
		}
	}

	return db.NewFilter(include, exclude, prefix), nil
}


// contribs
// returns all contribs matching criteria
// pagination
const FILTERS_LEN = 5
func (a *Api) ContribsGet(c *gin.Context) {
	filters := make([]db.Filter, FILTERS_LEN)
	total := 0
	returned := 0
	pages := 0

	var entries []model.Contrib
	// for 4 other filters do the same
	idFilter, err := getFilterParam(c.Query, "id")
	authorFilter, err := getFilterParam(c.Query, "author")
	filters[0] = idFilter
	filters[1] = authorFilter 

	a.Db.Contrib.SelectWithFilters(filters)
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




