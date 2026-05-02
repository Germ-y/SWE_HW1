%require "3.8"
%debug
%locations
%define api.pure full
%define api.value.type {int}
%define parse.error detailed
%define parse.lac full
%parse-param {int *result}
%lex-param {void *scanner}
%initial-action {
  if (result)
    *result = 0;
}
%token NUM ID
%left '+'
%printer { fprintf (yyo, "%d", $$); } <*>
%destructor { } <*>
%%
input:
    %empty
  | input expr ';' { if (result) *result = $2; }
  ;

expr:
    NUM
  | ID { $$ = 0; }
  | expr '+' expr { $$ = $1 + $3; }
  ;
%%
