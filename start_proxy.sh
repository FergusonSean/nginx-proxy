if [[ ! -d ~/certs ]];
then
  mkdir ~/certs
fi

docker run -d -p 80:80 -p 443:443 \
    --name nginx-proxy \
    -v ~/certs:/etc/nginx/certs:ro \
    -v /etc/nginx/vhost.d \
    -v /usr/share/nginx/html \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    seanferguson/nginx-proxy

docker run -d \
    -v ~/certs:/etc/nginx/certs:rw \
    --volumes-from nginx-proxy \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    jrcs/letsencrypt-nginx-proxy-companion
