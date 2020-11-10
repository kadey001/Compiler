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
%start Program

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

Functions: %empty {printf("Functions -> epsilon\n");};
    | Function Functions {printf("Functions -> Function Functions\n");}
    ;
Function: FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY {printf("Function -> FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n");};

Statements: %empty {printf("Statements -> epsilon\n");}
    | Statement SEMICOLON Statements {printf("Statements-> Statement SEMICOLON Statements\n");}
    ;
Statement: Var ASSIGN Expression {printf("\n");}
    | IF BoolExpr THEN Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ENDIF\n");}
    | IF BoolExpr THEN Statements ELSE Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ELSE Statements ENDIF\n");}
    | WHILE BoolExpr BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE BoolExpr Statements ENDLOOP\n");}
    | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");}
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");}
    | READ Vars {printf("Statement -> Read Vars\n");}
    | Write Vars {printf("Statement -> Write Vars\n");}
    | CONTINUE {printf("Statement -> CONTINUE\n");}
    | RETURN {printf("Statement -> RETURN\n");}
    ;

Comparison: EQ {printf("comparison -> EQ\n");}
    | NEQ {printf("comparison -> NEQ\n");}
    | LT {printf("comparison -> LT\n");}
    | GT {printf("comparison -> GT\n");}
    | LTE {printf("comparison -> LTE\n");}
    | GTE {printf("comparison -> GTE\n");}
    ;

MultiplicativeExpr: term {printf("multiplicative-expr -> term\n");}
    | term MULT term {printf("multiplicative-expr -> term MULT term\n");}
    | term DIV term {printf("multiplicative-expr -> term DIV term\n");}
    | term MOD term term {printf("multiplicative-expr -> term MOD term\n");}
    ;

Program: /* epsilon */ {printf("program -> epsilon\n");}
	  | Program Function {printf("program -> program function\n");}
	  ;

Declaration: IDENT COMMA Declaration {printf("Declaration -> IDENT COMMA Declaration\n");}
	  | IDENT COLON INTEGER {printf("Declaration -> IDENT COLON INTEGER\n");}
	  | IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("Declaration -> IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
	  | IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {printf("Declaration -> IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
	  ;

BoolExpr: RelationAndExpr {printf("BoolExpr -> RelationAndExpr\n");} 
	  | RelationAndExpr OR RelationAndExpr {printf("BoolExpr -> RelationAndExpr OR RelationAndExpr\n");}
	  ;

RelationAndExpr: RelationExpr {printf("RelationAndExpr -> RelationExpr\n");}
    | RelationExpr AND RelationExpr {printf("RelationAndExpr -> RelationExpr AND RelationExpr\n");}
    ;

RelationExpr: Expression Comp Expression {printf("RelationExpr -> Expression Comp Expression\n");}
	  | TRUE {printf("RelationExpr -> TRUE\n");}
	  | FALSE {printf("RelationExpr -> FALSE\n");}
	  | L_PAREN BoolExpr R_PAREN {printf("RelationExpr -> L_PAREN BoolExpr R_PAREN\n");}
	  | NOT Expression Comp Expression {printf("RelationExpr -> NOT Expression Comp Expression\n");}
	  | NOT TRUE {printf("RelationExpr -> NOT TRUE\n");}
        | NOT FALSE {printf("RelationExpr -> NOT FALSE\n");}
        | NOT L_PAREN BoolExpr R_PAREN {printf("RelationExpr -> NOT L_PAREN BoolExpr R_PAREN\n");}
        ;

Expression: MultiplicativeExpr {printf("Expression -> MultiplicativeExpr\n");}
	  | MultiplicativeExpr PLUS MultiplicativeExpr {printf("MultiplicativeExpr PLUS MultiplicativeExpr\n");}
	  | MultiplicativeExpr SUB MultiplicativeExpr {printf("MultiplicativeExpr SUB MultiplicativeExpr\n");}
	  ;

Vars: %empty {printf("Vars -> epsilon\n");}
    | Var COMMA Vars {printf("Vars -> Var COMMA Vars\n");}
    ;
Var: IDENT {printf("Var -> IDENT\n");}
	| IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
	| IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
	;


%%
// Additional C Code

void yyerror(const char* s) {
  int line;
  char* yytext;

  printf("ERROR: %s on line %d at symbol %s", s, line, yytext)
  exit(1);
}
