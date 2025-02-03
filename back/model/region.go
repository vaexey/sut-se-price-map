package model

type Region struct {
	Id          uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Parent      uint   `json:"parent"`
	Name        string `json:"name"`
	ParentCount uint   `json:"parentCount"`
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}
