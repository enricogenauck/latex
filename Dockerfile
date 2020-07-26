FROM alpine:3.12.0

ENV PATH="/usr/local/texlive/2020/bin/x86_64-linuxmusl:${PATH}"
ENV LC_ALL C.UTF-8

RUN mkdir /tmp/install-tl-unx
WORKDIR /tmp/install-tl-unx

# Install runtime dependencies
RUN apk --no-cache add fontconfig ghostscript

# Install TeX Live 2020 with some basic collections
RUN apk --no-cache --virtual .build-deps add perl wget xz tar && \
  wget -nv http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
  echo "selected_scheme scheme-basic" >> texlive.profile && \
  ./install-tl --profile=texlive.profile && \
  apk del .build-deps && \
  cd && rm -rf /tmp/install-tl-unx


# # Install additional packages
RUN apk --no-cache --virtual .build-deps add perl wget && \
  tlmgr install float && \
  tlmgr install babel-german && \
  tlmgr install hyphen-german && \
  tlmgr install markdown && \
  tlmgr install fancyvrb && \
  tlmgr install csvsimple && \
  tlmgr install pgf && \
  tlmgr install etoolbox && \
  tlmgr install paralist && \
  tlmgr install koma-script && \
  tlmgr install collection-fontsrecommended && \
  tlmgr install biblatex && \
  tlmgr install csquotes && \
  tlmgr install logreq && \
  tlmgr install biber && \
  tlmgr install xetex && \
  tlmgr install fontspec && \
  tlmgr install latexmk && \
  apk del .build-deps


RUN mkdir /src
WORKDIR /src
VOLUME /src
