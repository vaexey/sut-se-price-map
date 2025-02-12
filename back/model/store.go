package model

type Store struct {
	Id       uint   `gorm:"primaryKey;unique;autoIncrement" json:"id"`
	RegionID uint   `json:"-"`
	Name     string `json:"name"`
	Region   Region `json:"region"`
}

func (Store) TableName() string {
	return "sut_se_price_map.store"
}
