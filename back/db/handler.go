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
		Region: regionService{
			Db: Db,
		},
	}
}

// TODO: log query results
// TODO: log format
// TODO: log standard for gorm
type DbHandler struct {
	Db *gorm.DB
	User userService
	Region regionService
}

type userService struct {
	Db *gorm.DB
}

type regionService struct {
	Db *gorm.DB
}


