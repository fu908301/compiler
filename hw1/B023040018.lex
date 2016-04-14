%{
#include <stdio.h>
unsigned charCount = 1, lineCount = 1;
char mark = 34;
%}
alpha [a-zA-Z_]
digit [0-9]
digits [0-9]+
zdigit [1-9]
zdigits [1-9]+
integer [+-]{0,1}{zdigit}{digits}?
uninteger [+-]{0,1}[0]+{digits}
exp [eE][+-]?{digits}
real [+-]?({digits}\.{digits}?|{digits}?\.{digits}){exp}?
unreal [+-]?({uninteger}\.{digits}?|{uninteger}?\.{digits}){exp}?|[+-]?({digits}\.{digits}?[0]+|{digits}?\.{digits}[0]+){exp}?|[+-]?({digits}\.|{digits}?\.){exp}?|[+-]?(\.{digits}?|\.{digits}){exp}?
ID  {alpha}({alpha}|{digit}){0,29}
not_ID [0-9\!\@\#\$\%\^\&\*]({alpha}|{digit})+|{alpha}({alpha}|{digit}){30,}
reserved_word [Pp][Rr][Oo][Gg][Rr][Aa][Mm]|[Ll][Aa][Bb][Ee][Ll]|[Cc][Oo][Nn][Ee][Ss][Tt]|[Nn][Ii][Ll]|[Tt][Yy][Pp][Ee]|[Pp][Aa][Cc][Kk][Ee][Dd]|[Aa][Rr][Rr][Aa][Yy]|[Rr][Ee][Cc][Oo][Rr][Dd]|[Ss][Ee][Tt]|[Ff][Ii][Ll][Ee]|[Oo][Ff]|[Vv][Aa][Rr]|[Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ff][Oo][Rr][Ww][Aa][Rr][Dd]|[Bb][Ee][Gg][Ii][Nn]|[Ee][Nn][Dd]|[Ii][Ff]|[Tt][Hh][Ee][Nn]|[Ee][Ll][Ss][Ee]|[Cc][Aa][Ss][Ee]|[Ww][Hh][Ii][Ll][Ee]|[Dd][Oo]|[Rr][Ee][Pp][Ee][Aa][Tt]|[Uu][Nn][Tt][Ii][Ll]|[Ff][Oo][Rr]|[Tt][Oo]|[Dd][Oo][Ww][Nn][Tt][Oo]|[Gg][Oo][Tt][Oo]|[Ww][Ii][Tt][Hh]|[Dd][Ii][Vv]|[Mm][Oo][Dd]|[Aa][Nn][Dd]|[Nn][Oo][Tt]|[Ii][Nn]|[Ii][Nn][Tt][Ee][Gg][Ee][Rr]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ff][Ll][Oo][Aa][Tt]
string \'([^'\n]|\'\'){0,30}\'
unstring \'([^'\n]|\'\')+[;]|\'([^'\n]|\'\'){30,}\'
not_comment \(\*(.&(\(\*|\*\)))*?\*\)
comment \(\*(.|[\n])*?\*\)
eol \n
symbol [:\(\);\*\+\-\*\/]|:=

character .
%%
{not_comment} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid comment%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{comment} {printf("Line: %d, 1st char: %d,%c%s%c is a %ccomment%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{unstring} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid string%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{string} {printf("Line: %d, 1st char: %d,%c%s%c is a %cstring%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{reserved_word} {printf("Line: %d, 1st char: %d,%c%s%c is a %creserved word%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{eol} {lineCount++; charCount = 1;}
{unreal} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid real%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{real} {printf("Line: %d, 1st char: %d, %c%s%c is a %creal number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{integer} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinteger%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{uninteger} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{ID} {printf("Line: %d, 1st char: %d, %c%s%c is an %cID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{not_ID} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid ID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{symbol} {printf("Line: %d, 1st char: %d, %c%s%c is a %csymbol%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;}
{character} {charCount++;}
%%
main(){ 
yylex();
return 0;
} 
