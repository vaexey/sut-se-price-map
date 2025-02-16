package db

import (
	"back/model"
	"fmt"

	"gorm.io/gorm"
)
func NewFilter(include *[]uint, exclude *[]uint, prefix string) Filter {
    field := prefix
    // cut the 's'
    field = prefix[:len(prefix) - 1]
    // append _id
    field = fmt.Sprintf("contrib.%s_id", field)
    if prefix == "ids" {
	    field = "id"
    }

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
	Preload("Store.Region.Parent.Parent.Parent").
        // Preload("Store.Region").
	Preload("Store").
	Preload("Author.Avatar").
	Preload("Author").
        Preload("Product.Photo").
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

func (cs *contribService) Create(contrib model.Contrib) (uint, error) {
    result := cs.Db.Create(&contrib)
    return contrib.Id, result.Error
}

func (cs *contribService) Update(contrib model.Contrib) error {
    err := cs.Db.Select("comment", "price","status").Updates(contrib).Error
    return err
}

func (cs * contribService) GetNumberOfContribs(authorId uint) (int, error) {
    var contribs []model.Contrib
    err := cs.Db.Where("author_id = ?", authorId).Find(&contribs).Error
    return len(contribs), err
}

