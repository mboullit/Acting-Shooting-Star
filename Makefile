SRC_DIR=src
DOC_DIR=doc

all:test

test: ${SRC_DIR}/test-world.rkt ${SRC_DIR}/test-actor.rkt ${SRC_DIR}/actor.rkt ${SRC_DIR}/test-runtime.rkt
	racket ${SRC_DIR}/test-actor.rkt
	racket ${SRC_DIR}/test-world.rkt
	racket ${SRC_DIR}/test-runtime.rkt

project:
	racket ${SRC_DIR}/main.rkt -f 60 2> log.txt

doc: ${SRC_DIR}/doc.scrbl ${SRC_DIR}/actor.scrbl
	scribble --htmls ${SRC_DIR}/doc.scrbl

clean:
	rm -rf ${DOC_DIR} ${SRC_DIR}/compiled *~ */*~
