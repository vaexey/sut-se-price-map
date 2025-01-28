package model

type Store struct {
	Id     uint `gorm:"unique;primaryKey;autoIncrement"`
	Region uint
	Name   string
}

func (Store) TableName() string {
	return "sut_se_price_map.store"
}
