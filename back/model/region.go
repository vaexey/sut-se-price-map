package model

type Region struct {
	Id            uint `gorm:"unique;primaryKey;autoIncrement"`
	Parent        uint
	Name          string
	ParentsNumber uint
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}
