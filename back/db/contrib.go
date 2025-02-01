package db

import (
	"back/model"
	"fmt"
	"gorm.io/gorm"
)
func NewFilter(include *[]uint, exclude *[]uint, prefix string) Filter {
    field := prefix
    if prefix != "id" {
	// cut the 's'
	field = prefix[:len(prefix) - 1]
	// append _id
	field = fmt.Sprintf("%s_id", field)
    }
    field = fmt.Sprintf("contrib.%s", field)
    if prefix == "regions" {
	field = "store.region_id"
    }

    return Filter {
	Include: include,
	Exclude: exclude,
	Field: field,
    }
}

type Filter struct {
    Field string
    Include *[]uint
    Exclude *[]uint
}

func (cs* contribService) QueryApplyFilters(filters []Filter) *gorm.DB {
    query := cs.Db.
        Preload("Store.Region").
	Preload("Store").
	Preload("Author").
        Preload("Product")

    join := false
    for _, filter := range filters {

	if filter.Include != nil && len(*filter.Include) > 0 {
	    query.Where(fmt.Sprintf("%s in ?", filter.Field), *filter.Include)
	    if filter.Field == "store.region_id" {
		join = true
	    }
	}

	if filter.Exclude != nil && len(*filter.Exclude) > 0 {
	    query.Where(fmt.Sprintf("%s not in ?", filter.Field), *filter.Exclude)
	    if filter.Field == "store.region_id" {
		join = true
	    }
	}

    }
    if join {
	query.Joins("JOIN \"sut_se_price_map\".\"store\" on \"store\".id = contrib.store_id")
    }
    return query
}

func (cs *contribService) SelectWithFilters(filters []Filter) ([]model.Contrib, error) {
    var contribs []model.Contrib
    query := cs.QueryApplyFilters(filters)

    err := query.Find(&contribs).Error
    return contribs, err
}




func (cs *contribService) SelectById(id uint) (model.Contrib, error) {
    var contrib model.Contrib
    err := cs.Db.Preload("Product").Preload("Store").Preload("Author").First(&contrib, id).Error
    return contrib, err
}
