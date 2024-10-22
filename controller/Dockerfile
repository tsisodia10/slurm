FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y slurm-wlm slurmctld slurmd curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SLURM_USER=slurm-3 \
    SLURM_GROUP=slurm-3 \
    PATH="/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

RUN groupadd -r ${SLURM_GROUP} && \
    useradd -r -g ${SLURM_GROUP} ${SLURM_USER}

RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chown -R ${SLURM_USER}:${SLURM_GROUP} /var/spool/slurmd /var/log/slurm /etc/slurm-llnl /run/slurmctld && \
    chmod -R 777 /var/spool/slurmd /var/log/slurm /run/slurmctld

RUN touch /run/slurmctld.pid && \
    chown ${SLURM_USER}:${SLURM_GROUP} /run/slurmctld.pid && \
    chmod 777 /run/slurmctld.pid

VOLUME /etc/slurm-llnl

EXPOSE 6817 6818

RUN which slurmctld || echo "slurmctld not found in PATH"

ENTRYPOINT ["/usr/sbin/slurmctld", "-Dvv"]
