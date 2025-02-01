package db

import "back/model"

func (rh *regionService) SelectAll() ([]model.Region, error) {
	var regions []model.Region
	result := rh.Db.Find(&regions)
	return regions, result.Error
}

func (rh *regionService) SelectById(id uint) (model.Region, error) {
	region := model.Region {
		Id: id,
	}
	result := rh.Db.First(&region)
	return region, result.Error
}

func (rh *regionService) CountParents(id uint) (int, error) {
	count := 0
	currentId := id
	for {
		var region model.Region
		result:= rh.Db.First(&region, currentId)
		if	result.Error != nil {
			return count, result.Error 
		}
		if region.Parent == 0 {
			break;
		}
		count++
		currentId = region.Parent
	}
	return count, nil
}

func (rh *regionService) SelectChildren(parentId uint) ([]uint, error) {
	var regions []model.Region

	result := rh.Db.Where("parent = ?", parentId).Find(&regions)
	if result.Error != nil {
		return nil, result.Error
	}

	var childrenIDs []uint

	// Pobieramy ID wszystkich bezpośrednich dzieci
	for _, region := range regions {
		childrenIDs = append(childrenIDs, region.Id)

		// Rekurencyjne pobieranie ID dzieci tego regionu
		subChildren, err := rh.SelectChildren(region.Id)
		if err != nil {
			return nil, err
		}

		// Dodajemy ID zagnieżdżonych dzieci do listy
		childrenIDs = append(childrenIDs, subChildren...)
	}

	return childrenIDs, nil
}
