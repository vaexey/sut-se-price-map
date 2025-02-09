package api

import (
	"back/model"
	"errors"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func (a *Api) Reports(c *gin.Context) {
	timespanBefore := c.Query("timespanBefore")
	timespanAfter := c.Query("timespanAfter")

	GetTimespanFilters(&timespanBefore, &timespanAfter)

	var reports []model.Report
	var err error
	reports, err = a.Db.Report.SelectAll(timespanBefore, timespanAfter)

	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "There are no reports",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusServiceUnavailable, gin.H{
			"message": "Service failure",
		})
		return
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

func GetTimespanFilters(timespanBefore *string, timespanAfter *string) {
	const DATE_PATTERN = time.RFC3339
	if *timespanBefore == "" {
		*timespanBefore = time.Date(1000, time.December, 1, 0, 0, 0, 0, time.UTC).Format(DATE_PATTERN)
	}

	if *timespanAfter == "" {
		*timespanAfter = time.Date(3000, time.December, 1, 0, 0, 0, 0, time.UTC).Format(DATE_PATTERN)
	}
}