package model

type Store struct {
	Id     uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Region uint   `json:"region"`
	Name   string `json:"name"`
}

func (Store) TableName() string {
	return "sut_se_price_map.store"
}
