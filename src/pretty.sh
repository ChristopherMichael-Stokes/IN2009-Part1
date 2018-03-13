#!/bin/bash
javacc Moopl-grammar.jj
rm *.class
javac *.java 
