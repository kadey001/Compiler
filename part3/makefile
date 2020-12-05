make: 
	bison -v -d --file-prefix=y mini_l.y
	flex mini_l.lex
	g++ -o parser y.tab.c lex.yy.c -lfl

clean:
	rm y.tab.c y.tab.h y.output
