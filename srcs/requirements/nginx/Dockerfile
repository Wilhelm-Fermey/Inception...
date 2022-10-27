FROM debian:buster

RUN apt-get -yq update && \
	apt-get -yq upgrade && \
	apt-get install -yq nginx openssl

COPY ./conf/ssl.conf /etc/nginx/conf.d/ssl.conf
COPY ./tools/replace.sh /replace.sh
COPY ./tools/start.sh /start.sh
RUN bash /replace.sh "DOMAIN_NAME" wfermey.42.fr /etc/nginx/conf.d/ssl.conf && \
	bash /replace.sh "LOGIN" wfermey /etc/nginx/conf.d/ssl.conf

# SSL configuration
RUN openssl req -new -newkey rsa:2048 -nodes \
     -out /etc/ssl/certs/wfermey.csr \
     -keyout /etc/ssl/private/wfermey.key \
     -subj "/C=FR/ST=GE/L=Mulhouse/O=42/OU=42/CN=jperras.42.fr/UID=jperras"
RUN openssl x509 -req -in /etc/ssl/certs/wfermey.csr -signkey /etc/ssl/private/wfermey.key -out /etc/ssl/certs/wfermey.crt

EXPOSE	443

ENTRYPOINT ["bash", "/start.sh"]
