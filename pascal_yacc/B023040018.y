%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int line_num = 0;
%}
%union{
  char *name;
}
%token ID RESERVED_WORD COMMENT STRING REAL INTEGER SYMBOL

%type <name> ID 
%type <name> RESERVED_WORD 
%type <name> COMMENT 
%type <name> STRING 
%type <name> REAL 
%type <name> INTEGER 
%type <name> SYMBOL
%type <name> prog
%type <name> myname
%%
prog :  RESERVED_WORD myname{
     printf("%s%s\n",$1,$2);}
myname : ID{
       }

    ;
%%
int main()
{
  yyparse();
  return 0;
}


