
%{
/* lexical grammar greatly adapted from https://www.lysator.liu.se/c/ANSI-C-grammar-l.html */
#include <stdio.h>
#include "y.tab.h"

%}

%option noyywrap

D			[0-9]
L			[a-zA-Z_]
AN          {D}|{L}
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
HE			[Pp][+-]?{D}+
FS          (f|F)
IS			(u|U|l|L)

ID {L}{AN}*
DINT {D}+{IS}?
HINT 0[xX]{H}+{IS}?
DFLOAT {D}+{E}|{D}*"."{D}+{E}?|{D}+"."{D}*{E}?|{D}+{FS}
HFLOAT 0[xX]{H}+{HE}|0[xX]{H}*"."{H}+{HE}?|0[xX]{H}+"."{H}*{HE}?|0[xX]{H}+"f"
FLOAT  {DFLOAT}|{HFLOAT}
CHAR '(\\[0nt\\']|[^\\'])?'
STR \"(\\[nt\\\"]|[^\\\"])*\"
LIT {CHAR}|{STR}

%%
"as"            {return AS;}
"char"          {return CHAR;}
"else"          {return ELSE;}
"float"         {return FLOAT;}
"if"            {return IF;}
"int"           {return INT;}
"new"           {return NEW;}
"return"        {return RETURN;}
"void"          {return VOID;}
"while"         {return WHILE;}


{FLOAT}           {yylval->fval = strtod(yytext, NULL); yyfloat_flag = 1; return NUMERAL;}
{DINT}            {yylval->ival = strtol(yytext, NULL, 10); yyfloat_flag = 0; yyint_flag = 0; return NUMERAL;}
{HINT}            {yylval->ival = strtol(yytext, NULL, 16); yyfloat_flag = 0;  yyint_flag = 1; return NUMERAL;}
{ID}              {strcpy(yylval->text, yytext); return ID;}
{LIT}             {strcpy(yylval->text, yytext); return LITERAL;}


"&&"			{ return(AND_OP); }
"||"			{ return(OR_OP); }
"<="			{ return(LE_OP); }
">="			{ return(GE_OP); }
"=="			{ return(EQ_OP); }
"~="			{ return(MATCH_OP); }
"<"			    { return('<'); }
">"		        { return('>'); }
"="			    { return('='); }
","			    { return(','); }
":"			    { return(':'); }
";"			    { return(';'); }
"{"		        { return('{'); }
"}"		        { return('}'); }
"("			    { return('('); }
")"			    { return(')'); }
"["		        { return('['); }
"]"		        { return(']'); }
"!"			    { return('!'); }
"@"			    { return('@'); }
"-"			    { return('-'); }
"+"			    { return('+'); }
"*"			    { return('*'); }
"/"			    { return('/'); }


"#"             {char c; while((c = input()) != '\n' && c);}
.			    { /* ignore bad characters */ }
%%

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