%{
   #include <stack>
   #include <string>
   using namespace std;
   stack<string> temps;
   int temp_counter = 0;
   string GetNextTemp();
   string GetCurrentTemp();
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
   


   struct str_type {
      string code;
   };





}
// Bison Declarations

%union{
  char* sval;
  int ival;
  dec_type* dec; 
  str_type* str;
  list<string>* lst;
 }

%error-verbose
%start Program

%token <sval> IDENT
%token <sval> NUMBER
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

%type <sval> Program   
%type <dec> Declarations Declaration 
%type <lst> Vars Idents
%type <str> Var Expression Statement MultiplicativeExpr Term Ident Function Functions Statements Expressions

%% /* Grammar Rules */

Program: Functions { cout << $1->code << endl;  };

Functions: /* epsilon */ {  $$ = new str_type();   }
    | Function Functions 
  { 
     $$ = new str_type();
     stringstream ss;
     ss << $1->code << endl << $2->code; 
     $$->code = ss.str();
     
  }
;


Function: FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY 
    {
        $$ = new str_type();
        stringstream ss;

        ss << "func " << $2->code << endl;
        ss << $5->code;

        int i = 0;

       
        for (list<string>::iterator it = $5->ids.begin(); it != $5->ids.end(); it++) {
          ss << "= "<< *it << ", $" << to_string(i) << endl;
          i++;
        }
        

        ss << $8->code;
        ss << $11->code;
        ss << "endfunc";
        $$->code = ss.str();

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

      ss << $1->code << $3->code;

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

        for (list<string>::iterator it = $1->begin(); it != $1->end(); it++) {
            ss << ". " << *it << endl;
            $$->ids.push_back( (*it).c_str() );
        }

        $$->code = const_cast<char*>(ss.str().c_str());

    }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
  { 
      $$ = new dec_type();
      stringstream ss;

      for (list<string>::iterator it = $1->begin(); it != $1->end(); it++) {
          ss << ".[] " << *it << ", " << $5 << endl;
          $$->ids.push_back( (*it).c_str() );
      }
      $$->code = const_cast<char*>(ss.str().c_str());

  }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
        {

        }
  ;




Idents: Ident 
      {
        $$ = new list<string>();
        $$->push_front($1->code);
      }
    | Ident COMMA Idents 
      {
        $$ = $3;
        $$->push_front($1->code);
      }
    ;
Ident: IDENT
 {
    $$ = new str_type();
    string s($1);
    $$->code = s;
}







Statements: /* epsilon */
       { 
          $$ = new str_type();
       }
    | Statement SEMICOLON Statements 
      { 
          $$ = new str_type();

          stringstream ss;

          ss << $1->code  << $3->code << endl;

          $$->code = ss.str();
      }
    ;
Statement: 

    Var ASSIGN Expression 
    { 
       $$ = new str_type();
       stringstream ss;
       ss << $3->code;
       ss << "= " << $1->code << ", " << GetCurrentTemp() << endl;
       $$->code = ss.str();

    }
    | IF BoolExpr THEN Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ENDIF\n");}
    | IF BoolExpr THEN Statements ELSE Statements ENDIF {printf("Statement -> IF BoolExpr THEN Statements ELSE Statements ENDIF\n");}
    | WHILE BoolExpr BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE BoolExpr Statements ENDLOOP\n");}
    | DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");}
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");}
    | READ Vars 
    {
      $$ = new str_type();
      stringstream ss;

      for (auto it = $2->begin(); it != $2->end(); it++) {
          ss << ".< " << *it << endl;
      }
      $$->code = ss.str();
      cout << $$->code << endl;

    }
    | WRITE Vars 
    {

    }
    | CONTINUE 
    {

    }
    | RETURN Expression 
    {

    }
    ;

Vars: Var 
    {
        $$ = new list<string>();
        string s ($1->code);
        $$->push_back(s);
    }
    | Var COMMA Vars 
    {
        $$ = new list<string>();
        string s($1->code);
        $$->push_back(s);

        for (auto it = $3->begin(); it != $3->end(); it++) {
          $$->push_back(*it);
        }
    }
    ;
Var: Ident 
    {
       $$ = new str_type();
       string s($1->code);
       $$->code = s;
    }
    | Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    | Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
    ;


Expressions: /* epsilon */ 
{
  $$ = new str_type();

}
    | Expression 
    {
        $$ = new str_type();
        $$->code = $1->code;
    }
    | Expressions COMMA Expression 
    {
        $$ = new str_type();
        stringstream ss;
        ss << $1 << "\n" << $3->code << endl;
        $$->code = ss.str();
    }
    ;

Expression: MultiplicativeExpr 
    {
        $$ = new str_type();
        $$ = $1;

    }
    | Expression ADD MultiplicativeExpr 
      {

        $$ = new str_type();
        stringstream ss;
        string op1;
        string op2;
        string op3;

        if (  (string($1->code).find("\n") == string::npos) ) {
          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1->code << endl;

        }
        else {
          op1 = temps.top(); temps.pop();
          ss << $1->code;

        }


        if ( string($3->code).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3->code << endl;

        }
        else {
          op2 = temps.top(); temps.pop();
          ss << $3->code;

        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "+, " << op3 << ", " << op1 << ", " << op2 << endl;
        temps.push(op3);
        $$->code = ss.str();


      }
    | Expression SUB MultiplicativeExpr 
    {
        $$ = new str_type();
        stringstream ss;
        string op1;
        string op2;
        string op3;

        if (  (string($1->code).find("\n") == string::npos) ) {
          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1->code << endl;

        }
        else {
          op1 = temps.top(); temps.pop();
          ss << $1->code;

        }


        if ( string($3->code).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3->code << endl;

        }
        else {
          op2 = temps.top(); temps.pop();
          ss << $3->code;

        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "-, " << op3 << ", " << op1 << ", " << op2 << endl;
        temps.push(op3);
        $$->code = ss.str();
    }
    ;

MultiplicativeExpr: Term 
    {
        $$ = new str_type();
        $$->code = $1->code;
    }
    | MultiplicativeExpr MULT Term 
      {
        $$ = new str_type();
        stringstream ss;
        string op1;
        string op2;
        string op3;


        if ( string($1->code).find("\n") == string::npos ) {

          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1->code << endl;
        }

        else {
          op1 = temps.top(); temps.pop();
          ss << $1->code;
        }

        if ( string($3->code).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3->code << endl;
        }
        else {
           op2 = temps.top(); temps.pop();
           ss << $3->code;
        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "*, " << op3 << ", " << op1 << ", " << op2 << endl;
        temps.push(op3);
        $$->code = ss.str();


      }
    | MultiplicativeExpr DIV Term 
      {
        $$ = new str_type();
        stringstream ss;
        string op1;
        string op2;
        string op3;


        if ( string($1->code).find("\n") == string::npos ) {

          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1->code << endl;
        }

        else {
          op1 = temps.top(); temps.pop();
          ss << $1->code;
        }

        if ( string($3->code).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3->code << endl;
        }
        else {
           op2 = temps.top(); temps.pop();
           ss << $3->code;
        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "/, " << op3 << ", " << op1 << ", " << op2 << endl;
        temps.push(op3);
        $$->code = ss.str();
      }
    | MultiplicativeExpr MOD Term 
      {
        $$ = new str_type();
        stringstream ss;
        string op1;
        string op2;
        string op3;


        if ( string($1->code).find("\n") == string::npos ) {

          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1->code << endl;
        }

        else {
          op1 = temps.top(); temps.pop();
          ss << $1->code;
        }

        if ( string($3->code).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3->code << endl;
        }
        else {
           op2 = temps.top(); temps.pop();
           ss << $3->code;
        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "%, " << op3 << ", " << op1 << ", " << op2 << endl;
        temps.push(op3);
        $$->code = ss.str();
      }
    ;

Term: Var 
    {
      $$ = new str_type();
      $$->code = $1->code;
    }
    | NUMBER 
    {
      $$ = new str_type();
      $$->code = $1;
    }
    | L_PAREN Expression R_PAREN {printf("Term -> L_PAREN Expression R_PAREN\n");}
        | SUB Var {printf("Term -> SUB Var\n");}
        | SUB NUMBER {printf("Term -> SUB NUMBER\n");}
        | SUB L_PAREN Expression R_PAREN {printf("Term -> SUB L_PAREN Expression R_PAREN\n");}
    | Ident L_PAREN Expressions R_PAREN {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
    ;




Comparison: EQ {printf("Comparison -> EQ\n");}
    | NEQ {printf("Comparison -> NEQ\n");}
    | LT {printf("Comparison -> LT\n");}
    | GT {printf("Comparison -> GT\n");}
    | LTE {printf("Comparison -> LTE\n");}
    | GTE {printf("Comparison -> GTE\n");}
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

string GetNextTemp() {
  string s = "__temp__" + to_string(temp_counter);
  temp_counter += 1;
  return s;
}

string GetCurrentTemp() {
  string s = "__temp__" + to_string(temp_counter - 1);
  return s;
}
