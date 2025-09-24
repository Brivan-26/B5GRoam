# B5G-Roaming Settlement Framework

This repository implements a proof-of-concept framework for **secure, transparent, and privacy-preserving roaming settlement** in 5G networks described in the following paper: https://arxiv.org/abs/2509.16390.  
It leverages **blockchain smart contracts**, **zero-knowledge circuits**, and a **private Ethereum setup** to simulate inter-operator roaming agreements, session management, and settlement.

---

## 📂 Repository Structure

### 1. `circuits/circom`
Contains **zero-knowledge proof circuits** written in [Circom](https://docs.circom.io/):
- **`CDRGeneration.circom`** – Defines the circuit for generating hashes of Call Detail Records (CDRs).
- **`poseidon_constants.circom`** – Constants required for Poseidon hash computations (duplicated from the Circom library).
- **`poseidon.circom`** – The Poseidon hash circuit used for efficient ZK-friendly hashing (duplicated from the Circom library).

---

### 2. `private_ethereum_setup`
Implements a **private Ethereum test network** for deploying and testing contracts:
- **`node1/` … `node4/`** – Local Ethereum nodes participating in the network.
- **`boot.key`** – Bootstrap key for initializing the network.
- **`genesis.json`** – Genesis file defining the blockchain configuration.
- **`network_keypair`** – Keypair used for network authentication.
- **`bootstrap.sh` / `clean_state.sh`** – Scripts to set up and reset the private Ethereum environment.

---

### 3. `script`
Deployment and execution scripts for the smart contracts.

#### `deploy/`
- **`AgreementFactory.s.sol`** – Factory contract for creating new roaming agreements.
- **`CreateAgreement.s.sol`** – Script for deploying individual roaming agreements.

#### `zk/`
- **`SettleRoamingSession.s.sol`** – Contract to verify and settle roaming sessions using ZK proofs.
- **`StartRoamingSession.s.sol`** – Initializes a roaming session between HMNO and VMNO.
- **`SubmitCDRs.s.sol`** – Handles submission of Call Detail Records to the settlement contract.

---

### 4. `src`
Core Solidity contracts and supporting files.

- **`Mock/`** – Mock contracts for testing.
- **`Agreement.sol`** – Defines the roaming agreement logic between operators.
- **`AgreementFactory.sol`** – Smart contract factory for creating roaming agreements.
- **`Groth16Verifier.sol`** – Verifier contract generated for Groth16 ZK-SNARK proofs.

---

## 🚀 How to Use

1. **Setup the Ethereum network**
   ```bash
   cd private_ethereum_setup
   ./bootstrap.sh
   ```
    This will start the local Ethereum test network with four nodes.
2. **Run the Trusted setup ceremony for Groth16**
    ```bash
    ./script/zk/universal_setup.bash && ./script/zk/groth16_proof_generation.bash
    ```
3. **Run the scripts to simulate a 5G roaming settelement**.

