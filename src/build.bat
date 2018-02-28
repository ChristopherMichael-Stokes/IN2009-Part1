@echo off
echo compiling javacc files
call javacc Moopl-grammar.jj 
echo. & echo compiling java files
call javac *.java
echo done
@echo on