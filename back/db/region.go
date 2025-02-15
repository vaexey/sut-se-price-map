package db

import (
	"back/model"
)

func (rh *regionService) SelectAll() ([]model.Region, error) {
	var regions []model.Region
	result := rh.Db.Preload("Parent.Parent.Parent").Find(&regions)
	if result.Error != nil {
		return nil, result.Error
	}

	for i := range regions {
		err := rh.CalculateParentCounts(&regions[i])
		if err != nil {
			return nil, err
		}
	}

	return regions, nil
}

func (rh *regionService) SelectById(id uint) (model.Region, error) {
	var region model.Region
	result := rh.Db.Preload("Parent.Parent.Parent").First(&region, id)
	if result.Error != nil {
		return region, result.Error
	}

	err := rh.CalculateParentCounts(&region)
	if err != nil {
		return region, err
	}

	return region, nil
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

func (rh *regionService) CalculateParentCounts(region *model.Region) error {
	parentCount, err := rh.CountParents(region.Id)
	if err != nil {
		return err
	}
	region.ParentCount = uint(parentCount)

	if region.Parent != nil {
		err := rh.CalculateParentCounts(region.Parent)
		if err != nil {
			return err
		}
	}

	return nil
}
func (rh *regionService) SelectChildren(parentId uint) ([]uint, error) {
	var regions []model.Region

	result := rh.Db.Where("parent_id = ?", parentId).Find(&regions)
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
