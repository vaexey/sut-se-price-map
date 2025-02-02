package model

type Report struct {
	Id       uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Reported uint   `gorm:"column:reported_id" json:"reported"`
	Message  string `json:"message"`
	AuthorID uint   `json:"-"`
	Author   User   `gorm:"column:author_id" json:"author"`
	Date     string `json:"date"`
}

func (Report) TableName() string {
	return "sut_se_price_map.report"
}