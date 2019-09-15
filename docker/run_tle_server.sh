docker run -it -p ${TLE_SERVER_LISTEN:-127.0.0.1}:${TLE_SERVER_PORT:-5000}:5000 	\
  --rm -it --name=tle-server                    \
  --net=tle-network                             \
  -v ${PWD}/../bin:/data/Lacuna-Server/bin      \
  -v ${PWD}/../docs:/data/Lacuna-Server/docs    \
  -v ${PWD}/../etc:/data/Lacuna-Server/etc      \
  -v ${PWD}/../lib:/data/Lacuna-Server/lib      \
  -v ${PWD}/../t:/data/Lacuna-Server/t          \
  -v ${PWD}/../var:/data/Lacuna-Server/var      \
  -v ${PWD}/../mission:/data/Lacuna-Mission     \
  --volumes-from tle-captcha-data               \
  lacuna/tle-server /bin/bash

