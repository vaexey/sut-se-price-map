package db

import (
	"back/model"
	"fmt"
	"strings"
	// "fmt"
)
func NewFilter(include *[]uint, exclude *[]uint, prefix string) Filter {
    field := prefix
    if field != "id" {
	field = fmt.Sprintf("%s_id", prefix)
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
	if filter.Field == "region" {
	    continue
	}

	if filter.Include != nil {
	    arr := strings.ReplaceAll(fmt.Sprintf("%v", *filter.Include), " ", ",")
	    stmt += replacer.Replace(fmt.Sprintf(" AND %s IN %s", filter.Field, arr))
	}

	if filter.Exclude != nil {
	    arr := strings.ReplaceAll(fmt.Sprintf("%v", *filter.Exclude), " ", ",")
	    stmt += replacer.Replace(fmt.Sprintf(" AND %s NOT IN %s", filter.Field, arr))
	}

    }
    err := cs.Db.Where(fmt.Sprintf("1 = 1 %s", stmt)).Find(&contribs)
    fmt.Println(err)
    fmt.Println(contribs)

    return contribs, nil
}

func (cs *contribService) SelectById(id uint) (model.Contrib, error) {
    var contrib model.Contrib
    err := cs.Db.Preload("Product").Preload("Store").Preload("Author").First(&contrib, id).Error
    return contrib, err
}
