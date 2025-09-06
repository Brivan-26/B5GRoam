#!/bin/bash

# Create initial Powers of Tau file
echo "Step 1: Creating initial Powers of Tau file..."
snarkjs powersoftau new bn128 14 pot14_0000.ptau -v

# First contribution (prompt for random text, use "blabla")
echo "Step 2: First contribution..."
echo -e "blabla" | snarkjs powersoftau contribute pot14_0000.ptau pot14_0001.ptau --name="First contribution" -v

# Second contribution (use "some random text")
echo "Step 3: Second contribution..."
snarkjs powersoftau contribute pot14_0001.ptau pot14_0002.ptau --name="Second contribution" -v -e="some random text"

# Export challenge
echo "Step 4: Exporting challenge..."
snarkjs powersoftau export challenge pot14_0002.ptau challenge_0003

# Contribute to the challenge (use "some random text")
echo "Step 5: Contributing to the challenge..."
snarkjs powersoftau challenge contribute bn128 challenge_0003 response_0003 -e="some random text"

# Import response
echo "Step 6: Importing response..."
snarkjs powersoftau import response pot14_0002.ptau response_0003 pot14_0003.ptau -n="Third contribution name"

# Verify the Powers of Tau file
echo "Step 7: Verifying Powers of Tau file..."
snarkjs powersoftau verify pot14_0003.ptau
if [ $? -ne 0 ]; then
    echo "Verification failed. Exiting."
    exit 1
fi

# Apply the beacon
echo "Step 8: Applying the beacon..."
snarkjs powersoftau beacon pot14_0003.ptau pot14_beacon.ptau 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon"

# Prepare phase 2
echo "Step 9: Preparing phase 2..."
snarkjs powersoftau prepare phase2 pot14_beacon.ptau pot14_final.ptau -v

echo "Pre-processing completed successfully! Final file: pot14_final.ptau"