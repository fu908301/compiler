%{
#include <stdio.h>
unsigned charCount = 0, idCount = 0, lineCount = 0;
%}
id    [^ \t\n]+
space [ ]
eol   \n
character .
%%
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
