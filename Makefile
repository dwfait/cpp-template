CPP_FILES := $(wildcard src/*.cpp)
TEST_FILES := $(wildcard test/*.cpp)
OBJ_FILES := $(addprefix obj/,$(notdir $(CPP_FILES:.cpp=.o)))
TEST_OBJ_FILES := $(addprefix test-obj/,$(notdir $(TEST_FILES:.cpp=.o)))
CC_FLAGS := -Wall -Wextra -pedantic -std=c++11 -I ./src/
LD_FLAGS := -lboost_program_options-mt -lboost_filesystem-mt -lboost_system-mt
GXX := clang++

bin/main: $(OBJ_FILES)
	mkdir -p bin
	$(GXX) -o $@ $^ $(LD_FLAGS)

bin/test: $(TEST_OBJ_FILES)
	mkdir -p bin
	$(GXX) -o $@ $^ $(LD_FLAGS)

obj/%.o: src/%.cpp
	mkdir -p obj
	$(GXX) $(CC_FLAGS) -c -o $@ $<

test-obj/%.o: test/%.cpp
	mkdir -p test-obj
	$(GXX) $(CC_FLAGS) -c -o $@ $<

test: bin/test
	bin/test

install:
	cp bin/test /usr/local/bin

clean:
	rm -f obj/*.o bin/* test-obj/*.o
