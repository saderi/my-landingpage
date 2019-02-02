#!/usr/bin/env bash
set -e
echo 'set ssl:verify-certificate off;' > ~/.lftprc
echo 'set ftp:ssl-allow off;' >> ~/.lftprc

LOCALPATH='./dist'
REMOTEPATH='/public_html'
lftp -f "
open ftp://$FTP_HOST
user $FTP_USER $FTP_PASSWORD
mirror --continue --reverse $LOCALPATH $REMOTEPATH
bye
" 

