
%{
//Tue Sep 3 2019
// @Author: Luiz Carlos Rumbelsperger Viana
#include "monga.tab.h"
#include "lex.yy.h"
void yyerror (char const *s);
%}

%union {
  long ival;
  double fval;
  char* text;
}

%define api.pure full
%token AS
%token CHAR
%token ELSE
%token FLOAT
%token IF
%token INT
%token NEW
%token RETURN
%token BOOL
%token TRUE
%token FALSE
%token WHILE

%token ID
%token NUMERAL
%token LITERAL

%left AND_OP OR_OP
%left EQ_OP MATCH_OP LE_OP GE_OP '<' '>'
%left '+' '-'
%left '*' '/'
%precedence NOT
%precedence NEG

%start programa
%%

programa : definicao | programa definicao ;
definicao : def_variavel | def_funcao ;
def_variavel : ID ':' tipo ';' ;
tipo : INT | CHAR | FLOAT | BOOL | tipo '[' ']' ;
def_funcao : ID '(' parametros ')' ':' tipo bloco ;
parametros : %empty | par_aux ;
par_aux :  parametro | par_aux ',' parametro ; 
parametro : ID ':' tipo ;
bloco : '{' bloco_interno '}' ;
bloco_interno : %empty | seccao_declaracao | seccao_comandos | seccao_declaracao seccao_comandos ;
seccao_declaracao : def_variavel | seccao_declaracao def_variavel ;
seccao_comandos   : comando | seccao_comandos comando ;
comando : IF exp bloco
		| IF exp bloco ELSE bloco
        | WHILE exp bloco
        | var '=' exp ';'
        | RETURN ';'
		| RETURN  exp  ';'
        | chamada ';'
		| '@' exp ';'
		| bloco 
		;
var : ID | exp '[' exp ']' ;
exp : NUMERAL | LITERAL | TRUE | FALSE
	| var
	| '(' exp ')'
	| chamada
	| exp AS tipo
	| NEW tipo '[' exp ']'
	| '-' exp %prec NEG
	| exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| exp EQ_OP exp
	| exp MATCH_OP exp
	| exp LE_OP exp
	| exp GE_OP exp
	| exp '<' exp
	| exp '>' exp
	| '!' exp %prec NOT
	| exp AND_OP exp
	| exp OR_OP exp
	;
chamada : ID '(' lista-exp ')' ;
lista-exp : %empty | lista_aux ;
lista_aux :  exp | lista_aux ',' exp ; 


%%

void yyerror (char const *s){
	fprintf(stderr, "%s\n", yytext);
	fprintf (stderr, "%s\n", s);
}

#if defined PARSER && ! defined TEST
int main (int argc, char **argv){
	++argv, --argc;  /* skip over program name */
	yyin = argc > 0 ? fopen( argv[0], "r" ) : stdin;
	return yyparse();
}

#endif