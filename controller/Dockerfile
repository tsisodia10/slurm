FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    git \
    autoconf \
    automake \
    libtool \
    pkg-config \
    libssl-dev \
    libgcrypt20-dev \
    bison \
    flex \
    make \
    gcc \
    curl \
    slurm-wlm \
    slurmctld \
    slurmd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/dun/munge.git && \
    cd munge && \
    ./bootstrap && \
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --runstatedir=/run && \
    make && \
    make check && \
    make install && \
    cd .. && rm -rf munge

RUN userdel -r munge || true && groupdel munge || true
RUN userdel -r slurm || true && groupdel slurm || true
RUN groupadd -r munge && useradd -r -g munge munge
RUN groupadd -r slurm && useradd -r -g slurm slurm

RUN mkdir -p /etc/munge /var/lib/munge /var/log/munge /run/munge && \
    chown -R munge:munge /etc/munge /var/lib/munge /var/log/munge /run/munge && \
    chmod 0700 /etc/munge && \
    chmod 0700 /var/lib/munge && \
    chmod 0700 /var/log/munge && \
    chmod 0755 /run/munge

RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chown -R slurm:slurm /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chmod 0755 /var/log/slurm && \
    chmod 0755 /run/slurmctld && \
    touch /run/slurmctld.pid && chown slurm:slurm /run/slurmctld.pid && chmod 0755 /run/slurmctld.pid

RUN chmod 0755 /run

COPY munge.key /etc/munge/munge.key
RUN chown munge:munge /etc/munge/munge.key && chmod 400 /etc/munge/munge.key

COPY start-script.sh /usr/local/bin/start-script.sh
RUN chmod +x /usr/local/bin/start-script.sh

EXPOSE 6817 6818 6820

CMD ["/usr/local/bin/start-script.sh"]
