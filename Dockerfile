FROM nginx:1.17-alpine

RUN wget https://github.com/fopina/confgen/releases/download/v0.1.0/confgen_linux_amd64 -O /usr/local/bin/confgen
RUN chmod a+x /usr/local/bin/confgen

ADD www /usr/share/nginx/html
ADD files/index.html.tmpl /usr/share/nginx/
ADD files/docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
