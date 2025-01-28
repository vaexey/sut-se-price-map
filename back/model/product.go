package model

type Product struct {
	Id   uint `gorm:"primaryKey;unique;autoIncrement" json:"id"`
	Name string `json:"name"`
}

func (Product) TableName() string {
	return "sut_se_price_map.product"
}
