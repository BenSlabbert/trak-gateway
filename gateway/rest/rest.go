package rest

import (
	"encoding/json"
	"github.com/golang/protobuf/jsonpb"
	"github.com/golang/protobuf/proto"
	log "github.com/sirupsen/logrus"
	"trak-gateway/gateway/response"

	"net/http"
)

func sendError(w http.ResponseWriter, e *response.Error) {
	switch e.Type {
	case response.ServerError:
		sendServerError(w, e)
	case response.BadRequest:
		sendClientError(w, e)
	case response.PermissionDenied:
		sendPermissionsError(w, e)
	}
}

func sendServerError(w http.ResponseWriter, e *response.Error) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusInternalServerError)
	writeError(*e, w)
}

func sendClientError(w http.ResponseWriter, e *response.Error) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusBadRequest)
	writeError(*e, w)
}

func sendPermissionsError(w http.ResponseWriter, e *response.Error) {
	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusUnauthorized)
	writeError(*e, w)
}

func writeError(e response.Error, w http.ResponseWriter) {
	bytes, err := json.Marshal(e)
	if err != nil {
		log.Error("Failed to marshal error struct")
		write(w, []byte{})
		return
	}
	write(w, bytes)
}

func sendOK(w http.ResponseWriter, message proto.Message) {
	m := jsonpb.Marshaler{}
	result, _ := m.MarshalToString(message)

	w.Header().Add("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)

	bytes := []byte(result)
	write(w, bytes)
}

func write(w http.ResponseWriter, bytes []byte) {
	i, e := w.Write(bytes)
	if e != nil {
		log.Infof("Failed to write to client!\n%v", e)
	} else {
		log.Debugf("Wrote: %d bytes to response", i)
	}
}
