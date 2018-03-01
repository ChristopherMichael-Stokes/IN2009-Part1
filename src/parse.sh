#!/bin/bash
javacc *.j
rm *.class
javac *.java 

function parse { 
  echo parsing nt_$1\(\)
  sed -i "s|parser\.nt_.*()|parser\.nt_$1()|g" Parse.java
  javac Parse.java
  for var in "${@:2}"
  do
    echo "$var" | java Parse
  done
}

parse ExpList "true, false, self.length" ""
parse ExpRest ", true"
parse PrimaryExp 1024 true false abc123 self "new arrayof(int)[true and self]" "new object abc123()" "! true" "isnull self" "(true)"
parse FieldDecl  'int x;' 'boolean x;'
parse Type int abc1234_ 'arrayof(int)' 'arrayof(Integer)' boolean
parse Var abc12340  nt_var Vector 