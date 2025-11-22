package models

import (
	"github.com/google/uuid"
)

type User struct {
	ID uuid.UUID `json:"id"`
	Username string `json:"username"`
	Email string `json:"email"`
	Password string `json:"password"`
	Role string `json:"role"`
	CreatedAt []uint8 `json:"created_at"`
}
