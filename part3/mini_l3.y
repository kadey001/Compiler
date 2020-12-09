%{
  #define YY_NO_UNPUT
  #include <iostream>
  #include <sstream>
  #include <string>
  #include <string.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <stack>
  #include <map>
  using namespace std;

  int yylex();
  void yyerror(string msg);
  void yyerror(const char* msg);

  extern int currPos;
  extern int currLine;

  int temp_counter = 0;
  int label_counter = 0;
  int param_counter = 0;
  bool main_exists = true;
  struct Symbol {
    string name;
    string type; // Includes "INTEGER", "ARRAY", "FUNCTION"
    int value;
    int size;

    Symbol() {
      this->name = "";
      this->type = "";
      this->value = 0;
      this->size = 0;
    }
    Symbol(string name, string type, int val, int size) {
      this->name = name;
      this->type = type;
      this->value = 0;
      this->size = 0;
    }
  };
  struct Function {
    string name;
    Function() {
      this->name = "";
    }
    Function(string name) {
      this->name = name;
    }
  };
  map<string, Symbol> symbol_table;
  map<string, Function> function_table;

  stack<string> temp_stack;
  stack<string> ident_stack;
  stack<string> variable_stack;
  stack<string> label_stack;
  stack<string> param_stack;
  stack<string> expression_stack;

  void ReadBuffer();
  string GetNextTemp();
  string GetCurrentTemp();
  string GetLabel();
  string GetParam();
  bool ValidateSymbol(string symbol);

  stringstream output;
  stringstream buffer;
%}
// Bison Declarations

%code requires{
  using namespace std;
}

/*%code requires{
  #include <string>
  #include <list>
  #include <iostream>
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <sstream>
  void yyerror(string msg);
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
    bool array;
    list<string> expressions;
  };

  struct attribute_type {
    string name;
    string index;
    string type; 
    int val;
    int size_attr;
  };

  void ReadBuffer();
  string GetNextTemp();
  string GetCurrentTemp();
  string GetLabel();
  string GetParam();
  bool ValidateSymbol(string symbol);
}*/

%union{
  char* sval;
  int ival;
  // dec_type* dec; 
  // idents_type* idents;
  // attribute_type* attr;
  struct attribute_type {
    string name;
    string index;
    string type; 
    int val;
    int size_attr;
  } attr;
}

%error-verbose
%debug
%start Start

%token	FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE FOR DO BEGINLOOP ENDLOOP END_BODY
%token CONTINUE READ WRITE TRUE FALSE 

%token MULT DIV MOD ADD SUB 
%token LT LTE GT GTE EQ NEQ

%token SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET RETURN

%token <ival> NUMBER
%token <sval> IDENT

%right ASSIGN
%right NOT
%left AND OR
%left ADD SUB MULT DIV
%left L_SQUARE_BRACKET R_SQUARE_BRACKET
%left L_PAREN R_PAREN

// %type <sval> Program Function Functions Statement Statements Term Expressions Expression MultiplicativeExpr 
// %type <dec> Declarations Declaration 
// %type <idents> Idents Vars Ident Var

%type <attr> Function Statement Statements Term Expressions Expression MultiplicativeExpr Declarations Declaration Idents Vars Ident Var BoolExpr

%% /* Grammar Rules */

Start: Program { if(!main_exists){yyerror("error: main not declared");} };

Program: /* epsilon */
  | Function Program
  ;

Function: FUNCTION IDENT {
  buffer << "FUNCTION " << string($2) << endl;
} SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY 
  {
    output << "END FUNCTION" << string($2) << endl;
    // Clear symbol table and param stack
    symbol_table.clear();
    while (!param_stack.empty()) {
      param_stack.pop();
    }
    Function f = Function($2);

    if (function_table.find(f.name) == function_table.end()) {
      function_table.at(f.name) = f;
    } else {
      string err = "error: function: " + f.name + " already exists!";
      yyerror(err);
    }
  };

Declarations: /* epsilon */ 
    {
      while (!param_stack.empty()) {
        buffer << "= " << param_stack.top() << ", " << "$" << GetParam() << endl;
        param_stack.pop();
      }
    }
    | Declaration SEMICOLON Declarations;

Declaration: IDENT COLON INTEGER 
    {
      ident_stack.push($1);
      param_stack.push($1);

      while (!ident_stack.empty()) {
        string s = ident_stack.top();
        ident_stack.pop();
        Symbol symbol(s, "INTEGER", 0, 0);

        // Add to symbol table if it doesn't exist
        if (symbol_table.find(symbol->name) == symbol_table.end()) {
          symbol_table.at(symbol->name) = symbol;
        } else {
          string err = "Symbol: " + s->name + " already exists.";
          yyerror(err);
        }

        buffer << ". " << s << endl;
      }
    }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
    { 
      ident_stack.push($1);
      param_stack.push($1);
      ident_stack.pop();
      Symbol symbol(s, "ARRAY", 0, $5);

      while (!ident_stack.empty()) {
        if (symbol_table.find(symbol->name) == symbol_table.end()) {
            symbol_table.at(symbol->name) = symbol;
        } else {
          string err = "Symbol: " + s->name + " already exists.";
          yyerror(err);
        }

        buffer << ". " << s << endl;
      }
    }
    | Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
    {
      // ident_stack.push($1);
      // param_stack.push($1);
      // ident_stack.pop();
      // Symbol symbol(0, $5, s, "ARRAY");

      // while (!ident_stack.empty()) {
      //   if (symbol_table.find(symbol->name) == symbol_table.end()) {
      //       symbol_table.at(symbol->name) = symbol;
      //   } else {
      //     string err = "Symbol: " + s->name + " already exists.";
      //     yyerror(err);
      //   }

      //   buffer << ". " << s << endl;
      // }
    }
  ;

Idents: Ident
    | Ident COMMA Idents
    ;
Ident: IDENT {
  ident_stack.push($1);
  param_stack.push($1);
};


Vars: Var
  | Var COMMA Vars
  ;
Var: IDENT
  {
    if (symbol_table.find($1) == symbol_table.end()) {
      string err = "Symbol: " + $1 + " not declared: ";
      yyerror(err);
    }
    if (symbol_table.at($1).type == "ARRAY") {
      yyerror("Symbol is type ARRAY");
    } else {
      strcpy($$.name, $1);
      $$->type = "INTEGER";
    }
  }
  | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
  {
    // TODO Add ident to map/list/set
    // printf("Var -> Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");
    if (symbol_table.find($1) == symbol_table.end()) {
      string err = "Symbol: " + $1 + " not declared: ";
      yyerror(err);
    }
    if (symbol_table.at($1)->type == "INTEGER") {
      yyerror("Symbol is type INTEGER");
    } else {
      if
    }
  //   $$ = new idents_type();
  //   $$->array = true;
  //   $$->lst.push_front($1);
  //   $$->expressions.push_front($3);
  }
  | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
  {
    // TODO Add ident to map/list/set
    printf("Var -> Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");
    // $$ = new idents_type();
    // $$->array = true;
    // $$->lst.push_front($1);
    // $$->expressions.push_front($3);
    // $$->expressions.push_front($6);
  }
  ;

Term: Var 
  {
    $$ = $1;
  }
  | NUMBER 
  {
    $$ = $1;
  }
  | L_PAREN Expression R_PAREN {printf("Term -> L_PAREN Expression R_PAREN\n");}
      | SUB Var {printf("Term -> SUB Var\n");}
      | SUB NUMBER {printf("Term -> SUB NUMBER\n");}
      | SUB L_PAREN Expression R_PAREN {printf("Term -> SUB L_PAREN Expression R_PAREN\n");}
  | IDENT L_PAREN Expressions R_PAREN {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
  ;

Statements: Statement SEMICOLON Statements;
Statement: 
    Var ASSIGN Expression 
    { 
      if ($1->type == "INTEGER") {
        string s = "= " + $1->name + ", " + $3->name;
        buffer << s << endl;
      } else {
        string s = "[]= " << $1->name + ", " + $1->index + ", " + $3->name;
        buffer << s << endl;
      }
      ReadBuffer();
    }
    | IF BoolExpr THEN {
      string start = GetLabel();
      string endif = GetLabel();
      label_stack.push(endif); 
      string s = "?:= " + start + ", " + $2->name;
      buffer << s << endl;
      buffer << ":= " << endif << endl;
      buffer << ": " << start << endl;
    } 
    Statements Else ENDIF {
      string s = ": " + label_stack.top();
      label_stack.pop();
      buffer << s << endl;
      ReadBuffer();
    }
    | WHILE BoolExpr BEGINLOOP {
      string condition = GetLabel();
      string end = GetLabel();
      string start = GetLabel();

      label_stack.push(start);
      label_stack.push(end);

      output << ": " << start << endl;
      ReadBuffer();

      string s = "?:= " + condition + ", " + $2->name;
      buffer << s << endl;
      buffer << ":= " << end << endl;
      buffer << ": " << condition << endl;

    } Statements ENDLOOP {
      ReadBuffer();

      string end = label_stack.top();
      label_stack.pop();
      string start = label_stack.top();
      label_stack.pop();

      buffer << ":= " << start << endl;
      buffer << ": " << end << endl;

      ReadBuffer();
    }
    | DO BEGINLOOP {
      string start = GetLabel();
      label_stack.push(start);

      output << ": " << start << endl;
      ReadBuffer();
    } Statements ENDLOOP WHILE BoolExpr {
      // printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");
      string start = label_stack.top();
      label_stack.pop();
      string s = "?:= " + start + ", " + $4->name;
      buffer << s << endl;
      ReadBuffer();
    }
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {
      // printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");

    }
    | READ Vars {
      // printf("Statement -> Read Vars\n");
      variable_stack.push($2->name);
      while (!variable_stack.empty()) {
        if ($2->type == "INTEGER") {
          buffer << ".< " << variable_stack.top() << endl;
          variable_stack.pop();
        } else {
          string s = ".[]< " + variable_stack.top() + ", " + $2->index;
          variable_stack.pop();
          buffer << s << endl;
        }
      }
      ReadBuffer();
    }
    | WRITE Vars {
      // printf("Statement -> WRITE Vars\n");
      variable_stack.push($2->name);
      while (!variable_stack.empty()) {
        if ($2->type == "INTEGER") {
          buffer << ".> " << variable_stack.top() << endl;
          variable_stack.pop();
        } else {
          string s = ".[]> " + variable_stack.top() + ", " + $2->index;
          variable_stack.pop();
          buffer << s << endl;
        }
      }
      ReadBuffer();
    }
    | CONTINUE {
      // printf("Statement -> CONTINUE\n");
      if (!label_stack.empty()) {
        buffer << ":= " << label_stack.top() << endl;
        label_stack.pop();
        ReadBuffer();
      } else {
        yyerror("Error: Can't use CONTINUE outside of a loop");
      }
    }
    | RETURN Expression {
      // printf("Statement -> RETURN\n");
      $$->val = $2->val;
      strcpy($$.name, $2.name);
      string s = "RETURN: " + $2->name;
      buffer << s << endl;
      ReadBuffer();
    }
    ;

Else: /* epsilon */
  | ELSE {
    string else_label = GetLabel();
    buffer << ":= " << else_label << endl;
    buffer << ": " label_stack.top() << endl;
    label_stack.pop();
    label_stack.push(else_label);
  } Statements
  ;

Expressions: /* epsilon */ 
{
  $$ = "";
}
    | Expression 
    {
        $$ = $1;
    }
    | Expressions COMMA Expression 
    {
        stringstream ss;
        ss << $1 << "\n" << $3 << endl;
        $$ = const_cast<char*>(ss.str().c_str());
    }
    ;
Expression: MultiplicativeExpr 
    {
        $$ = $1;

    }
    | Expression ADD MultiplicativeExpr 
      {
        stringstream ss;
        string op1;
        string op2;
        string op3;

        if (  (string($1).find("\n") == string::npos) ) {
          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1 << endl;

        }
        else {
          op1 = temp_stack.top(); temp_stack.pop();
          ss << $1;

        }


        if ( string($3).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3 << endl;

        }
        else {
          op2 = temp_stack.top(); temp_stack.pop();
          ss << $3;

        }
        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "+, " << op3 << ", " << op1 << ", " << op2 << endl;
        temp_stack.push(op3);
        $$ = const_cast<char*>(ss.str().c_str());
      }
    | Expression SUB MultiplicativeExpr 
    {
        stringstream ss;
        string op1;
        string op2;
        string op3;

        if (  (string($1).find("\n") == string::npos) ) {
          op1 = GetNextTemp();
          ss << ". " << op1 << endl;
          ss << "= " << op1 << ", " << $1 << endl;

        }
        else {
          op1 = temp_stack.top(); temp_stack.pop();
          ss << $1;

        }


        if ( string($3).find("\n") == string::npos ) {
          op2 = GetNextTemp();
          ss << ". " << op2 << endl;
          ss << "= " << op2 << ", " << $3 << endl;

        }
        else {
          op2 = temp_stack.top(); temp_stack.pop();
          ss << $3;

        }

        op3 = GetNextTemp();
        ss << ". " << op3 << endl;
        ss << "-, " << op3 << ", " << op1 << ", " << op2 << endl;
        temp_stack.push(op3);
        $$ = const_cast<char*>(ss.str().c_str());
    };

MultiplicativeExpr: Term 
  {
    $$ = $1;
  }
  | MultiplicativeExpr MULT Term 
    {
      stringstream ss;
      string op1;
      string op2;
      string op3;

      if ( string($1).find("\n") == string::npos ) {

        op1 = GetNextTemp();
        ss << ". " << op1 << endl;
        ss << "= " << op1 << ", " << $1 << endl;
      }

      else {
        op1 = temp_stack.top(); temp_stack.pop();
        ss << $1;
      }

      if ( string($3).find("\n") == string::npos ) {
        op2 = GetNextTemp();
        ss << ". " << op2 << endl;
        ss << "= " << op2 << ", " << $3 << endl;
      }
      else {
          op2 = temp_stack.top(); temp_stack.pop();
        ss << $3;
      }

      op3 = GetNextTemp();
      ss << ". " << op3 << endl;
      ss << "*, " << op3 << ", " << op1 << ", " << op2 << endl;
      temp_stack.push(op3);
      $$ = const_cast<char*>(ss.str().c_str());
    }
  | MultiplicativeExpr DIV Term 
    {
      stringstream ss;
      string op1;
      string op2;
      string op3;

      if ( string($1).find("\n") == string::npos ) {

        op1 = GetNextTemp();
        ss << ". " << op1 << endl;
        ss << "= " << op1 << ", " << $1 << endl;
      }

      else {
        op1 = temp_stack.top(); temp_stack.pop();
        ss << $1;
      }

      if ( string($3).find("\n") == string::npos ) {
        op2 = GetNextTemp();
        ss << ". " << op2 << endl;
        ss << "= " << op2 << ", " << $3 << endl;
      }
      else {
          op2 = temp_stack.top(); temp_stack.pop();
        ss << $3;
      }

      op3 = GetNextTemp();
      ss << ". " << op3 << endl;
      ss << "/, " << op3 << ", " << op1 << ", " << op2 << endl;
      temp_stack.push(op3);
      $$ = const_cast<char*>(ss.str().c_str());
    }
  | MultiplicativeExpr MOD Term 
    {
      stringstream ss;
      string op1;
      string op2;
      string op3;

      if ( string($1).find("\n") == string::npos ) {

        op1 = GetNextTemp();
        ss << ". " << op1 << endl;
        ss << "= " << op1 << ", " << $1 << endl;
      }

      else {
        op1 = temp_stack.top(); temp_stack.pop();
        ss << $1;
      }

      if ( string($3).find("\n") == string::npos ) {
        op2 = GetNextTemp();
        ss << ". " << op2 << endl;
        ss << "= " << op2 << ", " << $3 << endl;
      }
      else {
          op2 = temp_stack.top(); temp_stack.pop();
        ss << $3;
      }

      op3 = GetNextTemp();
      ss << ". " << op3 << endl;
      ss << "%, " << op3 << ", " << op1 << ", " << op2 << endl;
      temp_stack.push(op3);
      $$ = const_cast<char*>(ss.str().c_str());
    };

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
   // TODO output the mil code to file
   return 0;
}

void yyerror(string msg) {
  printf("* Line %d, position %d: %s\n", currLine, currPos, msg.c_str());
}

void yyerror(const char* msg) {
  printf("* Line %d, position %d: %s\n", currLine, currPos, msg);
}

void ReadBuffer() {
  output << buffer.rdbuf();
  buffer.clear();
  buffer.str(" ");
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

string GetLabel() {
  string s = "__label__" + to_string(label_counter);
  label_counter += 1;
  return s;
}

string GetParam() {
  string s = to_string(param_counter);
  param_counter += 1;
  return s;
}

bool ValidateSymbol(string symbol) {
  if(symbol_table.find(symbol) == symbol_table.end()) {
    return false;
  } else {
    return true;
  }
}