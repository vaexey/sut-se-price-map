package db

import (
	model "back/model/db"
	"gorm.io/gorm"
)

func NewDbHandler(Db *gorm.DB) DbHandler {
	return DbHandler {
		Db : Db,
		User : userService{
			Db : Db,
		},
	}
}

// TODO: log query results
// TODO: log format
// TODO: log standard for gorm
type DbHandler struct {
	Db *gorm.DB
	User userService
}

type userService struct {
	Db *gorm.DB
}


func (uh *userService) SelectAll() ([]model.User, error) {
	var user []model.User
	result := uh.Db.Find(&user)
	return user, result.Error
}

func (uh *userService) SelectById(id uint) (model.User, error) {
	user := model.User {
		Id : id,
	}
	result := uh.Db.Find(&user)
	return user, result.Error
}
func (uh *userService) SelectByUsername(username string) (model.User, error) {
	// user := model.User {
	// 	DisplayName: username,
	// }
	var user model.User
	result := uh.Db.First(&user, "display_name = ?", username)
	return user, result.Error
}

func (uh *userService) CreateUser(user model.User) (uint, error) {
	result := uh.Db.Create(&user)
	return user.Id, result.Error
}






