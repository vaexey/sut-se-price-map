package api

import (
	"back/auth"
	"back/db"
	"back/model"
	lutil "back/util"
	"errors"
	"fmt"
	"math"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// contribs/{contribId}
// returns contribution
func (a *Api) ContribsGetById(c *gin.Context) {
	contribId := c.Param("contribId")
	id, err := strconv.ParseUint(contribId, 10, 0)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid contribution id",
		})
		return
	}

	contrib, err := a.Db.Contrib.SelectById(uint(id))
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "There is no contribution with this id",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
			"details": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, contrib)
}

// contribs
// TODO: inclusive regions
const FILTERS_LEN = 5

func (a *Api) ContribsGetAll(c *gin.Context) {
	util := contribUtil{}
	util.SelectChildren = a.Db.Region.SelectChildren

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
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid values in paramateres",
			"details": err.Error(),
		})
		return
	}

	util.ReadyResponse(&entries)

	page := []model.Contrib{}
	page = lutil.Paginate(entries, util.AfterMany, util.Limit)

	total := len(entries)
	returned := len(page)

	pages := uint(math.Ceil(float64(total) / float64(util.Limit)))

	if page == nil || len(page) < 1 {
		page = make([]model.Contrib, 0)
	}

	c.JSON(http.StatusOK, gin.H{
		"total":    total,
		"returned": returned,
		"pages":    pages,
		"entries":  page,
	})
}

// contribs/group
// returns group of contribution based on filters provided in url params
// pagination
func (a *Api) ContribsGetByGroup(c *gin.Context) {
	util := contribUtil{}
	util.SelectChildren = a.Db.Region.SelectChildren

	filters := make([]db.Filter, FILTERS_LEN)
	entries := []model.Contrib{}

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
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid values in paramateres",
			"details": err.Error(),
		})
		return
	}

	util.ReadyResponse(&entries)
	groups := util.Group(&entries)

	page := []model.ContribGroup{}
	page = lutil.Paginate(groups, util.AfterMany, util.Limit)

	total := len(groups)
	returned := len(page)

	if page == nil || len(page) < 1 {
		page = make([]model.ContribGroup, 0)
	}

	pages := uint(math.Ceil(float64(total) / float64(util.Limit)))

	c.JSON(http.StatusOK, gin.H{
		"total":    total,
		"returned": returned,
		"pages":    pages,
		"entries":  page,
	})
}

// contribs
// creates new contribution
// authorized user = author
// status only changeable by admin
func (a *Api) ContribsCreate(c *gin.Context) {
	var req contribRequest
	err := c.BindJSON(&req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	// check user stuff
	isAdmin := auth.CtxIsAdmin(c)
	userId := auth.CtxId(c)
	if userId == nil {
		c.JSON(http.StatusOK, gin.H{
			"message": "Failed to identify user",
		})
		return
	}

	status := "ACTIVE"
	if req.Status == "REVOKED" || req.Status == "REMOVED" && isAdmin {
		status = req.Status
	}

	contrib := model.Contrib{
		ProductID: req.Product,
		StoreID:   req.Store,
		AuthorID:  *userId,
		Price:     req.Price,
		Comment:   req.Comment,
		Date:      lutil.TimeNow(),
		Status:    status,
	}

	// insert to db
	id, err := a.Db.Contrib.Create(contrib)
	if err != nil {
		fmt.Fprintf(gin.DefaultErrorWriter, "Failed to insert contrib at /contribs, err: %s\n", err.Error())
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	contrib, err = a.Db.Contrib.SelectById(id)
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "There is no contribution with this id",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
			"details": err.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, contrib)
}

// contribs/{contribId}
// updates contribution
func (a *Api) ContribsUpdate(c *gin.Context) {
	contribId := c.Param("contribId")
	id, err := strconv.ParseUint(contribId, 10, 0)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid contribution id",
		})
		return
	}

	var req contribRequest
	err = c.BindJSON(&req)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": err.Error(),
		})
		return
	}

	userId := auth.CtxId(c)
	if userId == nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "Failed to identify user",
		})
		return
	}
	isAdmin := auth.CtxIsAdmin(c)

	// select by id, then change the obj values, then update
	dbContrib, err := a.Db.Contrib.SelectById(uint(id))
	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusNotFound, gin.H{
			"message": "There is no contribution with this id",
		})
		return
	} else if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
			"details": err.Error(),
		})
		return
	}

	// check all restricitons
	status := dbContrib.Status

	if isAdmin {
		status = req.Status
	} else if dbContrib.Status == "ACTIVE" && req.Status == "REVOKED" {
		status = req.Status
	}

	if !isAdmin && dbContrib.AuthorID != *userId {
		c.JSON(http.StatusUnauthorized, gin.H{
			"message": "Failed to identify user",
		})
		return
	}

	dbContrib.Status = status
	dbContrib.Comment = req.Comment
	dbContrib.Price = req.Price

	err = a.Db.Contrib.Update(dbContrib)
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Failed to update contribution",
			"details": err.Error(),
		})
		return
	}
	c.JSON(http.StatusOK, dbContrib)

}
