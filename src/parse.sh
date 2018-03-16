#!/bin/bash
function parse { 
  echo parsing nt_$1\(\)
  sed -ie "s|parser\.nt_.*()|parser\.nt_$1()|g" Parse.java
  javac Parse.java
  for var in "${@:2}"
  do
    echo "$var" | java Parse 
  done
}

function examples {
  parse Program
  for file in examples/*.moopl
  do
    echo file: $file
    echo "$(<$file)" | java Parse
  done
}

function pretty {
  for file in examples/*.moopl
  do
    out="$(java PrettyPrint $file | sed -e 's|//.*$||g')"
    in="$(cat $file | sed -e 's|//.*$||g')"
    printf "%s\n\n" $file
    #diff -I '/\*.*\*/' -BEwy --suppress-common-lines --color=auto <(echo "$out") <(echo "$in") 
    diff -I '/\*.*\*/' -BEwy --color=auto <(echo "$out") <(echo "$in") 
  done
}

#parsing
javacc Moopl-grammar.jj
sed -ie "s|.*parser.nt_Program()|\t\t\t//parser.nt_Program()|g" PrettyPrint.java
rm *.class
javac *.java 

#add tests for Moopl-grammar.jj here
examples

#semantic analysis
javacc Moopl.jj
sed -ie "s|.*parser.nt_Program()|\t\t\tparser.nt_Program()|g" PrettyPrint.java
rm *.class
javac *.java 

#add tests for Moopl.jj here
examples
pretty
