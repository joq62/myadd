all:
#	service
	rm -rf ebin/* *~ */*~ ;
#	application
	cp src/*.app ebin;
	erlc -o ebin src/*.erl;
	echo Done
