package db

import (
	"back/model"
	"fmt"
	"strings"
)
func NewFilter(include *[]uint, exclude *[]uint, prefix string) Filter {
    field := prefix
    if prefix != "id" {
	// cut the 's'
	field = prefix[:len(prefix) - 1]
	// append _id
	field = fmt.Sprintf("%s_id", field)
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


func (cs *contribService) SelectWithFilters(filters []Filter) ([]model.Contrib, error) {
    replacer := strings.NewReplacer("[", "(", "]", ")")
    var contribs []model.Contrib
    stmt := ""
    for _, filter := range filters {

	if filter.Include != nil {
	    arr := strings.ReplaceAll(fmt.Sprintf("%v", *filter.Include), " ", ",")
	    stmt += replacer.Replace(fmt.Sprintf(" AND %s IN %s", filter.Field, arr))
	}

	if filter.Exclude != nil {
	    arr := strings.ReplaceAll(fmt.Sprintf("%v", *filter.Exclude), " ", ",")
	    stmt += replacer.Replace(fmt.Sprintf(" AND %s NOT IN %s", filter.Field, arr))
	}

    }
    err := cs.Db.
	Preload("Store").
	Preload("Author").
        Preload("Product").
        Preload("Store.Region").
        Where(fmt.Sprintf("1 = 1%s", stmt)).
        Find(&contribs).Error
    fmt.Println(stmt)

    return contribs, err
}

func (cs *contribService) SelectById(id uint) (model.Contrib, error) {
    var contrib model.Contrib
    err := cs.Db.Preload("Product").Preload("Store").Preload("Author").First(&contrib, id).Error
    return contrib, err
}
