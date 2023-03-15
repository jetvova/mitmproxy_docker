FROM ubuntu:22.04

# Installing python 3.11
RUN apt-get update && \
    apt-get install -y python3.10 \
                       python3.10-venv \
                       curl \
                       iproute2 \
                       iputils-ping \
                       wireguard \
                       python3-pip \
                       tcpdump \
                       iproute2 \
                       net-tools \
                       netcat \
                       socat \
                       openssh-client \
                       git \
                       sudo

ARG HOME
ARG UNAME
ARG UID
ARG GNAME
ARG GID


# Ensure sudo group users are not 
# asked for a password when using 
# sudo command by ammending sudoers file
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Installing maturin for mitmproxy_rs
RUN pip install --upgrade pip
RUN pip install maturin
RUN pip install maturin[patchelf]

RUN mkdir -p $HOME
RUN groupadd -g $GID $GNAME
RUN useradd -m -d $HOME -u $UID -g $GID -s /bin/bash $UNAME
RUN sudo usermod -aG sudo $UNAME
RUN chown -R $UNAME:$GNAME $HOME

USER $UNAME
WORKDIR $HOME

# Installing rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

RUN echo -e "source ~/.cargo/env" > .bashrc

CMD /bin/bash
