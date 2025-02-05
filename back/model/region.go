package model

type Region struct {
	Id          uint    `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Name        string  `json:"name"`
	ParentID    *uint   `json:"-"`
	ParentCount uint    `json:"parentCount"`
	Parent      *Region `gorm:"foreignKey:ParentID" json:"parent"`
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}
