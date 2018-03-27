all:compile
compile:
	flex demo.lex
	gcc -o demo lex.yy.c -lfl
test:
	./demo < test.pas
