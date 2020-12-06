%{
%}

%code requires{
   #include <string>
   #include <list>
   #include <iostream>
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include <sstream>
   void yyerror(const char* msg);
   int yylex();
   extern int currPos;
   extern int currLine;
   using namespace std;



   struct dec_type {
      string code;
      list<string> ids;
   };
   
   struct idents_type {
      list<string> lst;
   };

   struct stmts_type {
      list<string> lst;
   };

}
// Bison Declarations

%union{
  char* sval;
  int ival;
  dec_type* dec; 
  idents_type* idents;
  stmts_type* stmts;
 }

%error-verbose
%start Program

%token <sval> IDENT
%token <ival> NUMBER
%token FUNCTION SEMICOLON TRUE FALSE RETURN
%token BEGIN_PARAMS END_PARAMS BEGIN_LOCALS
%token END_LOCALS BEGIN_BODY END_BODY INTEGER
%token ARRAY OF IF THEN ENDIF ELSE WHILE DO FOR
%token BEGINLOOP ENDLOOP CONTINUE READ WRITE
%token COLON COMMA 

%right ASSIGN
%left OR
%left AND
%right NOT
%left LT LTE GT GTE EQ NEQ 
%left ADD SUB
%left MULT DIV MOD 
%right UMINUS
%left L_SQUARE_BRACKET R_SQUARE_BRACKET
%left L_PAREN R_PAREN

%type <sval> Program Function Functions Ident Statement
%type <dec> Declarations Declaration 
%type <idents> Idents
%type <stmts> Statements

%% /* Grammar Rules */

Program: Functions { cout << $1 << endl;  };

Functions: /* epsilon */ {  $$ = "";   }
    | Function Functions 
  { 
     stringstream ss;
     ss << $1 << endl << $2; 
     $$ = const_cast<char*>(ss.str().c_str());
     
  }
;


Function: FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY 
    {
        stringstream ss;

        ss << "func " << $2 << endl;
        ss << $5->code;

        int i = 0;

       
        for (list<string>::iterator it = $5->ids.begin(); it != $5->ids.end(); it++) {
          ss << *it << " $" << to_string(i) << endl;
          i++;
        }
        

        ss << $8->code;
        ss << "$11";
        ss << "endfunc";
        $$ = const_cast<char*>(ss.str().c_str());

    };


Declarations: /* epsilon */ 
     { 
        $$ = new dec_type();
        $$->ids = list<string>(); 

     }
    | Declaration SEMICOLON Declarations 
  {
      $$ = new dec_type();
      stringstream ss;

      ss << $1->code << "\n" << $3->code;

      $$->code = const_cast<char*>(ss.str().c_str());

      $$->ids = $1->ids;
      for (list<string>::iterator it = $3->ids.begin(); it != $3->ids.end(); it++) {
        $$->ids.push_back( (*it).c_str() );
      }
      
  }
    ;
Declaration: Idents COLON INTEGER 
    {
        $$ = new dec_type();
        stringstream ss;

        for (list<string>::iterator it = $1->lst.begin(); it != $1->lst.end(); it++) {
            ss << ". " << *it << endl;
            $$->ids.push_back( (*it).c_str() );
        }

        $$->code = const_cast<char*>(ss.str().c_str());

    }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
  { 
      $$ = new dec_type();
      stringstream ss;

      for (list<string>::iterator it = $1->lst.begin(); it != $1->lst.end(); it++) {
          ss << ".[] " << *it << ", " << to_string($5) << endl;
          $$->ids.push_back( (*it).c_str() );
      }
      $$->code = const_cast<char*>(ss.str().c_str());

  }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
        {
          printf("xd");
          $$ = new dec_type();
          printf("poop");
        }
  ;




Idents: Ident 
      {
        $$ = new idents_type();
        $$->lst.push_front($1);
      }
    | Ident COMMA Idents 
      {
        $$ = new idents_type();
        $$->lst = $3->lst;
        $$->lst.push_front($1);
      }
    ;
Ident: IDENT { $$ = $1; };













Statements: /* epsilon */
       { 
           $$ = new stmts_type();
           $$->lst = list<string>();
       }
    | Statement SEMICOLON Statements 
      { 
          $$ = new stmts_type();
          stringstream ss;

          printf("Statements-> Statement SEMICOLON Statements\n");
      }
    ;
Statement: Var ASSIGN Expression {  }
    | IF BoolExpr THEN Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ENDIF\n");}
    | IF BoolExpr THEN Statements ELSE Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ELSE Statements ENDIF\n");}
    | WHILE BoolExpr BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE BoolExpr Statements ENDLOOP\n");}
    | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");}
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");}
    | READ Vars {printf("Statement -> Read Vars\n");}
    | WRITE Vars {printf("Statement -> WRITE Vars\n");}
    | CONTINUE {printf("Statement -> CONTINUE\n");}
    | RETURN Expression {printf("Statement -> RETURN\n");}
    ;

Comparison: EQ {printf("Comparison -> EQ\n");}
    | NEQ {printf("Comparison -> NEQ\n");}
    | LT {printf("Comparison -> LT\n");}
    | GT {printf("Comparison -> GT\n");}
    | LTE {printf("Comparison -> LTE\n");}
    | GTE {printf("Comparison -> GTE\n");}
    ;

MultiplicativeExpr: Term {printf("multiplicative-expr -> Term\n");}
    | Term MULT MultiplicativeExpr {printf("multiplicative-expr -> Term MULT MultiplicativeExpr\n");}
    | Term DIV MultiplicativeExpr {printf("multiplicative-expr -> Term DIV MultiplicativeExpr\n");}
    | Term MOD MultiplicativeExpr {printf("multiplicative-expr -> Term MOD MultiplicativeExpr\n");}
    ;

Term: Var {printf("Term -> Var\n");}
    | NUMBER {printf("Term -> NUMBER\n");}
    | L_PAREN Expression R_PAREN {printf("Term -> L_PAREN Expression R_PAREN\n");}
        | SUB Var {printf("Term -> SUB Var\n");}
        | SUB NUMBER {printf("Term -> SUB NUMBER\n");}
        | SUB L_PAREN Expression R_PAREN {printf("Term -> SUB L_PAREN Expression R_PAREN\n");}
    | Ident L_PAREN Expressions R_PAREN {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
    ;



BoolExpr: RelationAndExpr {printf("BoolExpr -> RelationAndExpr\n");} 
    | RelationAndExpr OR BoolExpr {printf("BoolExpr -> RelationAndExpr OR RelationAndExpr\n");}
    ;

RelationAndExpr: RelationExpr {printf("RelationAndExpr -> RelationExpr\n");}
    | RelationExpr AND RelationAndExpr {printf("RelationAndExpr -> RelationExpr AND RelationAndExpr\n");}
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
    | Expression {printf("Expressions -> Expression\n");}
    | Expression COMMA Expressions {printf("Expressions -> Expression COMMA Expressions\n");}
    ;
Expression: MultiplicativeExpr {printf("Expression -> MultiplicativeExpr\n");}
    | MultiplicativeExpr ADD Expression {printf("MultiplicativeExpr ADD Expression\n");}
    | MultiplicativeExpr SUB Expression {printf("MultiplicativeExpr SUB Expression\n");}
    ;

Vars: Var {printf("Vars -> Var\n");}
    | Var COMMA Vars {printf("Vars -> Var COMMA Vars\n");}
    ;
Var: Ident {printf("Var -> IDENT\n");}
    | Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    | Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    ;

%%
// Additional C Code
int main (int argc, char* argv[]) {
  if (argc > 1) {
        FILE* yyin = fopen(argv[1], "r");
        if (yyin == NULL){
            printf("syntax: %s filename\n", argv[0]);
        }//end if
   }//end if
   yyparse(); // Calls yylex() for tokens.
   return 0;
}

void yyerror(const char* msg) {
    printf("* Line %d, position %d: %s\n", currLine, currPos, msg);
}

