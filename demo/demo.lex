%{
#include <stdio.h>
unsigned charCount = 0, idCount = 0, lineCount = 0;
%}
reserved program
left \(\*
right \*\)
comment {left}[^\n]+{right}
id    [^ \t\n]+
space [ ]
eol   \n
character .
%%
{comment} {printf("This is comment");}
{reserved} {printf("This is program");}
{id}   { idCount++; charCount += yyleng ; printf("This id is %s\n", yytext);}
{eol}    {lineCount++;}
{space}  {/*do nothing*/}
{character} {charCount++;}
%%

	main(){ 
	yylex();
	printf("%d %d %d\n",charCount, idCount, lineCount);
	return 0;
}
