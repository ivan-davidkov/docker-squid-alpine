#!/bin/sh

set -e

CHOWN=$(/usr/bin/which chown)
OSSL=$(/usr/bin/which openssl)
SSLCRTD=/usr/lib/squid/ssl_crtd
SQUID=$(/usr/bin/which squid)

FCACHE="/var/cache/squid"
FLOG="/var/log/squid"
FSSL="/etc/squid/ssl_cert"
FSSLDB="/var/lib/ssl_db"

# Ensure permissions are set correctly on the Squid cache + log dir.
"$CHOWN" -R squid:squid $FCACHE

# Prepare CERTS forlder
mkdir "$FSSL"
"$CHOWN" -R squid:squid "$FSSL"

# Generate new cert.
"$OSSL" req -new -newkey rsa:2048 -sha256 -days 365 -nodes -x509 -extensions v3_ca -keyout "$FSSL/myCA.pem" -out "$FSSL/myCA.pem" -subj "/C=BE/ST=NOne/L=Brussels/O=Self/CN=localhost.localdomain"

# Prepare the cache using Squid.
echo "Initializing cache..."
"$SQUID" -z "$FCACHE"

# Give the Squid cache some time to rebuild.
sleep 5

# Prepare the TLS certificate.
echo "Initializing SSLs DB..."
test -d "$FSSLDB" && rm "$FSSLDB"
"$SSLCRTD" -c -s "$FSSLDB" -M 4MB
"$CHOWN" -R squid:squid "$FSSLDB"
 
# Launch squid.
echo "Starting Squid..."
exec "$SQUID" -NYCd 1
