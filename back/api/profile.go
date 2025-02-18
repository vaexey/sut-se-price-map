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
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
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
			"code":    404,
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
			"code":    404,
			"message": "Requested profile not found",
		})
		return
	}

	contribCount, err := a.Db.Contrib.GetNumberOfContribs(user.Id)
	handleUserErrors(c, &user, err)

	c.JSON(http.StatusOK, jsonProfile(user, contribCount))
}

func (a *Api) UpdateProfile(c *gin.Context) {
	var requestBody struct {
		DisplayName    string        `json:"displayName"`
		Bio            string        `json:"bio"`
		DefaultRegions pq.Int32Array `json:"defaultRegions"`
	}

	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"code":    400,
			"message": "Invalid request",
		})
		return
	}

	// Retrieve the current user's information
	userId := auth.CtxId(c)
	if userId == nil {
		c.JSON(http.StatusUnauthorized, gin.H{
			"code":    401,
			"message": "Unauthorized",
		})
		return
	}

	user, err := a.Db.User.SelectById(*userId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"code":    500,
			"message": "Failed to retrieve user information",
		})
		return
	}

	// Update the editable fields
	user.DisplayName = requestBody.DisplayName
	user.Bio = requestBody.Bio
	user.DefaultRegions = requestBody.DefaultRegions

	if err := a.Db.User.Update(&user).Error; err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"code":    500,
			"message": "Failed to update profile",
		})
		return
	}

	c.JSON(http.StatusOK, jsonProfile(user, 0))
}

func jsonProfile(user model.User, contribCount int) gin.H {
	return gin.H{
		"id":          user.Id,
		"login":       user.Login,
		"displayName": user.DisplayName,
		"avatar": gin.H{
			"id": user.AvatarID,
		},
		"bio":            user.Bio,
		"contribCount":   contribCount,
		"defaultRegions": user.DefaultRegions,
		"isAdmin":        user.IsAdmin,
		"isBanned":       user.IsBanned,
	}
}

func handleUserErrors(c *gin.Context, user *model.User, err error) {
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{
			"code":    404,
			"message": "Requested resource not found",
		})
		return
	}

	if user.DefaultRegions == nil {
		user.DefaultRegions = pq.Int32Array{}
	}
}
