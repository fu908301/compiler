%{
#include <stdio.h>
#include "y.tab.h"
unsigned charCount = 1, lineCount = 1;
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
reserved_word label|const|nil|type|packed|record|set|file|procedure|function|forward|else|case|while|do|repeat|until|downto|goto|with|div|mod|and|not|in|integer|string|float
string \'([^'\n]|\'\'){0,30}\'
unstring \'[^'\n]+[^']|\'([^'\n]|\'\'){30,}\'
comment {left_comment}[^\n]+{right_comment}
eol \n
symbol [:\(\);\*]|:=
program [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
var [Vv][Aa][Rr]
begin [Bb][Ee][Gg][Ii][Nn]
end [Ee][Nn][Dd]
array [Aa][Rr][Rr][Aa][Yy]
of [Oo][Ff]
if [Ii][Ff]
then [Tt][Hh][Ee][Nn]
read [Rr][Ee][Aa][Dd]
write [Ww][Rr][Ii][Tt][Ee]
do [Dd][Oo]
for [Ff][Oo][Rr]
to [Tt][Oo]
character .
%%
{comment} {charCount += yyleng;yylval.name = strdup(yytext);return COMMENT;}
{unstring} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid string%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{string} {charCount += yyleng;yylval.name = strdup(yytext);return STRING;}
{program} {return PROGRAM;}
{var} {return VAR;}
{begin} {return BEGINN;}
{end} {return END;}
[array] {return ARRAY;}
{of} {return OF;}
{if} {return IF;}
{then} {return THEN;}
{read} {return READ;}
{write} {return WRITE;}
{do} {return DO;}
{for} {return FOR;}
{to} {return TO;}
{reserved_word} {charCount += yyleng;yylval.name = strdup(yytext);return RESERVED_WORD;}
{eol} {lineCount++; charCount = 1;}
{unreal} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid real%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{real} {charCount += yyleng;return REAL;}
{integer} {charCount += yyleng;yylval.name = strdup(yytext);return INTEGER;}
{uninteger} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{id} {charCount += yyleng;yylval.name = strdup(yytext);return ID;}
{not_id} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid ID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{symbol} {charCount += yyleng;yylval.name = strdup(yytext);return SYMBOL;}
{character} {charCount++;}
%%
