package db

import "back/model"

func (rh *reportService) SelectAll() ([]model.Report, error) {
	var reports []model.Report
	result := rh.Db.Preload("Author.Avatar").Find(&reports)
	return reports, result.Error
}