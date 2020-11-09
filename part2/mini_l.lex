%{
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

"function" {position+=yyleng; return FUNCTION;}
"beginparams" {position+=yyleng; return BEGIN_PARAMS;}
"endparams" {return END_PARAMS;}
"beginlocals" {position+=yyleng; return BEGIN_LOCALS;}
"endlocals" {position+=yyleng; return END_LOCALS;}
"beginbody" {position+=yyleng; return BEGIN_BODY;}
"endbody" {position+=yyleng; return END_BODY;}
"integer" {position+=yyleng; return INTEGER;}
"array" {position+=yyleng; return ARRAY;}
"of" {position+=yyleng; return OF;}
"if" {position+=yyleng; return IF;}
"then" {position+=yyleng; return THEN;}
"endif" {position+=yyleng; return ENDIF;}
"else" {position+=yyleng; return ELSE;}
"while" {position+=yyleng; return WHILE;}
"do" {position+=yyleng; return DO;}
"for" {position+=yyleng; return FOR;}
"beginloop" {position+=yyleng; return BEGINLOOP;}
"endloop" {position+=yyleng; return ENDLOOP;}
"continue" {position+=yyleng; return CONTINUE;}
"read" {position+=yyleng; return READ;}
"write" {position+=yyleng; return WRITE;}
"and" {position+=yyleng; return AND:}
"or" {position+=yyleng; return OR;}
"not" {position+=yyleng; return NOT;}
"true" {position+=yyleng; return TRUE;}
"false" {position+=yyleng; return FALSE;}
"return" {position+=yyleng; return RETURN;}

"+" {position+=yyleng; return ADD;}
"-" {position+=yyleng; return SUB;}
"*" {position+=yyleng; reutrn MULT;}
"/" {position+=yyleng; return DIV;}
"%" {position+=yyleng; return MOD;}

"==" {position+=yyleng; return EQ;}
"<>" {position+=yyleng; return NEQ;}
"<" {position+=yyleng; return LT;}
">" {position+=yyleng; return GT;}
"<=" {position+=yyleng; return LTE;}
">=" {position+=yyleng; return GTE;}
":=" {position+=yyleng; return ASSIGN;}

";" {position+=yyleng; return SEMICOLON;}
":" {position+=yyleng; return COLON;}
"," {position+=yyleng; return COMMA;}
"(" {position+=yyleng; return L_PAREN;}
")" {position+=yyleng; return R_PAREN;}
"[" {position+=yyleng; return L_SQUARE_BRACKET;}
"]" {position+=yyleng; return R_SQUARE_BRACKET;}

{letter}{char}*{underscore} {printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", line, position, yytext); }
{letter}{char}*   {printf("IDENT %s\n", yytext); position+=yyleng;}
{digit}+  {printf("NUMBER %s\n", yytext); position += yyleng;}

{space}+ { position+=yyleng;}
{newline} { line++; position = 1;}
{comment} {position+=yyleng;}

({underscore}|{digit})+{letter}* {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line, position, yytext);}
. {printf("Error at line: %d, column: %d: unrecognized symbol: \"%c\"\n", line, position, *yytext); exit(0);}

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "rb");
    } else {
        yyin = stdin;
    }
    yylex();
}
