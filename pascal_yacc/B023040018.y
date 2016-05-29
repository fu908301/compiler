%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  extern int lineCount;
  extern int charCount;
  extern char *yytext;
  void yyerror(char *s);
%}
%union{
  char *name;
}
%token <name> INTEGERS REALS ID REAL INTEGER PROGRAM VAR BEGINN END ARRAY OF READ WRITE DO FOR IF THEN TO EQUAL1 EQUAL2 BIG SMALL BIGEQUAL SMALLEQUAL BIGSMALL LEFTC RIGHTC LEFTS RIGHTS COLON SEMICOLON PLUS MINUS CROSS DIVID DOT COMMA
%type <name> prog
%type <name> proname
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
prog :  PROGRAM proname SEMICOLON VAR declist SEMICOLON BEGINN  stmtlist SEMICOLON END DOT | error
proname : ID
declist : dec | declist SEMICOLON dec | error
dec : idlist COLON type | error
type : standtype | arraytype | error
standtype : INTEGERS | REALS |error
arraytype : ARRAY LEFTS INTEGER DOT DOT INTEGER RIGHTS OF standtype | error
idlist : ID | idlist COMMA ID | error
stmtlist : stmt | stmtlist SEMICOLON stmt | error
stmt : assign | read | write | for| ifstmt |error
assign : varid EQUAL2 simpexp | error
ifstmt : IF LEFTC exp RIGHTC THEN body | error 
exp : simpexp | exp relop simpexp | error
relop : BIG | SMALL | BIGEQUAL | SMALLEQUAL | BIGSMALL | EQUAL1 | error
simpexp : term | simpexp PLUS term| simpexp MINUS term | error
term : factor | term CROSS factor  | term DIVID factor | error
factor : varid | INTEGER | REAL | LEFTC simpexp RIGHTC | error
read : READ LEFTC idlist RIGHTC | error
write : WRITE LEFTC idlist RIGHTC | error
for : FOR indexexp DO body | error
indexexp : varid EQUAL2 simpexp TO exp | error
varid : ID | ID LEFTS simpexp RIGHTS | error
body : stmt | BEGINN stmtlist SEMICOLON END | error
    ;
%%
int main()
{
  printf("Line 1: ");
  yyparse();
  return 0;
}
void yyerror(char *s){
    fprintf(stderr,"errorline %d : %s %s\n",lineCount,yytext,s);
  }
