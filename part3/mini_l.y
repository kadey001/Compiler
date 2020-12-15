%{
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
  struct Funct {
    string name;
    Funct() {
      this->name = "";
    }
    Funct(string name) {
      this->name = name;
    }
  };
  map<string, Symbol> symbol_table;
  map<string, Funct> function_table;

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

%union{
  char* sval;
  int ival;
  // dec_type* dec; 
  // idents_type* idents;
  struct attribute_type {
    char name[255];
    char index[255];
    char type[255]; 
    int val;
    int size_attr;
  } attr;
  // attribute_type attr;
}

%error-verbose
%debug
%start Program

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY
%token INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE FOR DO BEGINLOOP ENDLOOP END_BODY
%token CONTINUE READ WRITE TRUE FALSE RETURN

%token MULT DIV MOD ADD SUB 
%token LT LTE GT GTE EQ NEQ

%token SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET

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

%type <attr> Statement Term Expression MultiplicativeExpr RelationExpr RelExpr RelationAndExpr Declaration Var BoolExpr
%type <sval> Comparison

%% /* Grammar Rules */

Program: Functions;

Functions: /* epsilon */
  | Function Functions;

Function: FUNCTION IDENT {
    buffer << "func " << string($2) << endl;
    Funct f = Funct($2);
    // Add function to table and ensure it hasn't already been declared.
    if (function_table.find($2) == function_table.end()) {
      function_table[f.name] = f;
    } else {
      string err = "error: function: " + f.name + " already exists!";
      yyerror(err);
    }
  } SEMICOLON BEGIN_PARAMS Declarations {
    while (!param_stack.empty()) {
      buffer << "= " << param_stack.top() << ", $" << param_counter << endl;
      param_counter += 1;
      param_stack.pop(); 
    }
  } END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY 
    {
      output << "endfunc" << endl << endl;
      // Clear symbol table and param stack
      symbol_table.clear();
      while (!param_stack.empty()) {
        param_stack.pop();
      }
    };

Declarations: /* epsilon */
  | Declaration SEMICOLON Declarations
  ;
Declaration: IDENT Idents COLON INTEGER 
  {
    ident_stack.push($1);
    param_stack.push($1);

    while (!ident_stack.empty()) {
      string ident = ident_stack.top();
      ident_stack.pop();
      Symbol symbol(ident, "INTEGER", 0, 0);

      // Add to symbol table if it doesn't exist
      if (symbol_table.find(symbol.name) == symbol_table.end()) {
        symbol_table[symbol.name] = symbol;
      } else {
        string err = "Symbol: " + ident + " already exists.";
        yyerror(err);
      }

      buffer << ". " << ident << endl;
    }
  }
  | IDENT Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
  { 
    ident_stack.push($1);
    param_stack.push($1);

    while (!ident_stack.empty()) {
      string ident = ident_stack.top();
      ident_stack.pop();
      Symbol symbol(ident, "ARRAY", 0, $6);
      if (symbol_table.find(symbol.name) == symbol_table.end()) {
          symbol_table[symbol.name] = symbol;
      } else {
        string err = "Symbol: " + ident + " already exists.";
        yyerror(err);
      }

      buffer << ".[] " << ident << ", " << $6 << endl;
    }
  }
  | IDENT Idents COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER 
  {}
  ;

Idents: /* epsilon */
  | COMMA IDENT Idents {
    ident_stack.push($2);
    param_stack.push($2);
  }
  ;


Vars: 
  | COMMA Var Vars {
    variable_stack.push($2.name);
  }
  ;
Var: IDENT
  {
    string val($1);
    if (symbol_table.find(val) == symbol_table.end()) {
      string err = "Symbol: " + string($1) + " not declared";
      yyerror(err);
    }
    if (symbol_table[$1].type == "ARRAY") {
      yyerror("Symbol is type ARRAY");
    } else {
      strcpy($$.name, val.c_str());
      strcpy($$.type, "INTEGER");
    }
  }
  | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
  {
    // TODO Add ident to map/list/set
    // printf("Var . Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");
    string val($1);
    if (symbol_table.find(val) == symbol_table.end()) {
      string err = "Symbol: " + val + " not declared";
      yyerror(err);
    }
    if (symbol_table[val].type == "INTEGER") {
      yyerror("Symbol is type INTEGER");
    } else {
      if (strcmp($3.type, "ARRAY") == 0) {
        string temp = GetNextTemp();
        strcpy($$.type, "ARRAY");
        strcpy($$.index, temp.c_str());
        strcpy($$.name, val.c_str());

        buffer << ". " << temp << endl;
        buffer << "=[] " << temp << ", " << $3.name << ", " << $3.index << endl;
      } else {
        strcpy($$.name, val.c_str());
        strcpy($$.type, "ARRAY");
        strcpy($$.index, $3.name);
      }
    }
  }
  | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET 
  {
    // TODO Add ident to map/list/set
    // printf("Var . Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");

    string val($1);
    if (symbol_table.find(val) == symbol_table.end()) {
      string err = "Symbol: " + val + " not declared";
      yyerror(err);
    }
    if (symbol_table[val].type == "INTEGER") {
      yyerror("Symbol is type INTEGER");
    } 
    else {
      if (strcmp($3.type, "ARRAY") == 0) {
        string temp = GetNextTemp();
        strcpy($$.type, "ARRAY");
        strcpy($$.index, temp.c_str());
        strcpy($$.name, val.c_str());

        int ind = ( atoi($3.index) * $3.size_attr) + ( atoi($6.index) - 1);

        buffer << ". " << temp << endl;
        buffer << "=[] " << temp << ", " << $3.name << ", " << to_string(ind) << endl;
      } 
      else {
        strcpy($$.name, val.c_str());
        strcpy($$.type, "ARRAY");
        strcpy($$.index, $3.name);
      }
    }
  }
  ;

Term: Var 
  {
    $$.val = $1.val;
    strcpy($$.type, $1.type);
    if (strcmp($1.type, "ARRAY") == 0) {
      string temp = GetNextTemp();
      strcpy($$.name, temp.c_str());
      string name1 = $$.name;
      string name2 = $1.name;
      string index = $1.index;
      buffer << ". " << name1 << endl;
      buffer << "=[] " << name1 << ", " << name2 << ", " << index << endl;
    } else {
      string temp = GetNextTemp();
      strcpy($$.name, temp.c_str());
      strcpy($$.index, $$.name);
      string name1 = $$.name;
      string name2 = $1.name;
      buffer << ". " << name1 << endl;
      buffer << "= " << name1 << ", " << name2 << endl;
    }
  }
  | NUMBER 
  {
    $$.val = $1;
    strcpy($$.type, "INTEGER");
    string temp = GetNextTemp();
    strcpy($$.name, temp.c_str());
    strcpy($$.index, $$.name);
    string name = $$.name;
    buffer << ". " << name << endl;
    buffer << "= " << name << ", " << $$.val << endl;
  }
  | L_PAREN Expression R_PAREN {
    // printf("Term . L_PAREN Expression R_PAREN\n");
    strcpy($$.name, $2.name);
  }
      | SUB Var {
        // printf("Term . SUB Var\n");
        $$.val = ($2.val * -1);
        strcpy($$.type, $2.type);
        
        if (strcmp($2.type, "ARRAY") == 0) {
          string temp1 = GetNextTemp();
          string temp2 = GetNextTemp();

          buffer << ". " << temp1 << "\n" << "= " << temp1 << ", 0" << endl;
          buffer << ". " << temp2 << "\n" << ". " << temp2 << endl;
          buffer << "=[] " << temp2 << ", " << $2.name << ", " << $2.index << endl;

          string temp3 = GetNextTemp();
          strcpy($$.name, temp3.c_str());

          buffer << ". " << $$.name << endl;
          buffer << "- " << $$.name << ", " << temp1 << ", " << temp2 << endl;
        } else {
          string temp1 = GetNextTemp();
          string temp2 = GetNextTemp();

          buffer << ". " << temp1 << "\n" << "= " << temp1 << ", 0" << endl;
          buffer << ". " << temp2 << endl;
          buffer << "= " << temp2 << ", " << $2.name << endl;

          string temp3 = GetNextTemp();
          strcpy($$.name, temp3.c_str());

          buffer << ". " << $$.name << endl;
          buffer << "- " << $$.name << ", " << temp1 << ", " << temp2 << endl;
        }
      }
      | SUB NUMBER {
        // printf("Term . SUB NUMBER\n");
        $$.val = ($2 * -1);
        strcpy($$.type, "INTEGER");

        string temp1 = GetNextTemp();
        string temp2 = GetNextTemp();

        buffer << ". " << temp1 << "\n" << "= " << temp1 << ", 0" << endl;
        buffer << ". " << temp2 << endl;
        string val = to_string($$.val);
        buffer << "= " << temp2 << ", " << val << endl;

        string temp3 = GetNextTemp();
        strcpy($$.name, temp3.c_str());

        buffer << ". " << $$.name << endl;
        buffer << "- " << $$.name << ", " << temp1 << ", " << temp2 << endl;
      }
      | SUB L_PAREN Expression R_PAREN {
        // printf("Term . SUB L_PAREN Expression R_PAREN\n");
        string temp1 = GetNextTemp();
        buffer << ". " << temp1 <<endl;
        buffer << "= " << ", " << temp1 << ", 0" << endl;

        string temp2 = GetNextTemp();
        strcpy($$.name, temp2.c_str());

        buffer << ". " << $$.name << endl;
        buffer << "- " << $$.name << ", " << temp1 << ", " << $3.name << endl;
      }
  | IDENT L_PAREN Expression R_PAREN {
    // printf("Term . IDENT L_PAREN Expressions R_PAREN\n");
    if(function_table.find($1) == function_table.end()) {
      string err = "Function: " + string($1) + " not declared";
      yyerror(err);
    }
    expression_stack.push($3.name);

    while (!expression_stack.empty()) {
      buffer << "param " << expression_stack.top() << endl;
      expression_stack.pop();
    }

    string temp = GetNextTemp();
    buffer << ". " << temp << endl;
    buffer << "call " << $1 << ", " << temp << endl;
    strcpy($$.name, temp.c_str());
  }
  | IDENT L_PAREN R_PAREN {
    if(function_table.find($1) == function_table.end()) {
      string err = "Function: " + string($1) + " not declared";
      yyerror(err);
    }
    
    string temp = GetNextTemp();
    buffer << ". " << temp << endl;
    buffer << "call " << $1 << ", " << temp << endl;
    strcpy($$.name, temp.c_str());
  }
  ;

Statements: /* epsilon */
  | Statement SEMICOLON Statements;
Statement: 
    Var ASSIGN Expression 
    { 
      if (strcmp($1.type, "INTEGER") == 0) {
        buffer << "= " << $1.name << ", " << $3.name << endl;
      } else {
        buffer << "[]= " << $1.name << ", " << $1.index << ", " << $3.name << endl;
      }
      ReadBuffer();
    }
    | IF BoolExpr THEN {
      string start = GetLabel();
      string endif = GetLabel();
      label_stack.push(endif); 
      buffer << "?:=" << start << ", " << $2.name << endl;
      buffer << ":= " << endif << endl;
      buffer << ": " << start << endl;
    } 
    Statement SEMICOLON Statements Else ENDIF {
      string label = label_stack.top();
      label_stack.pop();
      buffer << ": " << label << endl;
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

      string s = "?:= " + condition + ", " + $2.name;
      buffer << s << endl;
      buffer << ":= " << end << endl;
      buffer << ": " << condition << endl;

    } Statement SEMICOLON Statements ENDLOOP {
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
    } Statement SEMICOLON Statements ENDLOOP WHILE BoolExpr {
      string start = label_stack.top();
      label_stack.pop();
      buffer << "?:= " << start << ", " << $9.name << endl;
      ReadBuffer();
    }
    | FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP {

    }
    | READ Var Vars {
      variable_stack.push($2.name);
      while (!variable_stack.empty()) {
        if (strcmp($2.type, "INTEGER") == 0) {
          buffer << ".< " << variable_stack.top() << endl;
          variable_stack.pop();
        } else {
          string s = ".[]< " + variable_stack.top() + ", " + $2.index;
          variable_stack.pop();
          buffer << s << endl;
        }
      }
      ReadBuffer();
    }
    | WRITE Var Vars {
      variable_stack.push($2.name);
      while (!variable_stack.empty()) {
        if (strcmp($2.type, "INTEGER") == 0) {
          buffer << ".> " << variable_stack.top() << endl;
          variable_stack.pop();
        } else {
          string s = ".[]> " + variable_stack.top() + ", " + $2.index;
          variable_stack.pop();
          buffer << s << endl;
        }
      }
      ReadBuffer();
    }
    | CONTINUE {
      if (!label_stack.empty()) {
        buffer << ":= " << label_stack.top() << endl;
        ReadBuffer();
      } else {
        yyerror("Error: Can't use CONTINUE outside of a loop");
      }
    }
    | RETURN Expression {
      $$.val = $2.val;
      strcpy($$.name, $2.name);
      buffer << "ret " << $2.name << endl;
      ReadBuffer();
    }
    ;

Else: /* epsilon */
  | ELSE {
    string else_label = GetLabel();
    buffer << ":= " << else_label << endl;
    buffer << ": " << label_stack.top() << endl;
    label_stack.pop();
    label_stack.push(else_label);
  } Statements
  ;


Expression: MultiplicativeExpr 
    {
      strcpy($$.name, $1.name);
      strcpy($$.type, $1.type);
    }
    | Expression ADD MultiplicativeExpr 
    {
      string temp = GetNextTemp();
      strcpy($$.name, temp.c_str());
      buffer << ". " << temp << endl;
      buffer << "+ " << temp << ", " << $1.name << ", " << $3.name << endl;
    }
    | Expression SUB MultiplicativeExpr 
    {
      string temp = GetNextTemp();
        strcpy($$.name, temp.c_str());
        buffer << ". " << temp << endl;
        buffer << "- " << temp << ", " << $1.name << ", " << $3.name << endl;
    };

MultiplicativeExpr: Term 
  {
    strcpy($$.name, $1.name);
    strcpy($$.type, $1.type);
  }
  | MultiplicativeExpr MULT Term {
    string temp = GetNextTemp();
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << "* " << temp << ", " << s1 << ", " << s3 << endl;
    strcpy($$.name, temp.c_str());
  }
  | MultiplicativeExpr DIV Term {
    string temp = GetNextTemp();
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << "/ " << temp << ", " << s1 << ", " << s3 << endl;
    strcpy($$.name, temp.c_str());
  }
  | MultiplicativeExpr MOD Term {
    string temp = GetNextTemp();
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << "% " << temp << ", " << s1 << ", " << s3 << endl;
    strcpy($$.name, temp.c_str());
  };

Comparison: EQ { $$ = const_cast<char*>("=="); }
    | NEQ { $$ = const_cast<char*>("!="); }
    | LT { $$ = const_cast<char*>("<"); }
    | GT { $$ = const_cast<char*>(">"); }
    | LTE { $$ = const_cast<char*>("<="); }
    | GTE { $$ = const_cast<char*>(">="); }
    ;

BoolExpr: RelationAndExpr {
    // printf("BoolExpr . RelationAndExpr\n");
    strcpy($$.name, $1.name);
  } 
  | RelationAndExpr OR BoolExpr {
    // printf("BoolExpr . RelationAndExpr OR RelationAndExpr\n");
    string temp = GetNextTemp();
    strcpy($$.name, temp.c_str());
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << "|| " << temp << ", " << s1 << ", " << s3 << endl;
  }
  ;

RelationAndExpr: RelationExpr {
    // printf("RelationAndExpr . RelationExpr\n");
    strcpy($$.name, $1.name);
  }
  | RelationExpr AND RelationAndExpr {
    // printf("RelationAndExpr . RelationExpr AND RelationAndExpr\n");
    string temp = GetNextTemp();
    strcpy($$.name, temp.c_str());
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << "&& " << temp << ", " << s1 << ", " << s3 << endl;
  }
  ;

RelationExpr: RelExpr {
    strcpy($$.name, $1.name);
  }
  | NOT RelExpr {
    string temp = GetNextTemp();
    strcpy($$.name, temp.c_str());
    buffer << "! " << temp << $2.name << endl;
  }

RelExpr: Expression Comparison Expression {
    // printf("RelationExpr . Expression Comp Expression\n");
    string temp = GetNextTemp();
    strcpy($$.name, temp.c_str());
    buffer << ". " << temp << endl;
    string s1 = $1.name;
    string s3 = $3.name;
    buffer << $2 << " " << temp << ", " << s1 << ", " << s3 << endl; 
  }
    | TRUE {
      // printf("RelationExpr . TRUE\n");
      string temp = GetNextTemp();
      strcpy($$.name, temp.c_str());
      buffer << ". " << temp << endl;
      buffer << "= " << temp << ", True" << endl; 
    }
    | FALSE {
      // printf("RelationExpr . FALSE\n");
      string temp = GetNextTemp();
      strcpy($$.name, temp.c_str());
      buffer << ". " << temp << endl;
      buffer << "= " << temp << ", False" << endl; 
    }
    | L_PAREN BoolExpr R_PAREN {
      // printf("RelationExpr . L_PAREN BoolExpr R_PAREN\n");
      strcpy($$.name, $2.name);
    }
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
   cout << output.str() << endl;
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