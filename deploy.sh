#!/usr/bin/env bash
set -e
echo 'set ssl:verify-certificate off;' > ~/.lftprc
echo 'set ftp:ssl-allow off;' >> ~/.lftprc

LOCALPATH='./dist'
REMOTEPATH='/public_html/test'

lftp -u ${FTP_USER},${FTP_PASSWORD} ${FTP_HOST} << EOF
mirror --continue --reverse ${LOCALPATH} ${REMOTEPATH}
bye
EOF
