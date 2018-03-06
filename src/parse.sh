#!/bin/bash
javacc *.jj
rm *.class
javac *.java 

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
    echo "$(<$file)" | java Parse
  done
}

examples
#parse FormalRest ", int i"
#parse Statement "int x;" "vec = new object b(true).length;" "20[30 and self] = false;"\
#	"if(!isnull str) then {{int i;}} else {}"
#parse Exp true "abc.length" "var.func(input1, in2, true)" "new object obj(var, true, 1)[20]" "true and false"
#parse ExpList "true, false, self.length" ""
#parse ExpRest ", true"
#parse PrimaryExp 1024 true false abc123 self "new arrayof(int)[true and self]"\
#	"new object abc123()" "! true" "isnull self" "(true)"
#parse FieldDecl  'int x;' 'boolean x;'
#parse Type int abc1234_ 'arrayof(int)' 'arrayof(Integer)' boolean
#parse Var abc12340  nt_var Vector 
