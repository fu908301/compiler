%{
#include <stdio.h>
unsigned charCount = 1, lineCount = 1;
char mark = 34;
%}
alpha [a-zA-Z_]
digit [0-9]
digits [0-9]+
mid [eE\.\+\-]
midreal ({digits}|{mid})
zdigit [1-9]
zdigits [1-9]+
integer [+-]{0,1}{zdigit}{digits}
uninteger [+-]{0,1}[0]{digits}
real [+-]{0,1}{zdigit}{midreal}{zdigit}
ID  {alpha}({alpha}|{digit}){0,29}
reserved_word [Pp][Rr][Oo][Gg][Rr][Aa][Mm]|label|const|nil|type|packed|array|record|set|file|of|var|procedure|function|forward|begin|end|if|then|else|case|while|do|repeat|until|for|to|downto|goto|with|div|mod|and|not|in|integer|float

eol \n
symbol [:\(\);]|:=

character .
%%
{reserved_word} {printf("Line: %d, 1st char: %d,%c%s%c is a %creserved word%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{ID} {printf("Line: %d, 1st char: %d, %c%s%c is an %cID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{eol} {lineCount++; charCount = 1;}
{integer} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinteger%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{uninteger} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{real} {printf("Line: %d, 1st char: %d, %c%s%c is a %creal number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{symbol} {printf("Line: %d, 1st char: %d, %c%s%c is a %csymbol%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{character} {charCount++;}
%%
main(){ 
yylex();
return 0;
} 