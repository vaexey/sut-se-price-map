package db

import (
	"back/model"
)

func (rh *regionService) SelectAll() ([]model.Region, error) {
	var regions []model.Region
	result := rh.Db.Find(&regions)
	return regions, result.Error
}

func (rh *regionService) SelectById(id uint) (model.Region, error) {
	region := model.Region{
		Id: id,
	}
	result := rh.Db.First(&region)
	return region, result.Error
}

func (rh *regionService) CountParents(id uint) (int, error) {
	var region model.Region
	result := rh.Db.First(&region, id)
	if result.Error != nil {
		return 0, result.Error
	}

	if region.ParentID == nil {
		return 0, nil
	}

	// Recursively count the number of parents
	parentCount, err := rh.CountParents(*region.ParentID)
	if err != nil {
		return 0, err
	}

	return parentCount + 1, nil
}

func (rh *regionService) SelectChildren(parentId uint) ([]uint, error) {
	var regions []model.Region

	result := rh.Db.Where("parent = ?", parentId).Find(&regions)
	if result.Error != nil {
		return nil, result.Error
	}

	var childrenIDs []uint

	for _, region := range regions {
		childrenIDs = append(childrenIDs, region.Id)

		subChildren, err := rh.SelectChildren(region.Id)
		if err != nil {
			return nil, err
		}

		childrenIDs = append(childrenIDs, subChildren...)
	}

	return childrenIDs, nil
}
