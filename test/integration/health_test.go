package integration

import (
	"net/http"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHealth(t *testing.T) {
	resp := makeRequest(t, http.MethodGet, "/health", nil, "")
	assert.Equal(t, http.StatusOK, resp.StatusCode)
}
