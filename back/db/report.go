package db

import "back/model"

func (rh *reportService) SelectAll(timestampBefore string, timestampAfter string) ([]model.Report, error) {
	var reports []model.Report
	result := rh.Db.Preload("Author.Avatar").Where("date >= ?", timestampBefore).Where("date <= ?", timestampAfter).Find(&reports)
	return reports, result.Error
}

func (rh *reportService) Create(report model.Report) error {
	result := rh.Db.Create(&report)
	return result.Error
}