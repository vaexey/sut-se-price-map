package model

type Store struct {
	Id       uint   `gorm:"primaryKey;unique;autoIncrement" json:"id"`
	RegionID uint   `json:"-"`
	Region   Region `json:"region"`
	Name     string `json:"name"`
}

func (Store) TableName() string {
	return "sut_se_price_map.store"
}
