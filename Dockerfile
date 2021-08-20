# Run newsboat from a container

#sudo docker run --rm -it -v $(pwd)/config:/home/newsboat-user/.config/newsboat local/newsboat

FROM alpine:edge

RUN addgroup -g 1000 newsboat-user \
	&& adduser -D -h /home/newsboat-user -G newsboat-user -u 1000 newsboat-user

RUN apk --no-cache add \
	lynx \
	newsboat

# a browser is necessary!
ENV BROWSER lynx
RUN ln -s /usr/bin/lynx /usr/local/bin/lynx

#USER newsboat-user
ENV HOME /home/newsboat-user
ENV TERM xterm
RUN mkdir -p $HOME/.config/newsboat
COPY config/.lynxrc /home/newsboat-user/.lynxrc 
#COPY config/config /home/user/.config/newsboat/config 
#COPY config/urls /home/user/.config/newsboat/urls

ENV LANG C.UTF-8
#CMD ["which","lynx"]
#CMD ["sh"]
CMD ["newsboat"]
