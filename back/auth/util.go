package auth

import "golang.org/x/crypto/bcrypt"

type loginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}


type registerRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
	DisplayName string `json:"displayName"`
}

func (h *Handler) HashPassword(password string) (string, error) {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}

func (h* Handler) CompareHash(password string, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}
