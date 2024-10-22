FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y slurm-wlm slurmd curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV SLURM_USER=slurm-2 \
    SLURM_GROUP=slurm-2 \
    PATH="/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

RUN groupadd -r ${SLURM_GROUP} && \
    useradd -r -g ${SLURM_GROUP} ${SLURM_USER}

RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chown -R ${SLURM_USER}:${SLURM_GROUP} /var/spool/slurmd /var/log/slurm /etc/slurm-llnl /run/slurmctld && \
    chmod -R 777 /var/spool/slurmd /var/log/slurm /run/slurmctld

EXPOSE 6818

RUN which slurmd || echo "slurmd not found in PATH"

ENTRYPOINT ["slurmd", "-Dvv"]
