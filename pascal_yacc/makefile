all : compile
compile:
				bison -y -d B023040018.y
				flex B023040018.lex
				gcc lex.yy.c y.tab.c -ly -lfl
clean : 
				rm y.tab.c y.tab.h a.out lex.yy.c
