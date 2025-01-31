package api

import (
	"back/db"
	"back/model"
	"errors"
	"fmt"
	"net/http"
	"sort"
	"strconv"
	"strings"
	"time"

	"github.com/gin-gonic/gin"
)

func ApiFallback() gin.HandlerFunc {
	return func(c *gin.Context) {
		if strings.HasPrefix(c.Request.URL.String(), "/api") {
			c.JSON(http.StatusNotFound, gin.H {"message": "Requested resource not found"})
			c.Abort()
		}
	}
}

func paginate[T any](arr []T, skip uint, limit uint) []T {
	arrLen := uint(len(arr))
	if skip > arrLen {
		return make([]T, 0)
	}
	if skip + limit > arrLen {
		return arr[skip:arrLen]
	}
	return arr[skip:skip+limit]
}

func filter[T any](ss []T, test func(T) bool) (ret []T) {
    for _, s := range ss {
        if test(s) {
            ret = append(ret, s)
        }
    }
    return
}

type contribUtil struct {}

func (c *contribUtil) getFilterParam(query func(string) string, prefix string) (db.Filter, error) {
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

func (c *contribUtil) getUintParam(def *uint, f func(string) string, param string) {
	str := f(param)
	if str != "" {
		num, err := strconv.ParseUint(str, 10, 0)
		if err == nil {
			*def = uint(num)
		}
	}
}
func (c *contribUtil) GetPaginationParams(q func(string) string) (uint, uint) {
	afterMany := uint(0)
	limit := uint(10)

	c.getUintParam(&afterMany, q, "afterMany")
	c.getUintParam(&limit, q, "limit")
	if limit < 1 {
		limit = 10
	}
	return afterMany, limit
}


func (c *contribUtil) GetFilters(filters *[]db.Filter, q func(string) string) error {
	idFilter, err := c.getFilterParam(q, "id")
	authorsFilter, err := c.getFilterParam(q, "authors")
	storesFilter, err := c.getFilterParam(q, "stores")
	productsFilter, err := c.getFilterParam(q, "products")
	regionsFilter, err := c.getFilterParam(q, "regions")
	(*filters)[0] = idFilter
	(*filters)[1] = authorsFilter 
	(*filters)[2] = storesFilter
	(*filters)[3] = productsFilter
	(*filters)[4] = regionsFilter
	return err
}

func (c* contribUtil) GetSortStatusParams(q func(string) string) (string, []string, error) {
	sortBy := q("sortBy")
	if sortBy != "id" && sortBy != "date" && sortBy != "price" && sortBy != "status" {
		sortBy = ""
	}

	status := []string{"ACTIVE", "REVOKED", "REMOVED"}
	statuses := q("status")
	if statuses != "" {
		status = strings.Split(statuses, ",")
		for _, s := range status {
			if s != "ACTIVE" && s != "REVOKED" && s != "REMOVED" {
				return "", []string{}, errors.New("Invalid status value")
			}
		}
	}
	return sortBy, status, nil

}

func (c* contribUtil) GetTimespanFilters(q func(string) string) (int64, int64, error) {
	var endDate int64
	var startDate int64
	timespanBefore := q("timespanBefore")
	timespanAfter := q("timespanAfter")
	if timespanBefore == "" {
		endDate = time.Date(3000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(DATE_PATTERN, timespanBefore)
		if err != nil {
			return 0, 0, err
		}
		endDate = t.UnixMilli()
	}

	if timespanAfter == "" {
		startDate = time.Date(1000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(DATE_PATTERN, timespanAfter)
		if err != nil {
			return 0, 0, err
		}
		startDate = t.UnixMilli()
	}

	return startDate, endDate, nil
}

// TODO: refactor to sort by dynamic field
func (c* contribUtil) Sort(entries *[]model.Contrib, key string) {
	sort.Slice(*entries, func(i int, j int) bool {
		var con bool
		switch key {
		case "id":
			con = (*entries)[i].Id < (*entries)[j].Id
		case "date":
			t1, _:= time.Parse(DATE_PATTERN, (*entries)[i].Date)
			t2, _:= time.Parse(DATE_PATTERN, (*entries)[j].Date)
			con = t1.UnixMilli() < t2.UnixMilli()
		case "price":
			con = (*entries)[i].Price < (*entries)[j].Price
		case "status":
			con = (*entries)[i].Status < (*entries)[j].Status
		default:
		}
		return con
	})
}
