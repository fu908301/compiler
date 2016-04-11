all:compile
compile:
	flex B023040018.lex
	gcc -o B023040018 lex.yy.c -lfl
test:
	./B023040018 < test1.pas
	./B023040018 < test2.pas
clean:
	rm lex.yy.c B023040018
