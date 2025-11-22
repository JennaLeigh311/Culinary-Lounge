package models

// http://go-database-sql.org/errors.html

import (
	"database/sql"
	_ "github.com/go-sql-driver/mysql"
	"fmt"
)

var (
	dbUser = "jenna"
	dbPass = "password"
	dbName = "recipeappdb"
	dbHost = "127.0.0.1"
	dbPort = "3306"
)

func GetUsers() ([]User, error) {

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPass, dbHost, dbPort, dbName))

	// if there is an error opening the connection, handle it
	if err != nil {
		// simply print the error to the console
		// returns nil on error
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}

	defer db.Close()
	results, err := db.Query("SELECT * FROM users")

	if err != nil {
		return nil, fmt.Errorf("query failed: %w", err)
	}

	users := []User {}
	for results.Next() {
		var user User
        // for each row, scan into the User struct
		err = results.Scan(&user.ID, &user.Username, &user.Email, &user.Role, &user.CreatedAt)
		if err != nil {
			panic(err.Error()) // proper error handling instead of panic in your app
		}
        // append the user into useres array
		users = append(users, user)
	}

	return users, nil

}

func GetUser(ID string) (*User, error) {

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPass, dbHost, dbPort, dbName))
	user := &User{}
	if err != nil {
		// simply print the error to the console
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}
    
	defer db.Close()

	results, err := db.Query("SELECT * FROM users where id=?", ID)

	if err != nil {
		return nil, fmt.Errorf("query failed: %w", err)
	}

	if results.Next() {
		err = results.Scan(&user.ID, &user.Username, &user.Email, &user.Password, &user.Role, &user.CreatedAt)
		if err != nil {
			return nil, fmt.Errorf("failed to scan user: %w", err)
		}
	} else {
		
		return nil, nil // query succeeds, but no rows if no user found
	}

	return user, nil
}


func GetUserByEmail(email string) (*User, error) {

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPass, dbHost, dbPort, dbName))
	user := &User{}
	if err != nil {
		// simply print the error to the console
		return nil, fmt.Errorf("failed to connect to database: %w", err)
	}
    
	defer db.Close()

	results, err := db.Query("SELECT * FROM users where email=?", email)

	if err != nil {
		return nil, fmt.Errorf("query failed: %w", err)
	}

	if results.Next() {
		
		err = results.Scan(&user.ID, &user.Username, &user.Email, &user.Password, &user.CreatedAt, &user.Role)

		if err != nil {
			if err == sql.ErrNoRows {
				return nil, fmt.Errorf("user not found")  // query succeeds, but user not found
			} else {
				return nil, fmt.Errorf("failed to scan user: %w", err)
			}
		}
	} 

	// bug in the code here found by chatgpt, he said I shouldn't be returning nil, nil
	if err == sql.ErrNoRows {
		return nil, fmt.Errorf("user not found")  // query succeeds, but user not found
	}

	if err != nil {
        return nil, fmt.Errorf("scan failed: %w", err)
    }


	return user, nil
}

func AddUser(user User) {

	db, err := sql.Open("mysql", fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", dbUser, dbPass, dbHost, dbPort, dbName))

	if err != nil {
		panic(err.Error())
	}

	// defer the close till after this function has finished
	// executing
	defer db.Close()

	insert, err := db.Query(
		"INSERT INTO users (id,username,email,password,role,created_at) VALUES (?,?,?,?,?,now())",
		user.ID, user.Username, user.Email, user.Password, user.Role)

	// if there is an error inserting, handle it
	if err != nil {
		panic(err.Error())
	}

	defer insert.Close()

}
