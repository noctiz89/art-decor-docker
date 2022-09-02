# Pull base image
FROM art-decor-base

WORKDIR /root
COPY assets /root/assets

# Just for a more pleasant bash experience
RUN mv assets/bash/bash.bashrc /etc
RUN mv assets/bash/profile /etc
RUN mv assets/bash/bashrc.root /root/.bashrc
RUN mv assets/bash/profile.root /root/.profile
RUN mv assets/install_art_decor.sh /root
RUN mv assets/start_services.sh /root
 
RUN /root/assets/install_art_decor.sh

CMD ["/root/assets/start_services.sh"]