BUILD=build
SOURCEBALL=guacamole-built.tgz
INSTALLDIR=opt/extility/guacamole-client

all:
	/bin/rm -rf ${BUILD}
	/bin/mkdir -p ${BUILD}/${INSTALLDIR}/guacamole-common-js
	if [ -d guacamole-common-js/src/main/resources ] ; then ( tar --exclude="*~" --exclude="#*" -C guacamole-common-js/src/main/resources -cf - . | tar -C build/${INSTALLDIR}/guacamole-common-js -xf - ) ; fi
	if [ -d ./guacamole-common-js/src/main/webapp ] ; then ( tar --exclude="*~" --exclude="#*" --exclude=WEB-INF -C guacamole-common-js/src/main/webapp/ -cf - . | tar -C build/${INSTALLDIR} -xf - ); fi
	( tar --exclude="*~" --exclude="#*" --exclude=WEB-INF -C guacamole/src/main/webapp/ -cf - . | tar -C build/${INSTALLDIR} -xf - )

clean:
	/bin/rm -rf ${BUILD}

deploy:	all
	ssh root@192.168.250.11 rm -rf /opt/extility/guacamole-client && \
	scp -r build/opt/extility/guacamole-client root@192.168.250.11:/opt/extility/
