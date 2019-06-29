CXX=g++-8
FLAGS=-std=c++11 -Wall -Wextra
TARGETS=functions sorts String SLL CSLL DLL CDLL Stack Queue Dequeue BST
RECURSIVE=false

# Object Files
%.o: source/*/%.cpp
	$(CXX) -c -DRECURSIVE=$(if $(filter true,$(RECURSIVE)),true,false) $(FLAGS) $^

# Tests
functions: source/Functions/functions.test.cpp functions.o
	$(CXX) $(FLAGS) $^
	./a.out

sorts: source/Sorts/sorts.test.cpp sorts.o functions.o
	$(CXX) $(FLAGS) $^
	./a.out

String: source/String/String.test.cpp String.o functions.o
	$(CXX) $(FLAGS) $^
	./a.out

%: source/LinkedList/LinkedList.test.cpp %.o
	$(CXX) $(FLAGS) $^
	./a.out

Queue: source/Queue/Queue.test.cpp Queue.o $(if $(LIST),$(LIST).o,SLL.o)
	$(CXX) $(FLAGS) $^
	./a.out

Stack: source/Stack/Stack.test.cpp Stack.o $(if $(LIST),$(LIST).o,SLL.o)
	$(CXX) $(FLAGS) $^
	./a.out

Dequeue: source/Queue/Dequeue.test.cpp Dequeue.o $(if $(LIST),$(LIST).o,DLL.o)
	$(CXX) $(FLAGS) $^
	./a.out

calculator: calculator.cpp Stack.o SLL.o String.o functions.o
	$(CXX) $(FLAGS) $^
	./a.out

%: source/Algorithms/%.test.cpp functions.o Stack.o Queue.o SLL.o String.o
	$(CXX) $(FLAGS) $^
	./a.out

all: $(TARGETS)

.PHONY: clean

clean:
	find . -name "*out" -delete
	find . -name "*.o" -delete
