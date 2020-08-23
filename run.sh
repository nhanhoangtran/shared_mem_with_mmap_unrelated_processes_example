#!/bin/bash

function is_linux
{
	if [[ "$(uname)" == "Linux" ]]; then
		echo 1
		return
	fi

	echo 0
}

SET="set"
GET="get"
CFLAGS=""
LDFLAGS=""
if [[ "$(is_linux)" == "1" ]]; then
	LDFLAGS="-lrt"
fi

cc ${CFLAGS} -o ${SET} ${SET}.c ${LDFLAGS}
cc ${CFLAGS} -o ${GET} ${GET}.c ${LDFLAGS}

./${SET} &

if [[ "$(is_linux)" == "1" ]]; then
	echo "/dev/shm:"
	ls -l /dev/shm
fi

sleep 1
./${GET}

if [[ "$(is_linux)" == "1" ]]; then
	echo "/dev/shm:"
	ls -l /dev/shm
fi
sleep 1

rm ${SET} ${GET}