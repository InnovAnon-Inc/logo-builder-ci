FROM innovanon/logo-builder as builder
USER root
#ENV GOPATH=${HOME}/go
#ENV PATH=${PATH}:${HOME}/go/bin
#ENV PATH=${PATH}:${GOPATH}/bin
COPY ./dpkg.list  /tmp/
COPY ./gopath.sh  /etc/profile.d/
RUN sleep 91                        \
 && apt update                      \
 && apt full-upgrade                \
 && test -x       /tmp/dpkg.list    \
 && apt install $(/tmp/dpkg.list)   \
 && rm -v         /tmp/dpkg.list    \
 && go get -u github.com/tcnksm/ghr \
 && command -v                  ghr

#FROM builder as squash-tmp
#USER root
#RUN  squash.sh
#FROM scratch as squash
#ADD --from=squash-tmp /tmp/final.tar /

FROM builder
