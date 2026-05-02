%glr-parser
%token WORD
%%
sentence:
    words
  ;
words:
    WORD
  | words WORD
  | words words
  ;
%%
