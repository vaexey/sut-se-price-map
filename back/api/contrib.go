package api

import (
	// "back/model"
	// "net/http"
	"errors"
	"net/http"
	"strconv"

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
	id, err := strconv.ParseUint(contribId, 10, 64)
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

// contribs
// creates new contribution
// authorized user = author
// status only changeable by admin
func (a *Api) ContribsPut(c *gin.Context) {

}

// contribs
// returns all contribs matching criteria
// pagination
func (a *Api) ContribsGet(c *gin.Context) {

}

// contribs/group
// returns group of contribution based on filters provided in url params
// pagination
func (a *Api) ContribsGroup(c *gin.Context) {

}




