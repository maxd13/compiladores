
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
HE			[Ee][+-]?{H}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

ID {L}{AN}*
DINT {D}+{IS}?
HINT 0[xX]{D}+{IS}?
INT  {DINT}|{HINT}
DFLOAT {D}+{E}{FS}?|{D}*"."{D}+({E})?{FS}?|{D}+"."{D}*({E})?{FS}?
HFLOAT 0[xX]{D}+{HE}{FS}?|0[xX]{D}*"."{D}+({HE})?{FS}?|0[xX]{D}+"."{D}*({HE})?{FS}?
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


{ID}              {strcpy(yylval->text, yytext); return ID;}
{INT}             {yylval->ival = atoi(yytext); return NUMERAL;}
{FLOAT}           {yylval->fval = strtof(yytext, NULL); return NUMERAL;}
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