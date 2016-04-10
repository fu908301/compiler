%{
#include <stdio.h>
unsigned charCount = 1, lineCount = 1;
char mark = 34;
%}
other [A-Za-z]+
reserved_word [Pp][Rr][Oo][Gg][Rr][Aa][Mm]|label|const|nil|type|packed|array|record|set|file|of|var|procedure|function|forward|begin|end|if|then|else|case|while|do|repeat|until|for|to|downto|goto|with|div|mod|and|not|in|integer

eol \n
symbol [:|\(|\)|;]
character .
%%
{reserved_word} {printf("Line: %d, 1st char: %d,%c%s%c is a %creserved word%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{other} {printf("Line: %d, 1st char: %d, %c%s%c is an %cID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{eol} {lineCount++; charCount = 1;}
{symbol} {printf("Line: %d, 1st char: %d, %c%s%c is a %csymbol%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{character} { charCount++;}
%%
main(){ 
yylex();
return 0;
} 
