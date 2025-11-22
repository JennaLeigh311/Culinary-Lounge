package main

//source: https://permify.co/post/jwt-authentication-go/
// another source: https://blog.techchee.com/build-a-rest-api-with-golang-gin-and-mysql/

// Import the required packages
import (
	"Authentication/models"
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
)

// Add a new global variable for the secret key - this should go in .env later
var secretKey = []byte("your-secret-key")

// Function to create JWT tokens with claims
func createToken(email, role string) (string, error) {
    // Create a new JWT token with claims
	claims := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"sub": email,
		"iss": "Authentication",
		"aud": role,
		"exp": time.Now().Add(time.Hour).Unix(), // Expiration time
		"iat": time.Now().Unix(), // Issued at
	})

	tokenString, err := claims.SignedString(secretKey)
    if err != nil {

        return "", err
    }

  // Print information about the created token
	fmt.Printf("Token claims added: %+v\n", claims)
	return tokenString, nil
}

func main() {
	router := gin.Default()

	// user sign up lives in Vapor. After user signs up they must go to the login route.

	// user login route
	router.POST("/login", func(c *gin.Context) {

		var creds struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}

		if err := c.BindJSON(&creds); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
			return
		}

		// Fetch user by email from DB
		user, err := models.GetUserByEmail(creds.Email)
		if err != nil || user.Password != creds.Password {
			fmt.Printf("error: %s", err)
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid credentials"})
			return
		}

		// Create JWT token
		tokenString, err := createToken(user.Email, user.Role)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to create token"})
			return
		}

		c.JSON(http.StatusOK, gin.H{
			"token": tokenString,
			"id": user.ID,
			"username": user.Username,
			"email": user.Email,
			"role":  user.Role,
		})

	})

	router.Run(":9090")

}
