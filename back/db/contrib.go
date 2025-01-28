package db

import (
	"back/model"
)

func (cs *contribService) SelectById(id uint) (model.Contrib, error) {
    var contrib model.Contrib
    err := cs.Db.Preload("Product").Preload("Store").Preload("Author").First(&contrib, id).Error
    return contrib, err
}
