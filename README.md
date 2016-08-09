# docker-weechat
running weechat in docker

## building
to build the docker image from scratch run:
```
docker build -t "doebi/weechat" .
```

## running
it is recommended to use your local .weechat as volume to persist weechat's settings:
`mkdir ~/.weechat`

start the container by running:
`docker run --name=weechat -v ~/.weechat:/home/user/.weechat -t -i doebi/weechat`
