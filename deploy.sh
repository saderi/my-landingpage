#!/usr/bin/env bash
set -e

LOCALPATH='./dist'
REMOTEPATH='/public_html'

lftp -f "
open ftp://$FTP_HOST
user $FTP_USER $FTP_PASSWORD
mirror --continue --reverse --delete $LOCALPATH $REMOTEPATH
bye
" 