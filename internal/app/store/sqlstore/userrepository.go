package sqlstore

import "github.com/MaximTretjakov/nutritionist/internal/app/model"

type UserRepository struct {
	store *Store
}

func (r *UserRepository) Create(u *model.User) error {
	if err := u.Validate(); err != nil {
		return err
	}

	if err := u.BeforeCreate(); err != nil {
		return err
	}

	return r.store.db.QueryRow(
		"INSERT INTO users (login, password , email) VALUES ($1, $2, $3) RETURNING id",
		u.Login,
		u.Password,
		u.Email,
	).Scan(&u.Id)
}

func (r *UserRepository) FindByEmail(email string) (*model.User, error) {
	u := &model.User{}

	if err := r.store.db.QueryRow(
		"SELECT id, login, password FROM users WHERE email = $1",
		email,
	).Scan(
		&u.Id,
		&u.Login,
		&u.Password,
	); err != nil {
		return nil, err
	}

	return u, nil
}
