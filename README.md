# Monga compiler project
---

This project implements a compiler for the simple language Monga.
To install and test it:

```sh
$ git clone https://github.com/maxd13/compiladores.git
$ cd compiladores
$ git clone https://github.com/ThrowTheSwitch/Unity.git
$ git pull
$ mkdir -p build/results
$ touch build/results/Testlex.yy.txt
$ make
```

if anything goes wrong during make, try:
```sh
$ rm src/lex.yy.c src/lex.yy.h
$ make
```