package db

import (
	model "back/model/db"
	"gorm.io/gorm"
)

func NewDbHandler(Db *gorm.DB) DbHandler {
	return DbHandler {
		Db : Db,
		User : UserHandler{
			Db : Db,
		},
	}
}

// TODO: log query results
// TODO: log format
// TODO: log standard for gorm
type DbHandler struct {
	Db *gorm.DB
	User UserHandler
}

type UserHandler struct {
	Db *gorm.DB
}


func (uh *UserHandler) SelectAll() ([]model.User, error) {
	var user []model.User
	result := uh.Db.Find(&user)
	return user, result.Error
}

func (uh *UserHandler) SelectById(id uint) (model.User, error) {
	user := model.User {
		Id : id,
	}
	result := uh.Db.Find(&user)
	return user, result.Error
}

func (uh *UserHandler) CreateUser(user model.User) (uint, error) {
	result := uh.Db.Create(&user)
	return user.Id, result.Error
}






