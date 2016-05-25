%{
#include <stdio.h>
#include "y.tab.h"
unsigned charCount = 1, lineCount = 0;
char mark = 34;
%}
left_comment \(\*
right_comment \*\)
alpha [a-zA-Z_]
digit [0-9]
digits [0-9]+
mid [eE\.\+\-]
not_mid [eE\+\-]
midreal ({digits}|{mid})
unmidreal ({digits}|{not_mid})
zdigit [1-9]
zdigits [1-9]+
integer [+-]{0,1}{zdigit}{digits}
uninteger [+-]{0,1}[0]{digits}
real [+-]{0,1}{zdigit}{midreal}+{digit}
unreal [+-]{0,1}[0]{2,}{unmidreal}+|{real}[0]+|[\.]{unmidreal}+|[+-]{0,1}{unmidreal}+[\.]
id  {alpha}({alpha}|{digit}){0,29}
not_id [0-9\!\@\#\$\%\^\&\*]({alpha}|{digit})+|{alpha}({alpha}|{digit}){30,}
reserved_word [Pp][Rr][Oo][Gg][Rr][Aa][Mm]|label|const|nil|type|packed|array|record|set|file|of|var|procedure|function|forward|begin|end|if|then|else|case|while|do|repeat|until|for|to|downto|goto|with|div|mod|and|not|in|integer|string|float
string \'([^'\n]|\'\'){0,30}\'
unstring \'[^'\n]+[^']|\'([^'\n]|\'\'){30,}\'
comment {left_comment}[^\n]+{right_comment}
eol \n
symbol [:\(\);\*]|:=
space [ ]
character .
%%
{comment} {charCount += yyleng;yylval.name = strdup(yytext);return COMMENT;}
{unstring} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid string%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{string} {charCount += yyleng;yylval.name = strdup(yytext);return STRING;}
{reserved_word} {charCount += yyleng;yylval.name = strdup(yytext);return RESERVED_WORD;}
{eol} {lineCount++; charCount = 1;return EOL;}
{unreal} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid real%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{real} {charCount += yyleng;return REAL;}
{integer} {charCount += yyleng;yylval.name = strdup(yytext);return INTEGER;}
{uninteger} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{id} {charCount += yyleng;yylval.name = strdup(yytext);return ID;}
{not_id} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid ID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{symbol} {charCount += yyleng;yylval.name = strdup(yytext);return SYMBOL;}
{space} {charCount++;return SPACE;}
{character} {charCount++;}
%%
