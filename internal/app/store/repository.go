package store

import "github.com/MaximTretjakov/nutritionist/internal/app/model"

type UserRepository interface {
	Create(*model.User) error
	FindByEmail(string) (*model.User, error)
}
