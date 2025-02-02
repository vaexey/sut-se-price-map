package db

import "back/model"

func (rh *reportService) SelectAll() ([]model.Report, error) {
	var reports []model.Report
	result := rh.Db.Preload("Author.Avatar").Find(&reports)
	return reports, result.Error
}

func (rh *reportService) Create(report model.Report) (uint, error) {
	result := rh.Db.Create(&report)
	return report.Id, result.Error
}