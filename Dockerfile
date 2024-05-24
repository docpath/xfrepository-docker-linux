FROM openjdk:8

RUN mkdir -p /required_files
COPY xfrepositorypackallplatforms-6.x.y-java.jar /required_files/xf-installer.jar
WORKDIR /required_files
RUN java -jar xf-installer.jar -console -silentmode -install -solution"/usr/local/docpath/xfservicepack/xfservice" -solname"DocPath XF Repository Service" -adminusername"admin" -adminpassword"admin" -licserverpath"/usr/local/docpath/licenseserver" -licserverport"1765" -databaseserver"MySQL" -databasename"xfrepository" -databasehost"localhost" -databaseport"3306" -databaseuser"root" -databasepassword"root" -databasecheckconnection"false"
WORKDIR /
RUN rm -rf /required_files
COPY DocPath_License_File.olc /usr/local/docpath/Licenses/
COPY run.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh
EXPOSE 1818

ENTRYPOINT ["/usr/local/bin/run.sh"]


