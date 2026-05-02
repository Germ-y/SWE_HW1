%token A
%token A
%type <ival> missing
%%
start:
    A
  | missing
  ;
%%
