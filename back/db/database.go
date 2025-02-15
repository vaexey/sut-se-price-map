package db

import (
	"gorm.io/gorm"
)

func NewDatabase(Db *gorm.DB) Database {
	return Database{
		Db: Db,
		User: userService{
			Db: Db,
		},
		Region: regionService{
			Db: Db,
		},
		Product: productService{
			Db: Db,
		},
		Store: storeService{
			Db: Db,
		},
		Contrib: contribService{
			Db: Db,
		},
		Resource: resourceService{
			Db: Db,
		},
	}
}

// TODO: log query results
// TODO: log format
// TODO: log standard for gorm
type Database struct {
	Db      *gorm.DB
	User    userService
	Region  regionService
	Product productService
	Store   storeService
	Contrib contribService
	Resource resourceService
}

type userService struct {
	Db *gorm.DB
}

type regionService struct {
	Db *gorm.DB
}


type productService struct {
	Db *gorm.DB
}

type contribService struct {
	Db *gorm.DB
}

type storeService struct {
	Db *gorm.DB
}

type resourceService struct {
	Db *gorm.DB
}
