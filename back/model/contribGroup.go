package model

type ContribGroup struct {
	Region Region `json:"region"`
	Store Store `json:"store"`
	Product Product `json:"product"`
	FirstAuthor User `json:"firstAuthor"`
	Contribs []uint `json:"contribs"`
	AvgPrice float32 `json:"averagePrice"`
	Rating float32 `json:"rating"`
}
