%{
#include <stdio.h>
void comment_or_not();
void symbol_int();
void symbol_not_int();
void symbol_real();
void symbol_not_real();
int number = 0;
unsigned charCount = 1, lineCount = 1;
char mark = 34;
%}
alpha [a-zA-Z_]
digit [0-9]
digits [0-9]+
zdigit [1-9]
zdigits [1-9]+
integer [+-]?{zdigit}{digits}?
uninteger [+-]?[0]+{digits}
exp [eE][+-]?{digits}
real [+-]?({digits}\.{digits}?|{digits}?\.{digits}){exp}?
unreal [+-]?({uninteger}\.{digits}?|{uninteger}?\.{digits}){exp}?|[+-]?({digits}\.{digits}?[0]+|{digits}?\.{digits}[0]+){exp}?|[+-]?({digits}\.|{digits}?\.){exp}?|[+-]?(\.{digits}?|\.{digits}){exp}?
ID  {alpha}({alpha}|{digit}){0,29}
not_ID [0-9\!\@\#\$\%\^\&\*]({alpha}|{digit})+|{alpha}({alpha}|{digit}){30,}
reserved_word [Pp][Rr][Oo][Gg][Rr][Aa][Mm]|[Ll][Aa][Bb][Ee][Ll]|[Cc][Oo][Nn][Ee][Ss][Tt]|[Nn][Ii][Ll]|[Tt][Yy][Pp][Ee]|[Pp][Aa][Cc][Kk][Ee][Dd]|[Aa][Rr][Rr][Aa][Yy]|[Rr][Ee][Cc][Oo][Rr][Dd]|[Ss][Ee][Tt]|[Ff][Ii][Ll][Ee]|[Oo][Ff]|[Vv][Aa][Rr]|[Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ff][Oo][Rr][Ww][Aa][Rr][Dd]|[Bb][Ee][Gg][Ii][Nn]|[Ee][Nn][Dd]|[Ii][Ff]|[Tt][Hh][Ee][Nn]|[Ee][Ll][Ss][Ee]|[Cc][Aa][Ss][Ee]|[Ww][Hh][Ii][Ll][Ee]|[Dd][Oo]|[Rr][Ee][Pp][Ee][Aa][Tt]|[Uu][Nn][Tt][Ii][Ll]|[Ff][Oo][Rr]|[Tt][Oo]|[Dd][Oo][Ww][Nn][Tt][Oo]|[Gg][Oo][Tt][Oo]|[Ww][Ii][Tt][Hh]|[Dd][Ii][Vv]|[Mm][Oo][Dd]|[Aa][Nn][Dd]|[Nn][Oo][Tt]|[Ii][Nn]|[Ii][Nn][Tt][Ee][Gg][Ee][Rr]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ff][Ll][Oo][Aa][Tt]
string \'([^'\n]|\'\'){0,30}\'
unstring \'[^\n\'|\'\']+[0-9a-zA-z_\!\@\#\$\%\^\&\*\(\)\[\]\{\}\+\=\-\"\:\/\,\-\.\?\~\;]|\'([^'\n]|\'\'){30,}\'
comment \(\*(.|[\n])*?\*\)
eol \n
symbol [\!\@\#\$\%\^\&\*\(\)\[\]\{\}\+\=\-\"\:\/\,\-\.\?\~\;]|:=

character .
%%
{comment} {comment_or_not();number = 0;}
{unstring} {printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid string%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{string} {printf("Line: %d, 1st char: %d,%c%s%c is a %cstring%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{reserved_word} {printf("Line: %d, 1st char: %d,%c%s%c is a %creserved word%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{eol} {lineCount++; charCount = 1;number = 0;}
{unreal} {symbol_not_real();}
{real} {symbol_real();}
{integer} {symbol_int();}
{uninteger} {symbol_not_int();}
{ID} {printf("Line: %d, 1st char: %d, %c%s%c is an %cID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{not_ID} {printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid ID%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{symbol} {printf("Line: %d, 1st char: %d, %c%s%c is a %csymbol%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);charCount += yyleng;number = 0;}
{character} {charCount++;number = 0;}
%%
void comment_or_not()
{
  int i,judge = 0;
  for(i = 1;i < yyleng - 2;i++)
  {
    if((yytext[i] == '('&&yytext[i+1] == '*')||(yytext[i] == '*'&&yytext[i+1] == ')'))
    {
      printf("Line: %d, 1st char: %d,%c%s%c is an %cinvalid comment%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
      charCount += yyleng;
      judge = 1;
      break;
    }
  }
  if(judge == 0)
  {
    printf("Line: %d, 1st char: %d,%c%s%c is a %ccomment%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
    charCount += yyleng;
  }
}
void symbol_int()
{
  char _int[40];
  int i;
  for(i = 1;i < yyleng;i++)
    _int[i-1] = yytext[i];
  if(yytext[0] == '+'|| yytext[0] == '-')
  {
    if(number == 1)
    {
      printf("Line: %d, 1st char: %d, %c%c%c is a %csymbol%c\n",lineCount,charCount,mark,yytext[0],mark,mark,mark);
      charCount += 1;
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinteger%c\n",lineCount,charCount,mark,_int,mark,mark,mark);
      charCount += yyleng - 1;
    }
    else if(number == 0)
    {
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinteger%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
      charCount += yyleng;
    }
  }
  else
  {
    printf("Line: %d, 1st char: %d, %c%s%c is an %cinteger%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
    charCount += yyleng;
  }
  number = 1;
}
void symbol_not_int()
{
  char _int[40];
  int i;
  for(i = 1;i < yyleng;i++)
    _int[i-1] = yytext[i];
  if(yytext[0] == '+'|| yytext[0] == '-')
  {
    if(number == 1)
    {
      printf("Line: %d, 1st char: %d, %c%c%c is a %csymbol%c\n",lineCount,charCount,mark,yytext[0],mark,mark,mark);
      charCount += 1;
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,_int,mark,mark,mark);
      charCount += yyleng - 1;
    }
    else if(number == 0)
    {
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
      charCount += yyleng;
    }
  }
  else
  {
    printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid integer%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
    charCount += yyleng;
  }
  number = 1;
}
void symbol_real()
{
  char _int[40];
  int i;
  for(i = 1;i < yyleng;i++)
    _int[i-1] = yytext[i];
  if(yytext[0] == '+'|| yytext[0] == '-')
  {
    if(number == 1)
    {
      printf("Line: %d, 1st char: %d, %c%c%c is a %csymbol%c\n",lineCount,charCount,mark,yytext[0],mark,mark,mark);
      charCount += 1;
      printf("Line: %d, 1st char: %d, %c%s%c is a %creal number%c\n",lineCount,charCount,mark,_int,mark,mark,mark);
      charCount += yyleng - 1;
    }
    else if(number == 0)
    {
      printf("Line: %d, 1st char: %d, %c%s%c is a %creal number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
      charCount += yyleng;
    }
  }
  else
  {
    printf("Line: %d, 1st char: %d, %c%s%c is an %creal number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
    charCount += yyleng;
  }
  number = 1;
}
void symbol_not_real()
{
  char _int[40];
  int i;
  for(i = 1;i < yyleng;i++)
    _int[i-1] = yytext[i];
  if(yytext[0] == '+'|| yytext[0] == '-')
  {
    if(number == 1)
    {
      printf("Line: %d, 1st char: %d, %c%c%c is a %csymbol%c\n",lineCount,charCount,mark,yytext[0],mark,mark,mark);
      charCount += 1;
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid real number%c\n",lineCount,charCount,mark,_int,mark,mark,mark);
      charCount += yyleng - 1;
    }
    else if(number == 0)
    {
      printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid real number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
      charCount += yyleng;
    }
  }
  else
  {
    printf("Line: %d, 1st char: %d, %c%s%c is an %cinvalid real number%c\n",lineCount,charCount,mark,yytext,mark,mark,mark);
    charCount += yyleng;
  }
  number = 1;
}
main(){ 
yylex();
printf("Finish this scan.\n");
return 0;
} 
