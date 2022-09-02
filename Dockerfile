# Pull base image
FROM art-decor-base

WORKDIR /root
ADD assets /root/assets

# Just for a more pleasant bash experience
RUN mv assets/bash/bash.bashrc /etc
RUN mv assets/bash/profile /etc
RUN mv assets/bash/bashrc.root /root/.bashrc
RUN mv assets/bash/profile.root /root/.profile

RUN mv /root/assets/install_art_decor.sh /root
RUN bash /root/assets//install_art_decor.sh && \
    bash /assets/start_services.sh