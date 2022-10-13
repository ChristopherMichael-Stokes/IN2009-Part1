#!/bin/bash
echo "compiling javacc"
javacc Moopl-grammar.jj
printf "\ncompiling java source\n"
javac *.java
printf "\ntesting tokens\n"
java TestTokens tokens
echo "done"