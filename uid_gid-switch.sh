#!bin/bash
#need to switch 2 user id & group id's
_user_uid="$(id -un 999)"
_user_gid="$(id -gn 999)"

_mongodb_uid="$(id -u mongodb)"
_mongodb_gid="$(id -g mongodb)"

_sys_uid=999

if [ $_user_uid != mongodb ]; then
     sudo groupmod -g 8888 $_user_uid
     sudo usermod -u 8888 -g 8888 $_user_uid
     sudo find / -user 999 -exec chown -h $_user_uid {} \; 2>/dev/null ;
     sudo find / -group 999 -exec chgrp -h $_user_uid {} \; 2>/dev/null ;
else
     echo "Not required to swithch uid & gid"
fi

if [ $_mongodb_gid != $_sys_uid ]; then
     sudo groupmod -g 999 mongodb
     sudo usermod -u 999 -g 999 mongodb
     sudo find / -user $_mongodb_uid -exec chown -h mongodb {} \;  2>/dev/null ;
     sudo find / -group $_mongodb_gid -exec chgrp -h mongodb {} \;  2>/dev/null ;
else
      echo "Not required to swithch uid & gid for mongodb"
fi
