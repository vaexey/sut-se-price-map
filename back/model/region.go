package model

type Region struct {
	Id     uint   `json:"id"`
	Parent uint   `json:"Parent"`
	Name   string `json:"name""`
}
