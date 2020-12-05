%{
	#include "y.tab.h"
    int line = 1; 
    int position = 1;
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

"function" {position+=yyleng; return FUNCTION; }
"beginparams" {printf("BEGIN_PARAMS\n"); position+=yyleng;}
"endparams" {printf("END_PARAMS\n");}
"beginlocals" {printf("BEGIN_LOCALS\n"); position+=yyleng;}
"endlocals" {printf("END_LOCALS\n"); position+=yyleng;}
"beginbody" {printf("BEGIN_BODY\n"); position+=yyleng;}
"endbody" {printf("END_BODY\n"); position+=yyleng;}
"integer" {printf("INTEGER\n"); position+=yyleng;}
"array" {printf("ARRAY\n"); position+=yyleng;}
"of" {printf("OF\n"); position+=yyleng;}
"if" {printf("IF\n"); position+=yyleng;}
"then" {printf("THEN\n"); position+=yyleng;}
"endif" {printf("ENDIF\n"); position+=yyleng;}
"else" {printf("ELSE\n"); position+=yyleng;}
"while" {printf("WHILE\n"); position+=yyleng;}
"do" {printf("DO\n"); position+=yyleng;}
"for" {printf("FOR\n"); position+=yyleng;}
"beginloop" {printf("BEGINLOOP\n"); position+=yyleng;}
"endloop" {printf("ENDLOOP\n"); position+=yyleng;}
"continue" {printf("CONTINUE\n"); position+=yyleng;}
"read" {printf("READ\n"); position+=yyleng;}
"write" {printf("WRITE\n"); position+=yyleng;}
"and" {printf("AND\n"); position+=yyleng;}
"or" {printf("OR\n"); position+=yyleng;}
"not" {printf("NOT\n"); position+=yyleng;}
"true" {printf("TRUE\n"); position+=yyleng;}
"false" {printf("FALSE\n"); position+=yyleng;}
"return" {printf("RETURN\n"); position+=yyleng;}

"+" {printf("ADD\n"); position+=yyleng;}
"-" {printf("SUB\n"); position+=yyleng;}
"*" {printf("MULT\n"); position+=yyleng;}
"/" {printf("DIV\n"); position+=yyleng;}
"%" {printf("MOD\n"); position+=yyleng;}

"==" {printf("EQ\n"); position+=yyleng;}
"<>" {printf("NEQ\n"); position+=yyleng;}
"<" {printf("LT\n"); position+=yyleng;}
">" {printf("GT\n"); position+=yyleng;}
"<=" {printf("LTE\n"); position+=yyleng;}
">=" {printf("GTE\n"); position+=yyleng;}
":=" {printf("ASSIGN\n"); position+=yyleng;}

";" {position+=yyleng; return SEMICOLON;}
":" {printf("COLON\n"); position+=yyleng;}
"," {printf("COMMA\n"); position+=yyleng;}
"(" {printf("L_PAREN\n"); position+=yyleng;}
")" {printf("R_PAREN\n"); position+=yyleng;}
"[" {printf("L_SQUARE_BRACKET\n"); position+=yyleng;}
"]" {printf("R_SQUARE_BRACKET\n"); position+=yyleng;}

{letter}{char}*{underscore} {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line, position, yytext); }
{letter}{char}*   { position+=yyleng; return IDENT; }
{digit}+  { position += yyleng; return NUMBER; }

{space}+ { position+=yyleng;}
{newline} { line++; position = 1;}
{comment} {position+=yyleng;}

({underscore}|{digit})+{letter}* {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, position, yytext);}
. {printf("Error at line: %d, column: %d: unrecognized symbol: \"%c\"\n", line, position, *yytext); exit(0);}

%%


