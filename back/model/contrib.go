package model

type Contrib struct {
	Id uint `gorm:"unique;primaryKey;autoIncrement" json:"id"`
	// grouped by
	ProductID uint    `json:"-"`
	Product   Product `json:"product"`

	StoreID uint  `json:"-"`
	Store   Store `json:"store"`

	AuthorID uint `json:"-"`
	Author   User `json:"author"`

	Price float32 `json:"price"`
	Date  string  `json:"date"`

	// optional detail view
	Comment *string `json:"comment"`
	//Attachments []uint `gorm:"column:attachments"`

	// view status
	Status string `json:"status"`
}

func (Contrib) TableName() string {
	return "sut_se_price_map.contrib"
}
