package db

import (
	"back/model"
)

// func (cs *contribService) SelectAll() ([]model.User, error) {
// 	var user []model.User
// 	result := uh.Db.Find(&user)
// 	return user, result.Error
// }

func (cs *contribService) SelectById(id uint) (model.Contrib, error) {
	var contrib model.Contrib
	err := cs.Db.Preload("Product").Preload("Store").Preload("Author").First(&contrib, id).Error
    return contrib, err
}
