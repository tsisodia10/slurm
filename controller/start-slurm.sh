#!/bin/bash

# Wait for slurm.conf to be available
while [ ! -f /etc/slurm-llnl/slurm.conf ]; do
  echo "Waiting for /etc/slurm-llnl/slurm.conf..."
  sleep 5
done

echo "slurm.conf found. Starting SLURM..."

# Run the SLURM command passed as an argument (controller or node)
exec "$@"
