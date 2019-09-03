package response

type ErrorType uint32

const (
	ServerError      ErrorType = iota
	BadRequest       ErrorType = iota
	PermissionDenied ErrorType = iota
)

type Error struct {
	Message string `json:"message"`
	Type    ErrorType
}
