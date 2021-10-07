FROM debian:10

ENV SMVERSION 1.10

ENV _clean="rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"
ENV _apt_clean="eval apt-get clean && $_clean"

RUN apt-get update -qqy && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl wget nano net-tools gnupg2 git lib32stdc++6 python \
    python-pip tar bash && $_apt_clean

RUN mkdir /src
RUN mkdir /builder
RUN mkdir /runscripts
RUN mkdir /out
WORKDIR /builder

RUN git clone https://github.com/splewis/sm-builder
WORKDIR /builder/sm-builder
RUN pip install --user -r requirements.txt
RUN python setup.py install --prefix=~/.local
WORKDIR /builder

ENV SMPACKAGE http://sourcemod.net/latest.php?os=linux&version=${SMVERSION}
RUN wget -q ${SMPACKAGE}
RUN tar xfz $(basename ${SMPACKAGE})
RUN chmod +x /builder/addons/sourcemod/scripting/spcomp
ENV PATH "$PATH:/builder/addons/sourcemod/scripting:/root/.local/bin"
WORKDIR /builder/addons/sourcemod/scripting/include
RUN wget https://raw.githubusercontent.com/KyleSanderson/SteamWorks/master/Pawn/includes/SteamWorks.inc
WORKDIR /builder

VOLUME /src
VOLUME /out

COPY docker_run.sh /runscripts

CMD ["/runscripts/docker_run.sh"]
