alphabet :: 0 1 # ;

Increment ::= [R(#)] loop@[L] (
  {0, #} -> [1] [L(#)] ;
  {1}    -> [0] &loop ;
) ;;
