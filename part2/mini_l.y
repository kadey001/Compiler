%{
  // C Declarations
  #include <stdlib.h>
  void yyerror(const char* s);
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

%%
// Grammar Rules

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
