package model

type DbId string
type DbRef[T any] DbId

// cant use type parameter as RHS in type declaration
type DbInsert[T any] any
