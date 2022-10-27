FROM debian:buster

RUN apt-get -yq update && \
	apt-get -yq upgrade && \
	apt-get install -yq nginx openssl

COPY ./conf/ssl.conf /etc/nginx/conf.d/ssl.conf

RUN openssl req -new -newkey rsa:2048 -nodes \
    -out /etc/ssl/certs/wfermey.csr \
    -keyout /etc/ssl/private/wfermey.key \
    -subj "/C=FR/ST=GE/L=Mulhouse/O=42/OU=42/CN=wfermey.42.fr/UID=wfermey"

RUN openssl x509 -req -in /etc/ssl/certs/wfermey.csr -signkey /etc/ssl/private/wfermey.key -out /etc/ssl/certs/wfermey.crt

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]
