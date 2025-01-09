package services

import (
	"back/config"
	"sync"
)

type Singleton struct {
	config config.Config
}

var instance *Singleton

var once sync.Once

func GetInstance() *Singleton {
	once.Do(
		func() {
			instance = &Singleton{}
		},
	)
	return instance
}

func (s *Singleton) SetConfig(cfg config.Config) {
	s.config = cfg
}

func (s *Singleton) GetConfig() config.Config {
	return s.config;
}