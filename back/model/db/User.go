package model

type User struct {
	id          DbId
	displayName string
	avatar      DbRef[Resource]
}
