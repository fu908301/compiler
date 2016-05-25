%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  int line_num = 0;
  extern int lineCount;
  void yyerror(char *str);
%}
%union{
  char *name;
}
%token <name> ID RESERVED_WORD COMMENT STRING REAL INTEGER SYMBOL SPACE
%token <name> BIG SMALL BIGEQUAL SMALLEQUAL BIGSMALL EQUAL
%token <name> EOL
%type <name> type1
%type <name> type2
%type <name> type3
%type <name> id
%type <name> reserve
%type <name> space
%type <name> symbol
%%
line : 
     | line type1 EOL {printf("Line %d: %s\n",lineCount,$2);}
     | line type2 EOL {printf("Line %d:   %s\n",lineCount,$2);}
     | line type3 EOL {printf("Line %d:   %s\n",lineCount,$2);}
type1 : type1 symbol {strcat($1,$2);}
      | reserve space id {strcat($1," ");strcat($1,$3);}
      | reserve {$$ = $1;}
type2 : space type2 {$$ = $2;}
      | type2 symbol {strcat($1,$2);}
      | type2 space reserve {strcat($1, " ");strcat($1, $3);}
      | type2 space symbol {strcat($1, " ");strcat($1, $3);}
      | ID {$$ = $1;}
type3: space type3 {$$ = $2;}
          | type3 symbol {strcat($1,$2);}
          | type3 id {strcat($1,$2);}
          | reserve {$$ = $1;}
reserve : reserve space reserve {strcat($1, " ");strcat($1, $3);} 
        | RESERVED_WORD {$$ = $1;}
        | space reserve {$$ = $1;}
symbol : SYMBOL {$$ = $1;}
space : SPACE {$$ = $1;}
      | SPACE SPACE {strcat($1,$2);}
id: ID {$$ = $1;}
;
%%
int main()
{
  yyparse();
  return 0;
}
void yyerror(char *str)
{
  printf("%s is error",str);
}


