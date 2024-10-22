# Use a lightweight Ubuntu base image
FROM ubuntu:20.04

# Install required packages (SLURM nodes, curl, etc.)
RUN apt-get update && \
    apt-get install -y slurm-wlm slurmd curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV SLURM_USER=slurm-2 \
    SLURM_GROUP=slurm-2 \
    PATH="/usr/sbin:/usr/bin:/sbin:/bin:$PATH"

# Create SLURM user and group
RUN groupadd -r ${SLURM_GROUP} && \
    useradd -r -g ${SLURM_GROUP} ${SLURM_USER}

# Create necessary directories
RUN mkdir -p /etc/slurm-llnl /var/spool/slurmd /var/log/slurm /run/slurmctld && \
    chown -R ${SLURM_USER}:${SLURM_GROUP} /var/spool/slurmd /var/log/slurm /etc/slurm-llnl /run/slurmctld && \
    chmod -R 777 /var/spool/slurmd /var/log/slurm /run/slurmctld

# Expose SLURM ports
EXPOSE 6818

# Verify slurmd is available in the PATH
RUN which slurmd || echo "slurmd not found in PATH"

# Use ENTRYPOINT to start the SLURM node with correct format
ENTRYPOINT ["slurmd", "-Dvv"]
