package model

type Region struct {
	Id            uint   `gorm:"primaryKey;unique;autoIncrement" json:"id"`
	Parent        uint `json:"parent"`
	Name          string  `json:"name"`
	ParentsNumber uint `json:"parentNumber"`
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}
