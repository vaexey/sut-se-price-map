package db

import (
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






