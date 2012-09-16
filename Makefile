BUILD=build
UPDATE=update.tmp
SOURCEBALL=guacamole-built.tgz
INSTALLDIR=opt/extility/guacamole-client

all:
	/bin/mkdir -p ${BUILD} && \
	tar -C ${BUILD} -xvzf ${SOURCEBALL}

update:	
	/bin/rm -rf ${UPDATE}
	/bin/mkdir -p ${UPDATE} && \
	( cd ${UPDATE} && \
	mkdir -p ${INSTALLDIR} && \
	git clone git://git.alex.org.uk/guacamole.git/ && \
	( cd guacamole/src/main/webapp && tar -cf - --exclude=META-INF --exclude=WEB-INF *) | (cd ${INSTALLDIR} && tar -xf -) && \
	git clone git://guacamole.git.sourceforge.net/gitroot/guacamole/guacamole-common-js && \
	mkdir -p ${INSTALLDIR}/guacamole-common-js && \
	( cd guacamole-common-js/src/main/resources/ && tar -cf - *.js ) | (cd ${INSTALLDIR}/guacamole-common-js && tar -xf -) && \
	tar cvzf ../${SOURCEBALL} ${INSTALLDIR} \
	)  && \
	/bin/rm -rf ${UPDATE}

clean:
	/bin/rm -rf ${BUILD} ${UPDATE}

