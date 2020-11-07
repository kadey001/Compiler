%{
#include "stdio.h"
#include "string.h"
#include "y.tab.h"
extern int line;
extern int position;
int yyerror(const char *msg);
int yylex();
%}

%union{
  char* cval;
  int ival;
}

%token	FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF
		IF THEN ENDIF ELSE WHILE DO FOR BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE
		RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE IDENT NUMBER SEMICOLON COLON COMMA L_PAREN
		R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN

%type<cval> IDENT
%type<ival> NUMBER


%right ASSIGN
%left OR
%left AND
%right NOT
%left LT LTE GT GTE EQ NEQ
%left ADD SUB
%left MULT DIV MOD
/*%right SUB*/
%left L_SQUARE_BRACKET R_SQUARE_BRACKET
%left L_PAREN R_PAREN

%start	program 


%%

program: /* epsilon */ {printf("program -> epsilon\n");}
		| program function {printf("program -> program functtion\n");}
		;

function: FUNCTION IDENT SEMICOLON {printf("function -> FUNCTION IDENT SEMICOLON\n");}
		;


%%

int main(int argc, char** argv) {
	yyparse();
	return 0;
}

int yyerror(const char* msg) {
 	printf("Syntax Error: in line %d, position: %d:%s\n", line, position, msg);
}

