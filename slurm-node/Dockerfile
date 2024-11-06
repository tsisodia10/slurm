FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    slurmd \
    munge \
    curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN userdel -r munge || true && groupdel munge || true
RUN userdel -r slurm || true && groupdel slurm || true

RUN groupadd -r munge && useradd -r -g munge munge && \
    groupadd -r slurm && useradd -r -g slurm slurm

RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmd /etc/munge /var/log/munge /var/lib/munge /run/munge && \
    chown -R munge:munge /etc/munge /var/log/munge /var/lib/munge /run/munge && \
    chmod 0700 /etc/munge /var/log/munge /var/lib/munge && \
    chmod 0755 /run/munge && \
    chown -R slurm:slurm /var/spool/slurmd /var/log/slurm /run/slurmd && \
    chmod 0755 /var/log/slurm

COPY munge.key /etc/munge/munge.key
RUN chown munge:munge /etc/munge/munge.key && chmod 400 /etc/munge/munge.key

EXPOSE 6817 6818 6820

COPY start-script.sh /usr/local/bin/start-script.sh
RUN chmod +x /usr/local/bin/start-script.sh

VOLUME /etc/slurm-llnl
VOLUME /etc/munge
VOLUME /var/spool

ENTRYPOINT ["/usr/local/bin/start-script.sh"]
