/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "mini_l.y" /* yacc.c:339  */

  // C Declarations
  #include <stdio.h>
  #include <stdlib.h>
  void yyerror(const char *msg);
  extern int currLine;
  extern int currPos;
  FILE * yyin;

#line 76 "parser.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "parser.tab.h".  */
#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    FUNCTION = 258,
    BEGIN_PARAMS = 259,
    END_PARAMS = 260,
    BEGIN_LOCALS = 261,
    END_LOCALS = 262,
    BEGIN_BODY = 263,
    END_BODY = 264,
    INTEGER = 265,
    ARRAY = 266,
    OF = 267,
    IF = 268,
    THEN = 269,
    ENDIF = 270,
    ELSE = 271,
    WHILE = 272,
    DO = 273,
    FOR = 274,
    BEGINLOOP = 275,
    ENDLOOP = 276,
    CONTINUE = 277,
    READ = 278,
    WRITE = 279,
    AND = 280,
    OR = 281,
    NOT = 282,
    TRUE = 283,
    FALSE = 284,
    RETURN = 285,
    SUB = 286,
    ADD = 287,
    MULT = 288,
    DIV = 289,
    MOD = 290,
    EQ = 291,
    NEQ = 292,
    LT = 293,
    GT = 294,
    LTE = 295,
    GTE = 296,
    IDENT = 297,
    NUMBER = 298,
    SEMICOLON = 299,
    COLON = 300,
    COMMA = 301,
    L_PAREN = 302,
    R_PAREN = 303,
    L_SQUARE_BRACKET = 304,
    R_SQUARE_BRACKET = 305,
    ASSIGN = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 12 "mini_l.y" /* yacc.c:355  */

  char* ident_val;
  int num_val;
 

#line 174 "parser.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 191 "parser.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   165

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  18
/* YYNRULES -- Number of rules.  */
#define YYNRULES  63
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  151

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,    76,    76,    77,    80,    81,    83,    85,    86,    88,
      89,    90,    91,    92,    93,    94,    95,    96,    97,   100,
     101,   102,   103,   104,   105,   108,   109,   110,   111,   114,
     115,   116,   117,   118,   119,   120,   123,   124,   126,   127,
     128,   129,   132,   133,   136,   137,   140,   141,   142,   143,
     144,   145,   146,   147,   150,   151,   153,   154,   155,   158,
     159,   161,   162,   163
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "FUNCTION", "BEGIN_PARAMS", "END_PARAMS",
  "BEGIN_LOCALS", "END_LOCALS", "BEGIN_BODY", "END_BODY", "INTEGER",
  "ARRAY", "OF", "IF", "THEN", "ENDIF", "ELSE", "WHILE", "DO", "FOR",
  "BEGINLOOP", "ENDLOOP", "CONTINUE", "READ", "WRITE", "AND", "OR", "NOT",
  "TRUE", "FALSE", "RETURN", "SUB", "ADD", "MULT", "DIV", "MOD", "EQ",
  "NEQ", "LT", "GT", "LTE", "GTE", "IDENT", "NUMBER", "SEMICOLON", "COLON",
  "COMMA", "L_PAREN", "R_PAREN", "L_SQUARE_BRACKET", "R_SQUARE_BRACKET",
  "ASSIGN", "$accept", "Program", "Functions", "Function", "Statements",
  "Statement", "Comparison", "MultiplicativeExpr", "Term", "Declarations",
  "Declaration", "BoolExpr", "RelationAndExpr", "RelationExpr",
  "Expressions", "Expression", "Vars", "Var", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

#define YYPACT_NINF -55

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-55)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     -55,    26,   -55,   -15,   -55,    55,    16,   -55,    58,    39,
     -35,    64,    42,    27,    39,    86,    39,   -55,    46,   -55,
      39,   -55,    59,    91,    65,   106,    -8,    29,   107,    75,
      37,    37,    99,    78,   -55,    78,    78,   -55,    73,   114,
      80,    74,   -55,    76,    54,   -55,   -55,     2,     7,   -55,
      37,    77,     1,   113,   102,   104,    36,   -55,   110,    29,
      81,   -55,    85,   -55,    57,   -55,    29,    57,   121,   -55,
     -55,    37,    36,   -55,    57,   -55,    57,    87,   -23,    57,
      57,    57,    57,    57,    29,    37,    37,   -55,   -55,   -55,
     -55,   -55,   -55,    57,    29,   115,    94,    78,    57,    84,
     -55,   -55,   128,    92,    57,    93,    96,    97,   -55,   -55,
     -55,   -55,   -55,   -55,   -55,    95,   -55,   -55,   -55,   118,
     125,   101,   -55,    98,   100,   -55,   -55,   -55,   -55,   -55,
      57,   -55,    29,   -55,    37,    37,    57,   -55,   132,   -55,
     108,   103,   -55,    78,   -55,   105,    57,   130,    29,   127,
     -55
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,     1,     0,     3,     4,     0,     5,     0,    36,
       0,     0,     0,     0,     0,     0,    36,    39,     0,    38,
      36,    37,     0,     0,     0,     0,     0,     7,     0,     0,
       0,     0,     0,     0,    17,    59,    59,    18,    61,     0,
       0,     0,    40,     0,     0,    47,    48,     0,    61,    30,
       0,    56,    25,     0,    42,    44,     0,    29,     0,     7,
       0,    15,     0,    16,     0,     6,     7,     0,     0,    51,
      52,     0,     0,    33,     0,    32,    54,     0,     0,     0,
       0,     0,     0,     0,     7,     0,     0,    19,    20,    21,
      22,    23,    24,     0,     7,     0,     0,    59,     0,     0,
       8,     9,     0,     0,     0,     0,     0,     0,    49,    31,
      58,    57,    26,    27,    28,     0,    43,    45,    46,     0,
       0,     0,    60,     0,    62,    41,    53,    50,    34,    35,
      54,    10,     7,    12,     0,     0,     0,    55,     0,    13,
       0,     0,    11,     0,    63,     0,     0,     0,     7,     0,
      14
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -55,   -55,   146,   -55,   -54,   -55,    82,    33,     8,     3,
     141,   -28,    72,    79,    28,   -43,   -34,   -27
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     4,     5,    39,    40,    93,    51,    52,    11,
      12,    53,    54,    55,   106,    56,    61,    57
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      41,    72,    63,    58,    28,    95,    60,    78,    62,    62,
      13,    14,   100,    87,    88,    89,    90,    91,    92,    21,
      75,    99,    77,    23,   101,   109,     2,     6,    78,     3,
     115,   105,    41,   107,    81,    82,    83,    17,    18,    41,
     119,    29,    30,   103,    38,    73,    31,    32,    33,    74,
     118,    34,    35,    36,    76,   123,    64,    41,     3,    37,
       8,   127,     9,   122,    44,    45,    46,    41,    47,    15,
      62,    38,    87,    88,    89,    90,    91,    92,   138,    48,
      49,    10,    69,    70,    50,    47,    16,   107,    47,   112,
     113,   114,    20,   141,   149,    22,    48,    49,    25,    48,
      49,    71,    24,   147,    98,    41,   139,   140,    79,    80,
     131,   132,   110,   111,    27,    26,   145,    42,    43,    59,
      38,    41,    64,    65,    66,    67,    68,    84,    85,    86,
      94,    97,    96,   102,   124,   108,   120,   121,   125,   133,
     126,   128,   134,   130,   129,   135,   109,   142,   150,   136,
     148,     7,   143,   144,   104,    19,   146,   116,   137,     0,
       0,     0,     0,     0,     0,   117
};

static const yytype_int16 yycheck[] =
{
      27,    44,    36,    31,    12,    59,    33,    50,    35,    36,
      45,    46,    66,    36,    37,    38,    39,    40,    41,    16,
      47,    64,    50,    20,    67,    48,     0,    42,    71,     3,
      84,    74,    59,    76,    33,    34,    35,    10,    11,    66,
      94,    49,    13,    71,    42,    43,    17,    18,    19,    47,
      93,    22,    23,    24,    47,    98,    49,    84,     3,    30,
      44,   104,     4,    97,    27,    28,    29,    94,    31,     5,
      97,    42,    36,    37,    38,    39,    40,    41,   132,    42,
      43,    42,    28,    29,    47,    31,    44,   130,    31,    81,
      82,    83,     6,   136,   148,    49,    42,    43,     7,    42,
      43,    47,    43,   146,    47,   132,   134,   135,    31,    32,
      15,    16,    79,    80,     8,    50,   143,    10,    43,    20,
      42,   148,    49,     9,    44,    51,    50,    14,    26,    25,
      20,    46,    51,    12,    50,    48,    21,    43,    10,    21,
      48,    48,    17,    46,    48,    44,    48,    15,    21,    49,
      20,     5,    44,    50,    72,    14,    51,    85,   130,    -1,
      -1,    -1,    -1,    -1,    -1,    86
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    53,     0,     3,    54,    55,    42,    54,    44,     4,
      42,    61,    62,    45,    46,     5,    44,    10,    11,    62,
       6,    61,    49,    61,    43,     7,    50,     8,    12,    49,
      13,    17,    18,    19,    22,    23,    24,    30,    42,    56,
      57,    69,    10,    43,    27,    28,    29,    31,    42,    43,
      47,    59,    60,    63,    64,    65,    67,    69,    63,    20,
      69,    68,    69,    68,    49,     9,    44,    51,    50,    28,
      29,    47,    67,    43,    47,    69,    47,    63,    67,    31,
      32,    33,    34,    35,    14,    26,    25,    36,    37,    38,
      39,    40,    41,    58,    20,    56,    51,    46,    47,    67,
      56,    67,    12,    63,    58,    67,    66,    67,    48,    48,
      59,    59,    60,    60,    60,    56,    64,    65,    67,    56,
      21,    43,    68,    67,    50,    10,    48,    67,    48,    48,
      46,    15,    16,    21,    17,    44,    49,    66,    56,    63,
      63,    67,    15,    44,    50,    69,    51,    67,    20,    56,
      21
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    53,    54,    54,    55,    56,    56,    57,
      57,    57,    57,    57,    57,    57,    57,    57,    57,    58,
      58,    58,    58,    58,    58,    59,    59,    59,    59,    60,
      60,    60,    60,    60,    60,    60,    61,    61,    62,    62,
      62,    62,    63,    63,    64,    64,    65,    65,    65,    65,
      65,    65,    65,    65,    66,    66,    67,    67,    67,    68,
      68,    69,    69,    69
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     2,     0,     2,    12,     0,     3,     3,
       5,     7,     5,     6,    13,     2,     2,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     3,     3,     3,     1,
       1,     3,     2,     2,     4,     4,     0,     3,     3,     3,
       8,    11,     1,     3,     1,     3,     3,     1,     1,     3,
       4,     2,     2,     4,     0,     3,     1,     3,     3,     0,
       3,     1,     4,     7
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 76 "mini_l.y" /* yacc.c:1646  */
    {printf("Program -> epsilon\n");}
#line 1372 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 77 "mini_l.y" /* yacc.c:1646  */
    {printf("Program -> Program Function\n");}
#line 1378 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 80 "mini_l.y" /* yacc.c:1646  */
    {printf("Functions -> epsilon\n");}
#line 1384 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 81 "mini_l.y" /* yacc.c:1646  */
    {printf("Functions -> Function Functions\n");}
#line 1390 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 83 "mini_l.y" /* yacc.c:1646  */
    {printf("Function -> FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n");}
#line 1396 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 85 "mini_l.y" /* yacc.c:1646  */
    {printf("Statements -> epsilon\n");}
#line 1402 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 86 "mini_l.y" /* yacc.c:1646  */
    {printf("Statements-> Statement SEMICOLON Statements\n");}
#line 1408 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 88 "mini_l.y" /* yacc.c:1646  */
    {printf("\n");}
#line 1414 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 89 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> IF BoolExpr THEN Statements ENDIF\n");}
#line 1420 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 90 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> IF BoolExpr THEN Statements ELSE Statements ENDIF\n");}
#line 1426 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 91 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> WHILE BoolExpr Statements ENDLOOP\n");}
#line 1432 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 92 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExpr\n");}
#line 1438 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 93 "mini_l.y" /* yacc.c:1646  */
    {printf("FOR Var ASSIGN NUMBER SEMICOLON BoolExpr SEMICOLON Var ASSIGN Expression BEGINLOOP Statements ENDLOOP\n");}
#line 1444 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 94 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> Read Vars\n");}
#line 1450 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 95 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> WRITE Vars\n");}
#line 1456 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 96 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> CONTINUE\n");}
#line 1462 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 97 "mini_l.y" /* yacc.c:1646  */
    {printf("Statement -> RETURN\n");}
#line 1468 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 100 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> EQ\n");}
#line 1474 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 101 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> NEQ\n");}
#line 1480 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 102 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> LT\n");}
#line 1486 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 103 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> GT\n");}
#line 1492 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 104 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> LTE\n");}
#line 1498 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 105 "mini_l.y" /* yacc.c:1646  */
    {printf("Comparison -> GTE\n");}
#line 1504 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 108 "mini_l.y" /* yacc.c:1646  */
    {printf("multiplicative-expr -> Term\n");}
#line 1510 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 109 "mini_l.y" /* yacc.c:1646  */
    {printf("multiplicative-expr -> Term MULT Term\n");}
#line 1516 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 110 "mini_l.y" /* yacc.c:1646  */
    {printf("multiplicative-expr -> Term DIV Term\n");}
#line 1522 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 111 "mini_l.y" /* yacc.c:1646  */
    {printf("multiplicative-expr -> Term MOD Term\n");}
#line 1528 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 114 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> Var\n");}
#line 1534 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 115 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> NUMBER\n");}
#line 1540 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 116 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> L_PAREN Expression R_PAREN\n");}
#line 1546 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 117 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> SUB Var\n");}
#line 1552 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 118 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> SUB NUMBER\n");}
#line 1558 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 119 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> SUB L_PAREN Expression R_PAREN\n");}
#line 1564 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 120 "mini_l.y" /* yacc.c:1646  */
    {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
#line 1570 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 123 "mini_l.y" /* yacc.c:1646  */
    {printf("Declarations -> epsilon\n");}
#line 1576 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 124 "mini_l.y" /* yacc.c:1646  */
    {printf("Declarations -> Declaration SEMICOLON Declarations\n");}
#line 1582 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 126 "mini_l.y" /* yacc.c:1646  */
    {printf("Declaration -> IDENT COMMA Declaration\n");}
#line 1588 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 127 "mini_l.y" /* yacc.c:1646  */
    {printf("Declaration -> IDENT COLON INTEGER\n");}
#line 1594 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 128 "mini_l.y" /* yacc.c:1646  */
    {printf("Declaration -> IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
#line 1600 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 129 "mini_l.y" /* yacc.c:1646  */
    {printf("Declaration -> IDENT COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");}
#line 1606 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 132 "mini_l.y" /* yacc.c:1646  */
    {printf("BoolExpr -> RelationAndExpr\n");}
#line 1612 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 133 "mini_l.y" /* yacc.c:1646  */
    {printf("BoolExpr -> RelationAndExpr OR RelationAndExpr\n");}
#line 1618 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 136 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationAndExpr -> RelationExpr\n");}
#line 1624 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 137 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationAndExpr -> RelationExpr AND RelationExpr\n");}
#line 1630 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 140 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> Expression Comp Expression\n");}
#line 1636 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 141 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> TRUE\n");}
#line 1642 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 142 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> FALSE\n");}
#line 1648 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 143 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> L_PAREN BoolExpr R_PAREN\n");}
#line 1654 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 144 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> NOT Expression Comp Expression\n");}
#line 1660 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 145 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> NOT TRUE\n");}
#line 1666 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 146 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> NOT FALSE\n");}
#line 1672 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 147 "mini_l.y" /* yacc.c:1646  */
    {printf("RelationExpr -> NOT L_PAREN BoolExpr R_PAREN\n");}
#line 1678 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 150 "mini_l.y" /* yacc.c:1646  */
    {printf("Expressions -> epsilon\n");}
#line 1684 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 151 "mini_l.y" /* yacc.c:1646  */
    {printf("Expressions -> Expression COMMA Expressions\n");}
#line 1690 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 153 "mini_l.y" /* yacc.c:1646  */
    {printf("Expression -> MultiplicativeExpr\n");}
#line 1696 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 154 "mini_l.y" /* yacc.c:1646  */
    {printf("MultiplicativeExpr ADD MultiplicativeExpr\n");}
#line 1702 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 155 "mini_l.y" /* yacc.c:1646  */
    {printf("MultiplicativeExpr SUB MultiplicativeExpr\n");}
#line 1708 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 158 "mini_l.y" /* yacc.c:1646  */
    {printf("Vars -> epsilon\n");}
#line 1714 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 159 "mini_l.y" /* yacc.c:1646  */
    {printf("Vars -> Var COMMA Vars\n");}
#line 1720 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 161 "mini_l.y" /* yacc.c:1646  */
    {printf("Var -> IDENT\n");}
#line 1726 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 162 "mini_l.y" /* yacc.c:1646  */
    {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
#line 1732 "parser.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 163 "mini_l.y" /* yacc.c:1646  */
    {printf("Var -> IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");}
#line 1738 "parser.tab.c" /* yacc.c:1646  */
    break;


#line 1742 "parser.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 166 "mini_l.y" /* yacc.c:1906  */

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
void yyerror(const char* s) {
    printf("* Line %d, position %d: %s\n", currLine, currPos, msg);
}
