package config

import (
	"encoding/json"
	"os"
)

type Config struct {
	Address string
	Port int
	SecretKey string
	Protocol string
	Database DatabaseConfig `json:database`
}

type DatabaseConfig struct {
	Type string
	Host string
	Port int
	Username string
	Password string
	Database string
}


func ReadConfig(fileName string) (Config, error) {
	data, err := os.ReadFile(fileName)
	if err != nil {
		defaultConfig := Config {
			Address: "127.0.0.1",
			Port: 6969,
			SecretKey: "",
			Protocol: "http",
			Database: DatabaseConfig{
				Type: "postgresql",
				Host: "", 
				Port: 5432,
				Username: "",
				Password: "",
				Database: "",
			},
		}
		saveConfigToFile("config.json", defaultConfig)
		return defaultConfig, err
	}
	var config Config
	err = json.Unmarshal(data, &config)
	if err != nil {
		return Config{}, err
	}
	return config, nil
}

func saveConfigToFile(filename string, config Config) error {
	data, err := json.MarshalIndent(config, "", "  ")
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