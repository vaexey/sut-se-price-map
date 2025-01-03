package model

type Region struct {
    id DbId
    parent DbRef[Region]
    name string
}
