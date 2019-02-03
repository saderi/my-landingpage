#!/usr/bin/env bash
set -e

# Define SERVER_WEBDISK in travis Environment Variables 
# Define HOST_USERNAME in travis Environment Variables 
# Define HOST_PASSWORD in travis Environment Variables 

LOCALPATH='./dist'
REMOTEPATH='/public_html'

mapfile -t DIR_LIST < <(tree -ifp --noreport $LOCALPATH)
for (( i=1; i<${#DIR_LIST[@]}; i++ ));
do 
    if [ ${DIR_LIST[i]:1:1} = 'd' ]; then
        # Create folders
        DIR_PATH=$(echo ${DIR_LIST[i]} | awk {'print $2'})
        DIR_NAME=${DIR_PATH#"$LOCALPATH"}
        curl -u $HOST_USERNAME:$HOST_PASSWORD -X MKCOL "$SERVER_WEBDISK$REMOTEPATH$DIR_NAME" >/dev/null 2>&1
    else
        # Upload files
        LOCAL_FILE_PATH=$(echo ${DIR_LIST[i]} | awk {'print $2'})
        FILE_PATH=${LOCAL_FILE_PATH#"$LOCALPATH"}
        mapfile -t FILE_PATH_LIST < <(echo $FILE_PATH | tr "/" "\n")
        FILE_NAME=$(echo ${FILE_PATH_LIST[${#FILE_PATH_LIST[@]}-1]})
        REMOTE_DIR_NAME=$(echo ${FILE_PATH%"$FILE_NAME"})
        curl  -u $HOST_USERNAME:$HOST_PASSWORD -T $LOCAL_FILE_PATH "$SERVER_WEBDISK$REMOTEPATH$REMOTE_DIR_NAME" >/dev/null 2>&1
    fi
done


