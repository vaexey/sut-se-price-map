package model

type Store struct {
    id DbId
    region DbRef[Region]
    name string
}
