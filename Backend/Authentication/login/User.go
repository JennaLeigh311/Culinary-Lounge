package login

type Todo struct {
	Text string
	Done bool
}

var Todos []Todo
var LoggedInUser string

type User struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func GetRole(username string) string {
	if username == "senior" {
		return "senior"
	}
	return "employee"
}