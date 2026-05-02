%token NUMBER
%left '+'
%%
expr:
    NUMBER
  | expr '+' NUMBER
  ;
%%
