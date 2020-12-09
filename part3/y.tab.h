/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 12 "mini_l.y" /* yacc.c:1909  */

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






#line 77 "y.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENT = 258,
    NUMBER = 259,
    FUNCTION = 260,
    SEMICOLON = 261,
    TRUE = 262,
    FALSE = 263,
    RETURN = 264,
    BEGIN_PARAMS = 265,
    END_PARAMS = 266,
    BEGIN_LOCALS = 267,
    END_LOCALS = 268,
    BEGIN_BODY = 269,
    END_BODY = 270,
    INTEGER = 271,
    ARRAY = 272,
    OF = 273,
    IF = 274,
    THEN = 275,
    ENDIF = 276,
    ELSE = 277,
    WHILE = 278,
    DO = 279,
    FOR = 280,
    BEGINLOOP = 281,
    ENDLOOP = 282,
    CONTINUE = 283,
    READ = 284,
    WRITE = 285,
    COLON = 286,
    COMMA = 287,
    ASSIGN = 288,
    OR = 289,
    AND = 290,
    NOT = 291,
    LT = 292,
    LTE = 293,
    GT = 294,
    GTE = 295,
    EQ = 296,
    NEQ = 297,
    ADD = 298,
    SUB = 299,
    MULT = 300,
    DIV = 301,
    MOD = 302,
    UMINUS = 303,
    L_SQUARE_BRACKET = 304,
    R_SQUARE_BRACKET = 305,
    L_PAREN = 306,
    R_PAREN = 307
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 46 "mini_l.y" /* yacc.c:1909  */

  char* sval;
  int ival;
  dec_type* dec; 
  str_type* str;
  list<string>* lst;
 

#line 151 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
