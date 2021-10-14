all:
#	service
	rm -rf ebin/* *~ */*~ ;
#	application
	cp src/*.app ebin;
	rm -rf src/*.beam *.beam;
	echo Done
