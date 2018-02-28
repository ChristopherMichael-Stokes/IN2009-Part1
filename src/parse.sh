#!/bin/bash
rm *.class
javac *.java > /dev/null

function parse { 
  echo parsing nt_$1\(\)
  sed -i "s|parser\.nt_.*()|parser\.nt_$1()|g" Parse.java
  javac Parse.java
  for var in "${@:2}"
  do
    echo "$var" | java Parse
  done
}

parse Var abc123330_ LF_0___3 g78
parse Type int abc12330_ 'arrayof(int)' 'arrayof(Integer)' boolean
parse FieldDecl  'int ab1;' 'boolean a2b;'