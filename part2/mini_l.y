%{
  // C Declarations
  #include <stdio.h>
  #include <stdlib.h>
  void yyerror(const char *msg);
  extern int currLine;
  extern int currPos;
  FILE * yyin;
%}
// Bison Declarations

%union{
  char* ident_val;
  int num_val;
 }

%error-verbose
%start program

%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token FOR
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token READ
%token WRITE
%left AND
%left OR
%right NOT
%token TRUE
%token FALSE
%token RETURN

%left SUB
%left ADD
%left MULT
%left DIV
%left MOD

%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE

%token <ident_val> IDENT
%token <num_val> NUMBER

%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%left ASSIGN

%% /* Grammar Rules */

program: /* epsilon */ {printf("program -> epsilon\n");}
		| program function {printf("program -> program function\n");}
		;

function: FUNCTION IDENT SEMICOLON {printf("function -> FUNCTION IDENT SEMICOLON\n");}
    | 
		;

comparison: EQ {printf("comparison -> EQ\n");}
    | NEQ {printf("comparison -> NEQ\n");}
    | LT {printf("comparison -> LT\n");}
    | GT {printf("comparison -> GT\n");}
    | LTE {printf("comparison -> LTE\n");}
    | GTE {printf("comparison -> GTE\n");}
    ;

multiplicative-expr: term {printf("multiplicative-expr -> term\n");}
    | term MULT term {printf("multiplicative-expr -> term MULT term\n");}
    | term DIV term {printf("multiplicative-expr -> term DIV term\n");}
    | term MOD term term {printf("multiplicative-expr -> term MOD term\n");}
    ;

var: IDENT {printf("var -> IDENT\n");}
    | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT [ expression ]\n");}
    | IDENT L_SQUARE_BRACKET expression R_SQUARE_BRACKET L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> IDENT [ expression ] [ expression ]\n");}
    ;

ident: IDENT {prtinf("IDENT: \s", $1)}

%%
// Additional C Code

void yyerror(const char* s) {
  int line;
  char* yytext;

  printf("ERROR: %s on line %d at symbol %s", s, line, yytext)
  exit(1);
}