#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Now call run_viromics.bash with the SLURM profile arguments
$SCRIPT_DIR/run_viromics.bash --profile profiles/slurm \
        --max-jobs-per-second 1 \
        --scheduler greedy \
        $@
