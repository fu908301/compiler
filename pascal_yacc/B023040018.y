%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int line_num = 0;
%}
%union{
  char *name;
}
%token ID RESERVED_WORD COMMENT STRING REAL INTEGER SYMBOL PROGRAM VAR BEGINN END ARRAY OF READ WRITE DO FOR IF THEN DIV TO

%type <name> ID 
%type <name> RESERVED_WORD 
%type <name> COMMENT 
%type <name> STRING 
%type <name> REAL 
%type <name> INTEGER 
%type <name> SYMBOL
%type <name> prog
%type <name> proname
%type <name> PROGRAM
%type <name> VAR
%type <name> BEGINN
%type <name> END
%type <name> ARRAY
%type <name> OF
%type <name> IF
%type <name> THEN
%type <name> READ
%type <name> WRITE
%type <name> DO
%type <name> FOR
%type <name> TO
%type <name> declist
%type <name> dec
%type <name> type
%type <name> standtype
%type <name> arraytype
%type <name> idlist
%type <name> stmtlist
%type <name> stmt
%type <name> assign
%type <name> ifstmt
%type <name> exp
%type <name> relop
%type <name> simpexp
%type <name> term
%type <name> factor
%type <name> read
%type <name> write
%type <name> for
%type <name> varid
%type <name> body
%type <name> indexexp
%%
prog :  PROGRAM proname ';' VAR declist ';' BEGINN stmtlist ';' END'.'{}
proname : ID{}
declist : dec{}
         | declist ';' dec{}
dec : idlist ':' type{}
type : standtype{}
     | arraytype{}
standtype : INTEGER{}
          | REAL{}
arraytype : ARRAY '[' INTEGER SYMBOL INTEGER ']' OF standtype {}
idlist : ID{}
        | idlist ',' ID{}
stmtlist : stmt{}
         | stmtlist ';' stmt{}
stmt : assign{}
     | read{}
     | write{}
     | for{}
     | ifstmt {}
assign : varid ':=' simpexp{}
ifstmt : IF '(' exp ')' THEN body{}
exp : simpexp{} 
    | exp relop simpexp{}
relop : '>'{}
      | '<'{}
      | '>='{}
      | '<='{}
      | '<>'{}
      | '='{}
simpexp : term{}
        | simpexp '+' term{}
        | simpexp '-' term{}
term : factor '{' '*' factor '|' DIV factor'}' {}
factor : varid{}
       | INTEGER{} 
       | REAL{} 
       | '(' simpexp ')'{}
read : READ '(' idlist ')'{}
write : WRITE '(' idlist ')'{}
for : FOR indexexp DO body {}
indexexp : varid SYMBOL simpexp TO exp
varid : ID{}
      | ID '[' simpexp ']'
body : stmt{}
     | BEGINN stmtlist ';' END
    ;
%%
int main()
{
  yyparse();
  return 0;
}


