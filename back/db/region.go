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
