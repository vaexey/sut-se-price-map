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

	if len(reports) == 0 {
		c.JSON(http.StatusOK, []model.Report{})
	}

	c.JSON(http.StatusOK, reports)
}

func (a *Api) CreateReports(c *gin.Context) {
	var report model.Report
	
	if err := c.ShouldBindJSON(&report); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "Invalid request",
		})
		return
	}

	err := a.Db.Report.Create(report)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"message": "Failed to create report",
		})
		return
	}

	c.JSON(http.StatusOK, report)
}