%token IF THEN ELSE ID
%%
stmt:
    IF expr THEN stmt
  | IF expr THEN stmt ELSE stmt
  | ID
  ;
expr:
    ID
  ;
%%
