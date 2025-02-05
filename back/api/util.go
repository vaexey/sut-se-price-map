package api

import (
	"back/db"
	"back/model"
	"back/util"
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
)

type contribRequest struct {
	Product uint `json:"product"`
	Store uint `json:"store"`
	Price float32 `json:"price"`
	Comment *string `json:"comment"`
	Status string `json:"status"`
}


func ApiFallback() gin.HandlerFunc {
	return func(c *gin.Context) {
		if strings.HasPrefix(c.Request.URL.String(), "/api") {
			c.JSON(http.StatusNotFound, gin.H {"message": "Requested resource not found"})
			c.Abort()
		}
	}
}


type contribUtil struct {
	SelectChildren func(uint) ([]uint, error)
	StartDate int64
	EndDate int64
	AfterMany uint
	Limit uint
	SortBy string
	Status []string
}

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
func (c *contribUtil) GetPaginationParams(q func(string) string) {
	c.AfterMany = uint(0)
	c.Limit = uint(10)

	c.getUintParam(&c.AfterMany, q, "afterMany")
	c.getUintParam(&c.Limit, q, "limit")
	if c.Limit < 1 {
		c.Limit = 10
	}
}


func (c *contribUtil) GetFilters(filters *[]db.Filter, q func(string) string) error {
	idFilter, err := c.getFilterParam(q, "ids")
	authorsFilter, err := c.getFilterParam(q, "authors")
	storesFilter, err := c.getFilterParam(q, "stores")
	productsFilter, err := c.getFilterParam(q, "products")
	regionsFilter, err := c.getFilterParam(q, "regions")

	// recursive regions
	rIncl := regionsFilter.Include
	var allIncl []uint
	if rIncl != nil {
		for i := range *rIncl {
			children, err := c.SelectChildren((*rIncl)[i])
			if err != nil {
				return err
			}
			allIncl = append(allIncl, children...)
		}
	}

	rExcl := regionsFilter.Exclude
	var allExcl[]uint
	if rExcl != nil {
		for i := range *rExcl {
			children, err := c.SelectChildren((*rExcl)[i])
			if err != nil {
				return err
			}
			allExcl = append(allExcl, children...)
		}
	}

	regionsFilter.Include = &allIncl
	regionsFilter.Exclude = &allExcl


	(*filters)[0] = idFilter
	(*filters)[1] = authorsFilter 
	(*filters)[2] = storesFilter
	(*filters)[3] = productsFilter
	(*filters)[4] = regionsFilter
	return err
}

func (c* contribUtil) GetSortStatusParams(q func(string) string) error {
	sortBy := q("sortBy")
	if sortBy != "id" && sortBy != "date" && sortBy != "price" && sortBy != "status" {
		sortBy = ""
	}

	status := []string{"ACTIVE"}
	statuses := q("status")
	if statuses != "" {
		status = strings.Split(statuses, ",")
		for _, s := range status {
			if s != "ACTIVE" && s != "REVOKED" && s != "REMOVED" {
				return errors.New("Invalid status value")
			}
		}
	}
	c.SortBy = sortBy
	c.Status = status
	return nil

}

func (c* contribUtil) GetTimespanFilters(q func(string) string) error {
	var endDate int64
	var startDate int64
	timespanBefore := q("timespanBefore")
	timespanAfter := q("timespanAfter")
	if timespanBefore == "" {
		endDate = time.Date(3000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(util.DATE_PATTERN, timespanBefore)
		if err != nil {
			c.StartDate = startDate
			c.EndDate = endDate
			return err
		}
		endDate = t.UnixMilli()
	}

	if timespanAfter == "" {
		startDate = time.Date(1000, time.December, 1, 0, 0, 0, 0, time.UTC).UnixMilli()
	} else {
		t, err := time.Parse(util.DATE_PATTERN, timespanAfter)
		if err != nil {

			c.StartDate = startDate
			c.EndDate = endDate
			return err
		}
		startDate = t.UnixMilli()
	}

	c.StartDate = startDate
	c.EndDate = endDate

	return nil
}

// TODO: refactor to sort by dynamic field
func (c* contribUtil) sort(entries *[]model.Contrib, key string) {
	sort.Slice(*entries, func(i int, j int) bool {
		var con bool
		switch key {
		case "id":
			con = (*entries)[i].Id < (*entries)[j].Id
		case "date":
			t1, _:= time.Parse(util.DATE_PATTERN, (*entries)[i].Date)
			t2, _:= time.Parse(util.DATE_PATTERN, (*entries)[j].Date)
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

func (c *contribUtil) ReadyResponse(entries *[]model.Contrib) {
	// apply timespan filters
	timespanTest := func(con model.Contrib) bool { 
		t, _ := time.Parse(util.DATE_PATTERN, con.Date)
		mili := t.UnixMilli()
		return mili < c.EndDate && mili > c.StartDate
	}


	*entries = util.Filter(*entries, timespanTest)

	// apply status filters
	statusTest := func(con model.Contrib) bool {
		return slices.Contains(c.Status, con.Status)
	}

	*entries = util.Filter(*entries, statusTest)


	// sortBy key, supports: id, date, price, status
	c.sort(entries, c.SortBy)

}

// this groups by product, store
func (c *contribUtil) Group(entries *[]model.Contrib) []model.ContribGroup {
	grouped := make(map[string][]model.Contrib)
	for _, con := range *entries {
		key := fmt.Sprintf("%d|%d", con.ProductID, con.StoreID)
		grouped[key] = append(grouped[key], con)
	}
	var resultGroup []model.ContribGroup
	for _, value:= range grouped {
		sort.Slice(value, func(i int, j int) bool {
			t1, _:= time.Parse(util.DATE_PATTERN, value[i].Date)
			t2, _:= time.Parse(util.DATE_PATTERN, value[j].Date)
			return t1.UnixMilli() < t2.UnixMilli()
		})

		// fields specific to group
		avgPrice, rating, ids := c.fieldsFromContrib(&value)



		first := value[0]
		resultGroup = append(resultGroup, model.ContribGroup {
			Region: first.Store.Region,
			Store: first.Store,
			Product: first.Product,
			FirstAuthor: first.Author,
			Contribs: ids,
			AvgPrice: avgPrice,
			Rating: rating,
		})
	}
	return resultGroup
}


// this calculates avgPrice, rating, and returns all ids of group
func (c *contribUtil) fieldsFromContrib(contribs *[]model.Contrib) (float32, float32, []uint) {
	ids := make([]uint, len(*contribs))
	avgPrice := 0.0
	prices := make([]float32, len(*contribs))


	size := float64(len(*contribs))

	if size < 1 {
		return 0.0, 0.0, ids
	}

	sum := 0.0
	sd := 0.0
	// avgPrice & ids
	for i, entry := range *contribs {
		ids[i] = entry.Id
		prices[i] = entry.Price
		sum += float64(entry.Price)
	}

	// sd
	avgPrice = sum / size
	for _, entry := range *contribs {
		sd += math.Pow(float64(entry.Price) - avgPrice, 2)
	}
	sd = math.Sqrt(sd / size)

	// rating

	if avgPrice <= 0 {
		return 0.0, 1.0, ids
	}

	v := sd / avgPrice

	vrot := 1 - v
	rating := math.Pow(vrot, 2)



	return float32(avgPrice), float32(rating), ids
}

