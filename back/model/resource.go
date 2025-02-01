package model

type Resource struct {
	Id   uint   `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	Url  string `json:"url"`
	Blob string `json:"blob"`
}
