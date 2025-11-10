package dbhandlers

import (
	"Authentication/models"
	"net/http"
	"github.com/gin-gonic/gin"
)

func AddUser(c *gin.Context) {
	var user models.User

	if err := c.BindJSON(&user); err != nil {
		c.AbortWithStatus(http.StatusBadRequest)
	} else {
		models.AddUser(user)
		c.IndentedJSON(http.StatusCreated, user)
	}
}