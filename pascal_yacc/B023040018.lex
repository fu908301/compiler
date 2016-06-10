%{
#include <stdio.h>
#include "y.tab.h"
unsigned charCount = 1, lineCount = 1;
char mark = 34;
%}
left_comment \(\*
right_comment \*\)
alpha [A-Za-z_]
digit [0-9]
digits [0-9]*
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
big >
small <
bigequal >=
smallequal <=
bigsmall <>
equal1 =
equal2 :=
dot \.
leftc \(
rightc \)
lefts \[
rights \]
colon \:
semicolon \;
plus \+
minus \-
cross \*
divid \/
comma \,
symbol [:\(\);\*\[\]]|:=
program [Pp][Rr][Oo][Gg][Rr][Aa][Mm]
integers [Ii][Nn][Tt][Ee][Gg][Ee][Rr]
reals [Rr][Ee][Aa][Ll]
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
space [ ]
%%
{comment} {charCount += yyleng;}
{unstring} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid string%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{string} {charCount += yyleng;}
{program} {charCount += yyleng;printf("%s",yytext);return PROGRAM;}
{var} {charCount += yyleng;printf("%s",yytext);return VAR;}
{begin} {charCount += yyleng;printf("%s",yytext);return BEGINN;}
{end} {charCount += yyleng;printf("%s",yytext);return END;}
{of} {charCount += yyleng;printf("%s",yytext);return OF;}
{if} {charCount += yyleng;printf("%s",yytext);return IF;}
{then} {charCount += yyleng;printf("%s",yytext);return THEN;}
{read} {charCount += yyleng;printf("%s",yytext);return READ;}
{array} {charCount += yyleng;printf("%s",yytext);return ARRAY;}
{write} {charCount += yyleng;printf("%s",yytext);return WRITE;}
{do} {charCount += yyleng;printf("%s",yytext);return DO;}
{for} {charCount += yyleng;printf("%s",yytext);return FOR;}
{to} {charCount += yyleng;printf("%s",yytext);return TO;}
{dot} {charCount += yyleng;printf("%s",yytext);return DOT;}
{leftc} {charCount += yyleng;printf("%s",yytext);return LEFTC;}
{rightc} {charCount += yyleng;printf("%s",yytext);return RIGHTC;}
{lefts} {charCount += yyleng;printf("%s",yytext);return LEFTS;}
{rights} {charCount += yyleng;printf("%s",yytext);return RIGHTS;}
{colon} {charCount += yyleng;printf("%s",yytext);return COLON;}
{semicolon} {charCount += yyleng;printf("%s",yytext);return SEMICOLON;}
{plus} {charCount += yyleng;printf("%s",yytext);return PLUS;}
{minus} {charCount += yyleng;printf("%s",yytext);return MINUS;}
{cross} {charCount += yyleng;printf("%s",yytext);return CROSS;}
{divid} {charCount += yyleng;printf("%s",yytext);return DIVID;}
{comma} {charCount += yyleng;printf("%s",yytext);return COMMA;}
{integers} {charCount += yyleng;printf("%s",yytext);return INTEGERS;}
{reals} {charCount += yyleng;printf("%s",yytext);return REALS;}
{reserved_word} {charCount += yyleng;}
{eol} {lineCount++; printf("\nLine %d:",lineCount);charCount = 1;}
{unreal} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid real%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{real} {charCount += yyleng;printf("%s",yytext);return REAL;}
{integer} {charCount += yyleng;printf("%s",yytext);return INTEGER;}
{uninteger} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{id} {charCount += yyleng;printf("%s",yytext);return ID;}
{not_id} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid ID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{big} {charCount += yyleng;printf("%s",yytext);return BIG;}
{small} {charCount += yyleng;printf("%s",yytext);return SMALL;}
{bigequal} {charCount += yyleng;printf("%s",yytext);return BIGEQUAL;}
{smallequal} {charCount += yyleng;printf("%s",yytext);return SMALLEQUAL;}
{bigsmall} {charCount += yyleng;printf("%s",yytext);return BIGSMALL;}
{equal1} {charCount += yyleng;printf("%s",yytext);return EQUAL1;}
{equal2} {charCount += yyleng;printf("%s",yytext);return EQUAL2;}
{space} {charCount += yyleng;printf("%s",yytext);}
{character} {charCount++;}
%%
