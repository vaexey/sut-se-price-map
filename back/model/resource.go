package model

type Resource struct {
	Id   uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Url  string `json:"url"`
	Blob string `json:"blob" gorm:"column:source"`
	Name string `json:"name"`
}

func (Resource) TableName() string {
	return "sut_se_price_map.resource"
}
