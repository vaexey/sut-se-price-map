package config

import (
	"encoding/json"
	"os"
	"strconv"
)

type config struct {
	Database databaseConfig `json:"database"`
	Server   serverConfig   `json:"server"`
}

type serverConfig struct {
	Address string
	Port    int
	Secret  string
}

type databaseConfig struct {
	Type     string
	Host     string
	Port     int
	Username string
	Password string
	Database string
}

func readConfig(fileName string) config {
	var conf config
	data, err := os.ReadFile(fileName)
	if err != nil {
		conf = config{
			Server: serverConfig{
				Address: "0.0.0.0",
				Port:    6969,
				Secret:  "",
			},
			Database: databaseConfig{
				Type:     "postgresql",
				Host:     "",
				Port:     5432,
				Username: "",
				Password: "",
				Database: "",
			},
		}
		saveConfig(fileName, conf)
		return conf
	}

	err = json.Unmarshal(data, &conf)

	if err != nil {
		return config{}
	}

	return conf
}

func saveConfig(filename string, conf config) error {
	data, err := json.MarshalIndent(conf, "", "  ")
	if err != nil {
		return err
	}
	//save to file
	err = os.WriteFile(filename, data, 0644)

	if err != nil {
		return err
	}

	return nil
}

func UpdateConfigFromEnv () { 
	updateDatabaseConfigFormEnv()
	updateServerConfigFromEnv()
}

func updateDatabaseConfigFormEnv() {
	if envValue := os.Getenv("DATABASE_PORT"); envValue != "" {
		if envPort, err := strconv.Atoi(envValue); err == nil && envPort != Config.Database.Port {
			Config.Database.Port = envPort
		}
	}
	if envValue := os.Getenv("DATABASE_TYPE"); envValue != "" && envValue != Config.Database.Type {
		Config.Database.Type = envValue
	}
	if envValue := os.Getenv("DATABASE_HOST"); envValue != "" && envValue != Config.Database.Host {
		Config.Database.Host = envValue
	}
	if envValue := os.Getenv("DATABASE_USERNAME"); envValue != "" && envValue != Config.Database.Username {
		Config.Database.Username = envValue
	}
	if envValue := os.Getenv("DATABASE_PASSWORD"); envValue != "" && envValue != Config.Database.Password {
		Config.Database.Password = envValue
	}
	if envValue := os.Getenv("DATABASE_NAME"); envValue != "" && envValue != Config.Database.Database {
		Config.Database.Database = envValue
	}
}

func updateServerConfigFromEnv() {
	if envValue := os.Getenv("SERVER_ADDRESS"); envValue != "" && envValue != Config.Server.Address {
		Config.Server.Address = envValue
	}
	if envValue := os.Getenv("SERVER_PORT"); envValue != "" {
		if envPort, err := strconv.Atoi(envValue); err == nil && envPort != Config.Server.Port {
			Config.Server.Port = envPort
		}
	}
	if envValue := os.Getenv("SERVER_SECRET"); envValue != "" && envValue != Config.Server.Secret {
		Config.Server.Secret = envValue
	}
}

var Config config = readConfig("config.json")
