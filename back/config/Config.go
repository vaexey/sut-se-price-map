package config

import (
	"encoding/json"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

type Config struct {
	Address string
	Port int
	SecretKey string
	Protocol string
	Database Database `json:database`
}

type Database struct {
	Type string
	Host string
	Port int
	Username string
	Password string
	Database string
}


func GetConfig(fileName string) (Config, error) {
	data, err := os.ReadFile(fileName)
	if err != nil {
		return Config{}, err
	}
	var config Config
	err = json.Unmarshal(data, &config)
	if err != nil {
		return Config{}, err
	}
	return config, nil
}

func ReadEnv() Config {
	godotenv.Load()
	var config Config
	var err error
	
	config.Address = os.Getenv("ADDRESS")
	config.Port, err = strconv.Atoi(os.Getenv("PORT"))
	if err != nil {
		return Config{}
	}
	config.SecretKey = os.Getenv("SECRET_KEY")
	config.Protocol = os.Getenv("PROTOCOL")
	config.Database.Type = os.Getenv("DATABASE_TYPE")
	config.Database.Host = os.Getenv("DATABASE_HOST")
	config.Database.Port, err = strconv.Atoi(os.Getenv("DATABASE_PORT"))
	if err != nil {
		return Config{}
	}
	config.Database.Username = os.Getenv("DATABASE_USERNAME")
	config.Database.Password = os.Getenv("DATABASE_PASSWORD")
	config.Database.Database = os.Getenv("DATABASE_DATABASENAME")

	return config
}