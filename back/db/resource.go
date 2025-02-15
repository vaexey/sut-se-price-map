package db

import "back/model"

func (cs *resourceService) SelectById(id uint) (model.Resource, error) {
    var resource model.Resource
    err := cs.Db.First(&resource, id).Error
    return resource, err
}

