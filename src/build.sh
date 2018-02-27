#!/bin/bash

src='~/Documents/IN2009-Tutorials/Moople-Cwk1/src'
javacc Moopl-grammar.jj
javac *.java

alias testTokens='java src/TestTokens'
