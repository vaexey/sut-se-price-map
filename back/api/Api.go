package api

import (
	"back/db"
)

func NewApi(db *db.Database) Api {
	return Api { Db : db }
}

type Api struct {
	Db *db.Database
}

