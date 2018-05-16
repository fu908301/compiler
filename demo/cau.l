%{
#include <stdio.h>
#include "y.tab.h"
int line_no = 0;
%}
number [0-9]*[\.]?(([0-9]*[Ee][\+\-]?[0-9]+)|([0-9]*))?
error [^ \n\t()+\-\*/]+
%%
{number} {yylval.dval = atof(yytext);return(NUMBER); }
"+" {return('+');}
"-" {return('-');}
"*" {return('*');}
"/" {return('/');}
"(" {return('(');}
")" {return(')');}
[ ] {/*do nothing*/}
"\n" {line_no++;return('\n');}
{error} {exit(1);}
%%
