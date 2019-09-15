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
$ touch build/results/Testmonga.tab.txt
$ make
```