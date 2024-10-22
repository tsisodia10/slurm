# Use a lightweight Ubuntu base image
FROM ubuntu:20.04

# Install required packages (SLURM, curl)
RUN apt-get update && \
    apt-get install -y slurm-wlm slurmctld slurmd curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for SLURM user and group
ENV SLURM_USER=slurm-3 \
    SLURM_GROUP=slurm-3 \
    PATH="/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# Create SLURM user and group
RUN groupadd -r ${SLURM_GROUP} && \
    useradd -r -g ${SLURM_GROUP} ${SLURM_USER}

# Create necessary directories for SLURM and set permissions
RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chown -R ${SLURM_USER}:${SLURM_GROUP} /var/spool/slurmd /var/log/slurm /etc/slurm-llnl /run/slurmctld && \
    chmod -R 777 /var/spool/slurmd /var/log/slurm /run/slurmctld

# Adjust permissions for the pidfile
RUN touch /run/slurmctld.pid && \
    chown ${SLURM_USER}:${SLURM_GROUP} /run/slurmctld.pid && \
    chmod 777 /run/slurmctld.pid

# Set SLURM configuration directory (to be mounted via Helm ConfigMap)
VOLUME /etc/slurm-llnl

# Expose necessary SLURM ports (for controller-node communication)
EXPOSE 6817 6818

# Verify slurmctld is available in the PATH
RUN which slurmctld || echo "slurmctld not found in PATH"

# Use ENTRYPOINT to start the SLURM controller directly as root
ENTRYPOINT ["/usr/sbin/slurmctld", "-Dvv"]
