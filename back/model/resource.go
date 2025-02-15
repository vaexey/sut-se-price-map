package model

type Resource struct {
	Id   uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Url  string `json:"-"`
	Blob string `json:"-" gorm:"column:source"`
	Name string `json:"-"`
}

func (Resource) TableName() string {
	return "sut_se_price_map.resource"
}
