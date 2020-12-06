%{
   #include <string>
   #include "y.tab.h"
   int currLine = 1; 
   int currPos = 1;
%}

letter [a-zA-Z]
digit [0-9]
dec {digit}*"."{digit}+
sci ({digit}|{dec})+[eE][+-]?{digit}+
char {letter}|{digit}|{underscore}
space " "|"\t"
newline "\n"
comment "##".*
underscore "_"
ending_iden_char = {letter}|{digit}

%%

"function" {currPos+=yyleng; return FUNCTION;}
"beginparams" {currPos+=yyleng; return BEGIN_PARAMS;}
"endparams" {return END_PARAMS;}
"beginlocals" {currPos+=yyleng; return BEGIN_LOCALS;}
"endlocals" {currPos+=yyleng; return END_LOCALS;}
"beginbody" {currPos+=yyleng; return BEGIN_BODY;}
"endbody" {currPos+=yyleng; return END_BODY;}
"integer" {currPos+=yyleng; return INTEGER;}
"array" {currPos+=yyleng; return ARRAY;}
"of" {currPos+=yyleng; return OF;}
"if" {currPos+=yyleng; return IF;}
"then" {currPos+=yyleng; return THEN;}
"endif" {currPos+=yyleng; return ENDIF;}
"else" {currPos+=yyleng; return ELSE;}
"while" {currPos+=yyleng; return WHILE;}
"do" {currPos+=yyleng; return DO;}
"for" {currPos+=yyleng; return FOR;}
"beginloop" {currPos+=yyleng; return BEGINLOOP;}
"endloop" {currPos+=yyleng; return ENDLOOP;}
"continue" {currPos+=yyleng; return CONTINUE;}
"read" {currPos+=yyleng; return READ;}
"write" {currPos+=yyleng; return WRITE;}
"and" {currPos+=yyleng; return AND;}
"or" {currPos+=yyleng; return OR;}
"not" {currPos+=yyleng; return NOT;}
"true" {currPos+=yyleng; return TRUE;}
"false" {currPos+=yyleng; return FALSE;}
"return" {currPos+=yyleng; return RETURN;}

"+" {currPos+=yyleng; return ADD;}
"-" {currPos+=yyleng; return SUB;}
"*" {currPos+=yyleng; return MULT;}
"/" {currPos+=yyleng; return DIV;}
"%" {currPos+=yyleng; return MOD;}

"==" {currPos+=yyleng; return EQ;}
"<>" {currPos+=yyleng; return NEQ;}
"<" {currPos+=yyleng; return LT;}
">" {currPos+=yyleng; return GT;}
"<=" {currPos+=yyleng; return LTE;}
">=" {currPos+=yyleng; return GTE;}
":=" {currPos+=yyleng; return ASSIGN;}

";" {currPos+=yyleng; return SEMICOLON;}
":" {currPos+=yyleng; return COLON;}
"," {currPos+=yyleng; return COMMA;}
"(" {currPos+=yyleng; return L_PAREN;}
")" {currPos+=yyleng; return R_PAREN;}
"[" {currPos+=yyleng; return L_SQUARE_BRACKET;}
"]" {currPos+=yyleng; return R_SQUARE_BRACKET;}

{letter}{char}*{underscore} {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);}
{letter}{char}*   {currPos+=yyleng; yylval.sval = yytext; return IDENT;}
{digit}+  {currPos += yyleng; yylval.ival = atoi(yytext); return NUMBER;}

{space}+ { currPos+=yyleng;}
{newline} { currLine++; currPos = 1;}
{comment} {currPos+=yyleng;}

({underscore}|{digit})+{letter}* {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}
. {printf("Error at line: %d, column: %d: unrecognized symbol: \"%c\"\n", currLine, currPos, *yytext); exit(0);}

%%

