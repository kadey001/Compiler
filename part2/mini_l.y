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


%%
// Additional C Code

void yyerror(const char* s) {
  int line;
  char* yytext;

  printf("ERROR: %s on line %d at symbol %s", s, line, yytext)
  exit(1);
}