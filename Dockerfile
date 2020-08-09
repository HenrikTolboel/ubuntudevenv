# Ubuntu Development Environment (ubuntudevenv)
FROM ubuntu:latest

RUN apt-get update -y && apt-get install -y software-properties-common 
RUN add-apt-repository ppa:git-core/ppa
RUN apt-get update -y && apt-get install -y git zsh vim curl gnupg tree dos2unix sudo
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get install git-lfs && git lfs install

# get zulu java https://docs.azul.com/zulu/zuludocs/ZuluUserGuide/InstallingZulu/InstallOnLinuxUsingDebRepository.htm
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
ADD https://cdn.azul.com/zulu/bin/zulu-repo_1.0.0-2_all.deb /tmp
RUN dpkg -i /tmp/zulu-repo_1.0.0-2_all.deb && rm /tmp/zulu-repo_1.0.0-2_all.deb
RUN apt-get update -y && apt-get install -y zulu11-jdk

# install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
RUN apt-get update -y && apt-get install -y docker-ce docker-ce-cli containerd.io

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

RUN groupadd -g 1001 devuser && useradd -g 1001 -u 1001 -m -s /bin/zsh devuser
RUN usermod -aG docker devuser

RUN echo "devuser ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "Set disable_coredump false" >> /etc/sudo.conf

WORKDIR /home/devuser
USER devuser
VOLUME /home/devuser/.gradle
RUN echo "sudo chgrp docker /var/run/docker.sock" > .zshrc.local \
    && echo "sudo chown devuser:devuser .gradle" >> .zshrc.local
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/HenrikTolboel/dotfiles.git
RUN rm -f .zshrc && ln -s dotfiles/.zshrc && ln -s dotfiles/.gitconfig && ln -s dotfiles/.vimrc && ln -s dotfiles/.vimrc.priv

CMD /docker-entrypoint.sh
