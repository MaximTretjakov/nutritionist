package main

import (
	"flag"
	"log"

	"github.com/BurntSushi/toml"
	"github.com/MaximTretjakov/nutritionist/internal/app/apiserver"
)

func main() {
	configPath := flag.String("config-path", "configs/apiserver.toml", "path to config file")

	flag.Parse()

	config := apiserver.NewConfig()
	_, err := toml.DecodeFile(*configPath, config)
	if err != nil {
		log.Fatal(err)
	}

	s := apiserver.New(config)
	if err := s.Start(); err != nil {
		log.Fatal(err)
	}
}
