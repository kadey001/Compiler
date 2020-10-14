%{
    int line = 1; 
    int position = 1;
    // Ints, Ops, Paren, Equal
    int counts[] = { 0, 0, 0, 0 };
%}


digit [0-9]
dec {digit}*"."{digit}+
sci ({digit}|{dec})+[eE][+-]?{digit}+

%%
{digit}+ {printf("NUMBER %s\n", yytext); position+=yyleng; counts[0]++;}
{dec} {printf("DECIMAL %s\n", yytext); position+=yyleng;}
{sci} {printf("SCIENTIFIC %s\n", yytext); position+=yyleng;}
"+" {printf("PLUS\n"); position+=yyleng; counts[1]++;}
"-" {printf("MINUS\n"); position+=yyleng; counts[1]++;}
"*" {printf("MULT\n"); position+=yyleng; counts[1]++;}
"/" {printf("DIV\n"); position+=yyleng; counts[1]++;}
"(" {printf("L_PAREN\n"); position+=yyleng; counts[2]++;}
")" {printf("R_PAREN\n"); position+=yyleng; counts[2]++;}
"=" {printf("EQUAL\n"); position+=yyleng; counts[3]++;}

"\n" {line++; position = 1;}

. {printf("ERROR, Unrecognised Token on line: %d pos: %d\n", line, position); exit(0);}

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "rb");
    } else {
        yyin = stdin;
    }
    yylex();
    printf("Num of Ints: %d\n", counts[0]);
    printf("Num of Operators: %d\n", counts[1]);
    printf("Num of Parentheses: %d\n", counts[2]);
    printf("Num of Equal Signs: %d\n", counts[3]);
}
