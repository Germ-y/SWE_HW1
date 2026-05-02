%{
#include <stdio.h>
%}
%union {
  int ival;
}
%token <ival> NUMBER
%token ID
%left '+' '-'
%left '*' '/'
%right UMINUS
%type <ival> expr
%%
input:
    /* empty */
  | input line
  ;
line:
    '\n'
  | expr '\n'
  | error '\n' { yyerrok; }
  ;
expr:
    NUMBER
  | ID
  | '-' expr %prec UMINUS
  | expr '+' expr
  | expr '-' expr
  | expr '*' expr
  | expr '/' expr
  | '(' expr ')'
  ;
%%
int yyerror(const char *s) { return 0; }
