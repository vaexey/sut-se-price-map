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

var defaultConfig config = config{
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

func readConfig(fileName string) config {
	var conf config
	data, err := os.ReadFile(fileName)
	if err != nil {
		conf = defaultConfig

		saveConfig(fileName, conf)
		updateConfigFromEnv(&conf)

		return conf
	}

	err = json.Unmarshal(data, &conf)

	if err != nil {
		conf = defaultConfig
	}

	updateConfigFromEnv(&conf)

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

func updateConfigFromEnv(conf *config) {
	updateConfigField("DATABASE_PORT", func(value string) {
		if port, err := strconv.Atoi(value); err == nil {
			conf.Database.Port = port
		}
	})
	updateConfigField("DATABASE_TYPE", func(value string) {
		conf.Database.Type = value
	})
	updateConfigField("DATABASE_HOST", func(value string) {
		conf.Database.Host = value
	})
	updateConfigField("DATABASE_USERNAME", func(value string) {
		conf.Database.Username = value
	})
	updateConfigField("DATABASE_PASSWORD", func(value string) {
		conf.Database.Password = value
	})
	updateConfigField("DATABASE_NAME", func(value string) {
		conf.Database.Database = value
	})

	//server
	updateConfigField("SERVER_ADDRESS", func(value string) {
		conf.Server.Address = value
	})
	updateConfigField("SERVER_PORT", func(value string) {
		if port, err := strconv.Atoi(value); err == nil {
			conf.Server.Port = port
		}
	})
	updateConfigField("SERVER_SECRET", func(value string) {
		conf.Server.Secret = value
	})
}

func updateConfigField(envKey string, updateFunc func(string)) {
	if envValue := os.Getenv(envKey); envValue != "" {
		updateFunc(envValue)
	}
}

var Config config = readConfig("config.json")
var API_PATH string = "/api/v1"
