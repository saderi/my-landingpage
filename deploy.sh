#!/usr/bin/env bash
set -e
echo 'set ssl:verify-certificate off;' > ~/.lftprc
echo 'set ftp:ssl-allow off;' >> ~/.lftprc

LOCALPATH='./dist'
REMOTEPATH='/public_html'

lftp -u ${FTP_USER},${FTP_PASSWORD} ${FTP_HOST} << EOF
mirror --continue ${LOCALPATH} ${REMOTEPATH}
bye
EOF
