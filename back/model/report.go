package model

type Report struct {
	Id         uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	ReportedID uint   `json:"reported"`
	Message    string `json:"message"`
	AuthorID   uint   `json:"-"`
	Author     User   `json:"author"`
	Date       string `json:"date"`
}

func (Report) TableName() string {
	return "sut_se_price_map.report"
}