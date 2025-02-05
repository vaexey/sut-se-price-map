package model

type Region struct {
	Id       uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Name     string `json:"name"`
	ParentID *uint  `json:"parent_id"`
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}
