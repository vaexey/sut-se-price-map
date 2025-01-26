package model

type User struct {
	Id          uint	`gorm:"unique;primaryKey;autoIncrement"`
	Login		string	`gorm:"unique"`
	DisplayName string
	Password	string
	IsAdmin		bool
	Avatar      *int
}

func (User) TableName() string {
	return "sut_se_price_map.user"
}
