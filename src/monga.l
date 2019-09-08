
%{
//Tue Sep  3 15:16:08 -03 2019
// @Author: Luiz Carlos Rumbelsperger Viana
/* lexical grammar greatly adapted from https://www.lysator.liu.se/c/ANSI-C-grammar-l.html */

#include <stdio.h>
#include <error.h>
#include <errno.h>
#include "y.tab.h"

void count();
int read_float(YYSTYPE* yylval);
int read_int(YYSTYPE* yylval, char hexa);
int read_str(YYSTYPE* yylval, char id);
int line_num = 0;
int col_num = 0;

%}

%option noyywrap

D			[0-9]
L			[a-zA-Z_]
AN          {D}|{L}
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
HE			[Pp][+-]?{D}+

ID {L}{AN}*
DINT {D}+
HINT 0[xX]{H}+
DFLOAT {D}+{E}|{D}*"."{D}+{E}?|{D}+"."{D}*{E}?
HFLOAT 0[xX]{H}+{HE}|0[xX]{H}*"."{H}+{HE}?|0[xX]{H}+"."{H}*{HE}?
FLOAT  {DFLOAT}|{HFLOAT}
CHAR '(\\[0-9nt\\']|[^\\'])?'
STR \"(\\[nt\\\"]|[^\\\"])*\"
LIT {CHAR}|{STR}

%%
"as"            {count(); return AS;}
"char"          {count(); return CHAR;}
"else"          {count(); return ELSE;}
"float"         {count(); return FLOAT;}
"if"            {count(); return IF;}
"int"           {count(); return INT;}
"new"           {count(); return NEW;}
"return"        {count(); return RETURN;}
"bool"          {count(); return BOOL;}
"true"          {count(); return TRUE;}
"false"         {count(); return FALSE;}
"while"         {count(); return WHILE;}


{ID}              {return read_str(yylval, 1);}
{LIT}             {return read_str(yylval, 0);}
{FLOAT}           {return read_float(yylval);}
{DINT}            {return read_int(yylval, 0);}
{HINT}            {return read_int(yylval, 1);}


"&&"			{count(); return(AND_OP); }
"||"			{count(); return(OR_OP); }
"<="			{count(); return(LE_OP); }
">="			{count(); return(GE_OP); }
"=="			{count(); return(EQ_OP); }
"~="			{count(); return(MATCH_OP); }
"<"			    {count(); return('<'); }
">"		        {count(); return('>'); }
"="			    {count(); return('='); }
","			    {count(); return(','); }
":"			    {count(); return(':'); }
";"			    {count(); return(';'); }
"{"		        {count(); return('{'); }
"}"		        {count(); return('}'); }
"("			    {count(); return('('); }
")"			    {count(); return(')'); }
"["		        {count(); return('['); }
"]"		        {count(); return(']'); }
"!"			    {count(); return('!'); }
"@"			    {count(); return('@'); }
"-"			    {count(); return('-'); }
"+"			    {count(); return('+'); }
"*"			    {count(); return('*'); }
"/"			    {count(); return('/'); }


"#"             {count(); char c; while((c = input()) != '\n' && c);}
.			    {count(); /* ignore bad characters */ }
%%

void count(){
    char* c = yytext;
    while(*c++)
        if (*c == '\n')
			(col_num = 0) && line_num++;
		else if (*c == '\t')
			col_num += 8 - (col_num % 8);
		else
			col_num++;
}

int read_float(YYSTYPE* yylval){
    count();
    yylval->fval = strtod(yytext, NULL);
    yynumber_flag = 1;
    return NUMERAL;
}

int read_int(YYSTYPE* yylval, char hexa){
    count();
    yylval->ival = strtol(yytext, NULL, hexa? 16 : 10);
    yynumber_flag = hexa? 2 : 0;
    return NUMERAL;
}

int read_str(YYSTYPE* yylval, char id){
    count();
    yylval->text = (char*) malloc(yyleng);
    try(yylval->text, 0, "monga.l");
    strcpy(yylval->text, yytext);
    return id? ID : LITERAL;
}

void try(void* to_try, char c, char* filename){
    switch(c){
        case 0:
            if(!to_try) error_at_line(1, errno, filename, line_num, "null pointer exception in memory allocation");
            break;
        default:
            break;
    }
}

#define STANDALONE_LEXER

#if defined STANDALONE_LEXER && ! defined TEST
int main (int argc, char **argv){
    int code;
	YYSTYPE value;
	++argv, --argc;  /* skip over program name */
	yyin = argc > 0 ? fopen( argv[0], "r" ) : stdin;

    while(code = yylex(&value)){
        printf("%d: %s\n", code, yytext);
    }

    return 0;
}
#endif