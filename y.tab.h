/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

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

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    AS = 258,
    CHAR = 259,
    ELSE = 260,
    FLOAT = 261,
    IF = 262,
    INT = 263,
    NEW = 264,
    RETURN = 265,
    VOID = 266,
    WHILE = 267,
    ID = 268,
    NUMERAL = 269,
    LITERAL = 270,
    AND_OP = 271,
    OR_OP = 272,
    LE_OP = 273,
    GE_OP = 274,
    EQ_OP = 275,
    MATCH_OP = 276
  };
#endif
/* Tokens.  */
#define AS 258
#define CHAR 259
#define ELSE 260
#define FLOAT 261
#define IF 262
#define INT 263
#define NEW 264
#define RETURN 265
#define VOID 266
#define WHILE 267
#define ID 268
#define NUMERAL 269
#define LITERAL 270
#define AND_OP 271
#define OR_OP 272
#define LE_OP 273
#define GE_OP 274
#define EQ_OP 275
#define MATCH_OP 276

union yystype_s {
  long ival;
  double fval;
  char text [80];
};


/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union yystype_s YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
