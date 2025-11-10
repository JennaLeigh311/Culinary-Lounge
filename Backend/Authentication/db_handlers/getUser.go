package dbhandlers

import (
	"Authentication/models"
	"net/http"
	"github.com/gin-gonic/gin"
)

func GetUser(c *gin.Context) {
	id := c.Param("id")

	user, err := models.GetUser(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if user == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
		return
	}

	c.IndentedJSON(http.StatusOK, user)
}

func GetUserByEmail(c *gin.Context) {
	email := c.Param("email")

	user, err := models.GetUserByEmail(email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if user == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
		return
	}

	c.IndentedJSON(http.StatusOK, user)
}
