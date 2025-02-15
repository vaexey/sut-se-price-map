package model

type User struct {
	Id          uint	`gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Login		string	`gorm:"unique" json:"username"`
	DisplayName string `json:"displayName"`
	Password	string `json:"-"`
	IsAdmin		bool `json:"-"`
	AvatarID    uint `json:"-" gorm:"default:NULL"`
	Avatar		Resource `json:"avatar"`
}

func (User) TableName() string {
	return "sut_se_price_map.user"
}
