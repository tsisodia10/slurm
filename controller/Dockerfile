FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y slurm-wlm slurmctld munge curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld /etc/munge /var/log/munge /var/lib/munge /run/munge && \
    chown -R munge:munge /etc/munge /var/log/munge /var/lib/munge /run/munge && \
    chmod 0700 /etc/munge /var/log/munge /var/lib/munge /run/munge && \
    chmod -R 777 /var/spool /var/spool/slurmd /var/log/slurm /run/slurmctld

RUN mkdir -p /var/spool/slurmd /var/log/slurm && chmod -R 777 /var/spool/slurmd /var/log/slurm

RUN /usr/sbin/create-munge-key

EXPOSE 6817 6818 6820

VOLUME /etc/slurm-llnl
VOLUME /etc/munge
VOLUME /var/spool  # Persist state files across restarts

ENTRYPOINT ["/usr/sbin/slurmctld", "-Dvv"]
