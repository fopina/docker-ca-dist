FROM nginx:1.19-alpine

RUN wget -O /usr/local/bin/confgen \
    https://github.com/fopina/confgen/releases/download/v0.1.0/confgen_linux_$(uname -m | grep -q x86_64 && echo amd64 || echo arm)
RUN chmod a+x /usr/local/bin/confgen

ADD www /usr/share/nginx/html
ADD files/index.html.tmpl /usr/share/nginx/
ADD files/docker-entrypoint.sh /entrypoint.sh

ARG VERSION=dev
LABEL version="${VERSION}" maintainer="fopina <https://github.com/fopina/docker-ca-dist/>"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "nginx", "-g", "daemon off;" ]
