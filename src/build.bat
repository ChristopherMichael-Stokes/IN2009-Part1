@echo off
echo compiling javacc files
call javacc Moopl-grammar.jj 
echo. & echo compiling java files
call javac *.java
echo. & echo testing tokens
java TestTokens tokens
echo. & echo parsing grammar
call bash parse.sh
@echo on