%locations
%define api.pure full
%parse-param {void *scanner}
%lex-param {void *scanner}
%token WORD
%%
document:
    /* empty */
  | document item
  ;
item:
    WORD
  | error { yyerrok; }
  ;
%%
