FROM ubuntu
RUN apt-get update

RUN mkdir /datos
WORKDIR /datos
RUN touch f1.txt
RUN mkdir /datos1
WORKDIR /datos1
RUN touch f2.txt

#COPY#
COPY index.html .
COPY app.log /datos

#ADD#
ADD docs docs
ADD f* /datos/
ADD targets.tar.gz .

#ENV
ENV dir=/data dir1=/data1
RUN mkdir $dir	&& mkdir $dir1

#VOLUME#
ADD paginas /var/www/html
# Anadimos la carpeta paginas a ese path
# es el directorio donde apache aloja sus statics
VOLUME ["/var/www/html"]
# creo el volumen basado en ese directorio.
RUN apt-get install -y --no-install-recommends tzdata
RUN apt -y install apache2
#Instalamos apache2
EXPOSE 80
# apache escucha por el puerto 80
ADD entrypoint.sh /datos1
##CMD#
CMD /datos1/entrypoint.sh

#ENTRYPOINT
#ENTRYPOINT ["/bin/bash"]
