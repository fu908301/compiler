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
declist : dec | declist SEMICOLON dec 
dec : idlist COLON type 
type : standtype | arraytype 
standtype : INTEGERS | REALS 
arraytype : ARRAY LEFTS INTEGER DOT DOT INTEGER RIGHTS OF standtype 
idlist : ID | idlist COMMA ID 
stmtlist : stmt | stmtlist SEMICOLON stmt 
stmt : assign | read | write | for| ifstmt 
assign : varid EQUAL2 simpexp 
ifstmt : IF LEFTC exp RIGHTC THEN body 
exp : simpexp | exp relop simpexp 
relop : BIG | SMALL | BIGEQUAL | SMALLEQUAL | BIGSMALL | EQUAL1 
simpexp : term | simpexp PLUS term| simpexp MINUS term
term : factor | term CROSS factor  | term DIVID factor 
factor : varid | INTEGER | REAL | LEFTC simpexp RIGHTC
read : READ LEFTC idlist RIGHTC
write : WRITE LEFTC idlist RIGHTC
for : FOR indexexp DO body 
indexexp : varid EQUAL2 simpexp TO exp 
varid : ID | ID LEFTS simpexp RIGHTS 
body : stmt | BEGINN stmtlist SEMICOLON END 
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
