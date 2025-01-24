package config

import (
	"encoding/json"
	"os"
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

var Config config = readConfig("config.json")
