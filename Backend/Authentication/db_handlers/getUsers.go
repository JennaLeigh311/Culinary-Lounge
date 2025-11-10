package dbhandlers

import (
	"Authentication/models"
	"net/http"
	"github.com/gin-gonic/gin"
)

func GetUsers(c *gin.Context) {
	users, err := models.GetUsers()
	if err != nil {
		// Something went wrong with the DB query
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if len(users) == 0 {
		// No users found
		c.JSON(http.StatusNotFound, gin.H{"error": "No users found"})
		return
	}

	c.IndentedJSON(http.StatusOK, users)
}