package model

type Region struct {
	Id     uint   `json:"id"`
	Parent uint   `json:"Parent"`
	Name   string `json:"name""`
}

func (Region) TableName() string {
	return "sut_se_price_map.region"
}