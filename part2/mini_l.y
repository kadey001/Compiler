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

Program: /* epsilon */ {printf("Program -> epsilon\n");}
    | Program Functions {printf("Program -> Program Function\n");}
    ;

Functions: /* epsilon */ {printf("Functions -> epsilon\n");}
    | Function Functions {printf("Functions -> Function Functions\n");}
    ;
Function: FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY {printf("Function -> FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n");};

Statements: /* epsilon */ {printf("Statements -> epsilon\n");}
    | Statement SEMICOLON Statements {printf("Statements-> Statement SEMICOLON Statements\n");}
    ;
Statement: Var ASSIGN Expression {printf("\n");}
    | IF BoolExpr THEN Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ENDIF\n");}
    | IF BoolExpr THEN Statements ELSE Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ELSE Statements ENDIF\n");}
    | WHILE BoolExpr BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE BoolExpr Statements ENDLOOP\n");}
    | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");}
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");}
    | READ Vars {printf("Statement -> Read Vars\n");}
    | WRITE Vars {printf("Statement -> WRITE Vars\n");}
    | CONTINUE {printf("Statement -> CONTINUE\n");}
    | RETURN {printf("Statement -> RETURN\n");}
    ;

Comparison: EQ {printf("Comparison -> EQ\n");}
    | NEQ {printf("Comparison -> NEQ\n");}
    | LT {printf("Comparison -> LT\n");}
    | GT {printf("Comparison -> GT\n");}
    | LTE {printf("Comparison -> LTE\n");}
    | GTE {printf("Comparison -> GTE\n");}
    ;

MultiplicativeExpr: Term {printf("multiplicative-expr -> Term\n");}
    | Term MULT Term {printf("multiplicative-expr -> Term MULT Term\n");}
    | Term DIV Term {printf("multiplicative-expr -> Term DIV Term\n");}
    | Term MOD Term {printf("multiplicative-expr -> Term MOD Term\n");}
    ;

Term: Var {printf("Term -> Var\n");}
    | NUMBER {printf("Term -> NUMBER\n");}
    | L_PAREN Expression R_PAREN {printf("Term -> L_PAREN Expression R_PAREN\n");}
        | SUB Var {printf("Term -> SUB Var\n");}
        | SUB NUMBER {printf("Term -> SUB NUMBER\n");}
        | SUB L_PAREN Expression R_PAREN {printf("Term -> SUB L_PAREN Expression R_PAREN\n");}
    | IDENT L_PAREN Expressions R_PAREN {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
    ;

Declarations: /* epsilon */ {printf("Declarations -> epsilon\n");}
    | Declaration SEMICOLON Declarations {printf("Declarations -> Declaration SEMICOLON Declarations\n");}
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

RelationExpr: Expression Comparison Expression {printf("RelationExpr -> Expression Comp Expression\n");}
    | TRUE {printf("RelationExpr -> TRUE\n");}
    | FALSE {printf("RelationExpr -> FALSE\n");}
    | L_PAREN BoolExpr R_PAREN {printf("RelationExpr -> L_PAREN BoolExpr R_PAREN\n");}
        | NOT Expression Comparison Expression {printf("RelationExpr -> NOT Expression Comp Expression\n");}
        | NOT TRUE {printf("RelationExpr -> NOT TRUE\n");}
        | NOT FALSE {printf("RelationExpr -> NOT FALSE\n");}
        | NOT L_PAREN BoolExpr R_PAREN {printf("RelationExpr -> NOT L_PAREN BoolExpr R_PAREN\n");}
        ;

Expressions: /* epsilon */ {printf("Expressions -> epsilon\n");}
    | Expression COMMA Expressions {printf("Expressions -> Expression COMMA Expressions\n");}
    ;
Expression: MultiplicativeExpr {printf("Expression -> MultiplicativeExpr\n");}
    | MultiplicativeExpr ADD MultiplicativeExpr {printf("MultiplicativeExpr ADD MultiplicativeExpr\n");}
    | MultiplicativeExpr SUB MultiplicativeExpr {printf("MultiplicativeExpr SUB MultiplicativeExpr\n");}
    ;

Vars: /* epsilon */ {printf("Vars -> epsilon\n");}
    | Var COMMA Vars {printf("Vars -> Var COMMA Vars\n");}
    ;
Var: IDENT {printf("Var -> IDENT\n");}
    | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    ;

%%
// Additional C Code
int main (int argc, char* argv[]) {
	if (argc > 1) {
		yyin = fopen(argv[1], "r");
		if (yyin == NULL) {
			printf("syntax: %s filename\n", argv[0]);
		}
	}
	yyparse();
	return 0;
}
void yyerror(const char* msg) {
    printf("* Line %d, position %d: %s\n", currLine, currPos, msg);
}
