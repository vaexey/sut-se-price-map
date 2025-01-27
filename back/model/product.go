package model

type Product struct {
	Id   uint `gorm:"unique;primaryKey;autoIncrement"`
	Name string
}

func (Product) TableName() string {
	return "sut_se_price_map.product"
}