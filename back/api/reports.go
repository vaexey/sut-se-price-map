package api

import (
	"back/model"
	"net/http"

	"github.com/gin-gonic/gin"
)

func (a *Api) Reports(c *gin.Context) {
	var reports []model.Report
	var err error
	reports, err = a.Db.Report.SelectAll()
	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
	}

	c.JSON(http.StatusOK, reports)
}