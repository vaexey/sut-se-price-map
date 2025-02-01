package model

type Product struct {
	Id    uint     `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Name  string   `json:"name"`
	Photo Resource `json:"photo"`
}

func (Product) TableName() string {
	return "sut_se_price_map.product"
}