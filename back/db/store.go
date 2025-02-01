package db

import "back/model"

func (sh *storeService) SelectAllWithFilters(includeRegions, excludeRegions []uint) ([]model.Store, error) {
	var stores []model.Store
	query := sh.Db

	if len(includeRegions) > 0 {
		query = query.Where("id IN ?", includeRegions)
	}

	if len(excludeRegions) > 0 {
		query = query.Where("id NOT IN ?", excludeRegions)
	}

	result := query.Find(&stores)
	return stores, result.Error
}

func (rh *storeService) SelectById(id uint) (model.Store, error) {
	store := model.Store{
		Id: id,
	}
	result := rh.Db.First(&store)
	return store, result.Error
}
