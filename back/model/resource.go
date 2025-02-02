package model

type Resource struct {
	Id   uint `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Name string
	Url  string `json:"url"`
	Blob string `gorm:"-" json:"blob"`
}

func (Resource) TableName() string {
	return "sut_se_price_map.resource"
}