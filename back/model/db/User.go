package model

type User struct {
	Id          uint `gorm:"unique;primaryKey;autoIncrement"`
	DisplayName string `gorm:"unique"`
	Password	string
	Avatar      *int
}

func (User) TableName() string {
	return "sut_se_price_map.user"
}
