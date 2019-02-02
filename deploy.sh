#!/usr/bin/env bash
set -e
echo 'set ssl:verify-certificate off;' >> /etc/lftp.conf
echo 'set ftp:ssl-allow off;' >> /etc/lftp.conf

LOCALPATH='./dist'
REMOTEPATH='/public_html'

lftp -u ${FTP_USER},${FTP_PASSWORD} ${FTP_HOST} << EOF
mirror --continue --reverse ${LOCALPATH} ${REMOTEPATH}
bye
EOF
