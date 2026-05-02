%define api.pure full
%locations
%code requires {
  typedef struct value value;
}
%union {
  int ival;
}
%token <ival> NUM
%token ID "identifier"
%left '+' '-'
%left '*' '/'
%precedence UMINUS
%type <ival> expr list item
%%
input:
    %empty
  | input list '\n'
  ;

list:
    item
  | list ',' item
  ;

item:
    expr
  | ID { $$ = 0; }
  ;

expr:
    NUM { $$ = $1; }
  | expr '+' expr { $$ = $1 + $3; }
  | expr '-' expr { $$ = $1 - $3; }
  | expr '*' expr { $$ = $1 * $3; }
  | expr '/' expr { $$ = $3 ? $1 / $3 : 0; }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')' { $$ = $2; }
  ;
%%
