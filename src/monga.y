
%{
    //nothing
%}

%token AS
%token CHAR
%token ELSE
%token FLOAT
%token IF
%token INT
%token NEW
%token RETURN
%token VOID
%token WHILE

%token ID
%token NUMERAL
%token LITERAL


%token AND_OP
%token OR_OP
%token LE_OP
%token GE_OP
%token EQ_OP
%token MATCH_OP

%%

programa : definicao | programa definicao ;
definicao : def_variavel | def_funcao ;
def_variavel : ID ':' tipo ';' ;
tipo : INT | CHAR | FLOAT | VOID | tipo '[' ']' ;
def_funcao : ID '(' parametros ')' ':' tipo ;//bloco ;
parametros : %empty | par_aux ;
par_aux :  parametro | par_aux ',' parametro ; 
parametro : ID ':' tipo ;
/* bloco : '{' { def-variavel } { comando } '}'
comando : IF exp bloco [ ELSE bloco ]
        | WHILE exp bloco
        | var '=' exp ';'
        | RETURN [ exp ] ';'
        | chamada ';'
	| '@' exp ';'
	| bloco
var : ID | exp '[' exp ']'
exp : NUMERAL | LITERAL
	| var
	| '(' exp ')'
	| chamada
	| exp AS tipo
	| NEW tipo '[' exp ']'
	| '-' exp
	| exp '+' exp
	| exp '-' exp
	| exp '*' exp
	| exp '/' exp
	| exp '==' exp
	| exp '~=' exp
	| exp '<=' exp
	| exp '>=' exp
	| exp '<' exp
	| exp '>' exp
	| '!' exp
	| exp '&&' exp
	| exp '||' exp
chamada : ID '(' lista-exp ')'
lista-exp : [ exp { ',' exp } ] */


%%