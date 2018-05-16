%{
#include <stdio.h>
void yyerror(char *);
%}

%union{
double dval;
};

%token <dval> NUMBER
%left  '-' '+'
%left  '*' '/'
%nonassoc UMINUS
%type <dval> expression
%%
lines : lines expression '\n' {printf("answer=%lf\n",$2);}
| {/*empty string*/}
expression: expression '+' expression {$$ = $1+$3;}
| expression '-' expression {$$ = $1-$3;}
| expression '*' expression {$$ = $1*$3;}
| expression '/' expression {
	if($3 == 0)
		yyerror("divide by zero");
	else
		$$ = $1/$3;
	}
| '-' expression %prec UMINUS {$$ = -$2;}
| '(' expression ')' {$$ = $2;}
| NUMBER {$$ = $1;}

%%
int main(){
	yyparse();
	return 0;
}
