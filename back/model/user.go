package model

import (
	"github.com/lib/pq"
)

type User struct {
	Id             uint     `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Login          string   `gorm:"unique" json:"username"`
	DisplayName    string   `json:"displayName"`
	Password       string   `json:"-"`
	IsAdmin        bool     `json:"-"`
	IsBanned       bool     `json:"-"`
	AvatarID       *int     `json:"-"`
	Avatar         Resource `json:"avatar"`
	Bio            string   `json:"-"`

	// Gorm tag is necessary without it there is a 404 error
	DefaultRegions pq.Int32Array `gorm:"type:integer[]" json:"-"`
}

func (User) TableName() string {
	return "sut_se_price_map.user"
}