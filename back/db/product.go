package db

import "back/model"

func (ph *productService) SelectAll() ([]model.Product, error) {
	var products []model.Product
	result := ph.Db.Find(&products)
	return products, result.Error
}