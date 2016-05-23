%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int line_num = 0;
  extern char* yytext;
%}
%union{
  char name[128];
  int val;
  float fval;
}
%token ID RESERVED_WORD COMMENT STRING REAL INTEGER SYMBOL

%type <name> ID 
%type <name> RESERVED_WORD 
%type <name> COMMENT 
%type <name> STRING 
%type <val> REAL 
%type <name> INTEGER 
%type <name> SYMBOL
%%
prog :  RESERVED_WORD ID{
     printf("%s%s",$1,$2);}

    ;
%%
int main()
{
  yyparse();
  return 0;
}


