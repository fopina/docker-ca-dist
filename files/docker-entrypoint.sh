#!/bin/sh

[[ -z "${CADIST_NAME}" ]] && export CADIST_NAME="(unknown)"
[[ -z "${CADIST_TITLE}" ]] && export CADIST_TITLE="${CADIST_NAME} CA"
[[ -z "${CADIST_FILE_PEM}" ]] && export CADIST_FILE_PEM="ca.pem"
[[ -z "${CADIST_FILE_P12}" ]] && export CADIST_FILE_P12="ca.p12"
[[ -z "${CADIST_FOOTER}" ]] && export CADIST_FOOTER="CA used to issue certificates for internal ${CADIST_NAME} webservices"

confgen -o /usr/share/nginx/html/index.html /usr/share/nginx/index.html.tmpl

exec "$@"
