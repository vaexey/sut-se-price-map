package db

import (
	"gorm.io/gorm"
)

func NewDatabase(Db *gorm.DB) Database {
	return Database {
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
type Database struct {
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


