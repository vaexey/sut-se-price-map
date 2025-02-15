package api

import (
	"back/auth"
	"back/model"
	"errors"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/lib/pq"
	"gorm.io/gorm"
)

func (a *Api) ProfileByUserLogin(c *gin.Context) {
	userLogin := c.Param("userLogin")
	if userLogin == "" {
		c.JSON(http.StatusBadRequest, gin.H {
			"code": 400,
			"message": "Invalid request",
		})
		return
	}
	
	user, err := a.Db.User.SelectByUsername(userLogin)

	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "This profile do not exist",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
  			"code": 404,
  			"message": "Requested profile not found",
		})
		return
	}

	contribCount, err := a.Db.Contrib.GetNumberOfContribs(user.Id)
	handleUserErrors(c, &user, err)

	c.JSON(http.StatusOK, jsonProfile(user, contribCount))
}

func (a *Api) CurrentUserProfile(c *gin.Context) {
	id := auth.CtxId(c)

	user, err := a.Db.User.SelectById(*id)

	if errors.Is(err, gorm.ErrRecordNotFound) {
		c.JSON(http.StatusBadRequest, gin.H{
			"message": "This profile do not exist",
		})
		return
	}

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
  			"code": 404,
  			"message": "Requested profile not found",
		})
		return
	}

	contribCount, err := a.Db.Contrib.GetNumberOfContribs(user.Id)
	handleUserErrors(c, &user, err)

	c.JSON(http.StatusOK, jsonProfile(user, contribCount))
}

func jsonProfile(user model.User, contribCount int) gin.H {
	return gin.H{
		"id": user.Id,
		"login": user.Login,
		"displayName": user.DisplayName,
		"bio": user.Bio,
		"contribCount": contribCount,
		"defaultRegions": user.DefaultRegions,
		"isAdmin": user.IsAdmin,
		"isBanned": user.IsBanned,
	}
}

func handleUserErrors(c *gin.Context, user *model.User, err error) {
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"code": 404,
			"message": "Requested resource not found",
	  	})
		return
	}

	if user.DefaultRegions == nil {
		user.DefaultRegions = pq.Int32Array{}
	}
}