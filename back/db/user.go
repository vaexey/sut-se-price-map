package db
import model "back/model"


func (uh *userService) SelectAll() ([]model.User, error) {
	var user []model.User
	result := uh.Db.Preload("Avatar").Find(&user)
	return user, result.Error
}

func (uh *userService) SelectById(id uint) (model.User, error) {
	user := model.User {
		Id : id,
	}
	result := uh.Db.Preload("Avatar").Find(&user)
	return user, result.Error
}

func (uh *userService) SelectByUsername(username string) (model.User, error) {
	var user model.User
	result := uh.Db.Preload("Avatar").First(&user, "login = ?", username)
	return user, result.Error
}

func (uh *userService) CreateUser(user model.User) (uint, error) {
	result := uh.Db.Create(&user)
	return user.Id, result.Error
}
