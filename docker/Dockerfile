
FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y curl git build-essential python

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN npm install --global yarn
RUN npm install --global typescript
RUN npm install node-pre-gyp -g
RUN npm install -g nodemon

RUN git clone https://github.com/udp/bioterms.git && \
    git clone https://github.com/udp/sbolgraph.git && \
    git clone https://github.com/SynBioCAD/biocad.git && \
    git clone https://github.com/SynBioCAD/jfw.git && \
    git clone https://github.com/SynBioHub/synbiohub-lab.git && \
    git clone https://github.com/udp/fmaprefix.git

RUN mv -t /opt bioterms sbolgraph biocad jfw synbiohub-lab fmaprefix

RUN cd /opt/bioterms && \
    git checkout ce0b8b4d93e164867d5eee63ca805b6819ee22a9 && \
    export NODE_PATH=dist && \
    yarn install && \
    yarn link

RUN cd /opt/sbolgraph && \
    git checkout 5152cc2fbb309d377a8a619b6c0c278a23a7723e && \
    export NODE_PATH=dist && \
    yarn link bioterms && \
    yarn install || : && \
    yarn link

RUN cd /opt/jfw && \
    git checkout 3749d9f5ff31fafdeeafd1954080355d1ca777bf && \
    export NODE_PATH=dist && \
    yarn install || : && \
    yarn link

RUN cd /opt/biocad && \
    git checkout sbh-l && \
    export NODE_PATH=dist && \
    yarn link bioterms && \
    yarn link sbolgraph && \
    yarn link @biocad/jfw && \
    yarn install || : && \
    yarn link

RUN cd /opt/synbiohub-lab && \
    export NODE_PATH=dist && \
    yarn link bioterms && \
    yarn link sbolgraph && \
    yarn link @biocad/biocad && \
    yarn install || : && \
    tsc -d -p ./ --outDir dist/ || :

RUN cd /opt/fmaprefix && \
    gcc ./fmaprefix.c && \
    mv ./a.out ./fmaprefix && \
    cp ./fmaprefix ../synbiohub-lab/bin

COPY run.sh /opt/synbiohub-lab/run.sh
CMD bash ./run.sh
