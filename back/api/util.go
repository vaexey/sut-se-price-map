package api

import (
	"back/db"
	"fmt"
	"net/http"
	"strconv"
	"strings"

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

func getUintParam(def *uint, f func(string) string, param string) {
	str := f(param)
	if str != "" {
		num, err := strconv.ParseUint(str, 10, 0)
		if err == nil {
			*def = uint(num)
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

