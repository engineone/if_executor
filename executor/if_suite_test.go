package executor_test

import (
	"io"
	"testing"

	_ "github.com/lepsta/engineone/pkg/executors"
	. "github.com/onsi/ginkgo/v2"
	. "github.com/onsi/gomega"
	"github.com/sirupsen/logrus"
)

func TestEngine(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "If Executor Suite")
}

func init() {
	logrus.SetOutput(io.Discard)
}
