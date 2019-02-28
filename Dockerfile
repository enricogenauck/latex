FROM ubuntu:18.04

RUN \
  apt-get update --quiet && \
  apt-get install --quiet --yes build-essential && \
  apt-get install --quiet --yes wget && \
  apt-get install --quiet --yes libfontconfig1 && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN \
  wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  mkdir /install-tl-unx && \
  tar -xvf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1 && \
  echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile && \
  /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile && \
  rm -r /install-tl-unx && \
  rm install-tl-unx.tar.gz

RUN \
  /usr/local/texlive/2018/bin/x86_64-linux/tlmgr install float && \
  /usr/local/texlive/2018/bin/x86_64-linux/tlmgr install babel-german && \
  /usr/local/texlive/2018/bin/x86_64-linux/tlmgr install koma-script

ENV PATH="/usr/local/texlive/2018/bin/x86_64-linux:${PATH}"
ENV HOME /data
ENV LC_ALL C.UTF-8

WORKDIR /data
