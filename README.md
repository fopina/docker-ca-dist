# docker-ca-dist
docker image for distributing an internal Certificate Authority (CA)

Recently had the need to distribute an internal CA and the easiest ripoff I could think of was [mitmproxy](https://mitmproxy.org/) [mitm.it](http://mitm.it) page (when you're proxying through it to install the CA it generates): it's minimalistic yet shows instructions how to install the CA in a multitude of browsers/systems.

This docker image is just a nginx image with a `wget -r mitm.it` templated index.html. If you still haven't created your own CA, I strongly recommend [minica](https://github.com/jsha/minica) (pre-compiled binaries in my [fork](https://github.com/fopina/minica/releases/tag/v1.0.2-1))

## Usage

If you only have the `.pem` version of your CA, create a `.p12` version (for windows) with:

```
openssl pkcs12 -export -out ca.p12 -in ca.pem -nokeys
```

Place `ca.pem` and `ca.p12` in a directory and bind-mount it to `/usr/share/nginx/html/certs`

```
docker run -d \
           -v .../mycerts:/usr/share/nginx/html/certs:ro \
           -p 80:80 \
           fopina/ca-dist
```

## Advanced Usage

Personal touch is always nice, even on something dull as distributing a CA.

A few env vars are available to customize the page:


* `CADIST_NAME` used often in the pageto reference the CA. default `(unknown)`, customization recommended!
* `CADIST_TITLE` just the HTML `<title>` content. default `${CADIST_NAME} CA`
* `CADIST_FILE_PEM` and `CADIST_FILE_P12` are the filenames in the volume (used in the links). default to `ca.pem` and `ca.p12`
* `CADIST_FOOTER` muted text at the bottom of the page. default `CA used to issue certificates for internal ${CADIST_NAME} webservices`

Favicon can be replaced by mounting the new one on `/usr/share/nginx/html/static/images/favicon.ico`

Example:

```
docker run -d \
           -v .../mycerts:/usr/share/nginx/html/certs:ro \
           -v .../mycoolfavicon.ico:/usr/share/nginx/html/static/images/favicon.ico:ro \
           -e CADIST_NAME=myHomeCloud \
           -e CADIST_FOOTER="Trust me" \
           -p 80:80 \
           fopina/ca-dist
```
