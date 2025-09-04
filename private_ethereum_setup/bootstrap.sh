#!/bin/bash

# # Initialize the nodes
geth init --datadir node1 genesis.json
geth init --datadir node2 genesis.json
geth init --datadir node3 genesis.json
geth init --datadir node4 genesis.json

# # Start bootnode in a new terminal window
gnome-terminal --title="Bootnode" -- bash -c 'bootnode -nodekey boot.key -verbosity 9 -addr :30305; exec bash'

# echo "Bootnode enode URL: $BOOTNODE"
BOOTNODE="enode://a55c0a846e4052b67778bc1920aeb4e87fb64113b27acb417fb46840880efd2ec5f64833ce87d18172e272be69307b5a53002e755a2df82c206eee7c12ec88ea@127.0.0.1:0?discport=30305"

# Start Geth nodes in separate terminal windows
gnome-terminal --title="Node 1" -- bash -c "geth --datadir node1 --port 30306 --bootnodes '$BOOTNODE' --networkid 12345 --allow-insecure-unlock --unlock 0x73a7245EFcAeb3Addf55a55afFc75A956b69854c --password node1/password.txt --ws --ws.addr="0.0.0.0" --ws.api="personal,eth,net,web3,txpool,miner" --ws.port="9000" --miner.etherbase 0x73a7245EFcAeb3Addf55a55afFc75A956b69854c --mine --syncmode full --miner.gaslimit 1000000000 --rpc.gascap 1000000000; exec bash"
gnome-terminal --title="Node 2" -- bash -c "geth --datadir node2 --port 30307 --bootnodes '$BOOTNODE' --networkid 12345 --allow-insecure-unlock --unlock 0x0Ea0Eb8061cBdaF6684852A583234d882dA63d25 --password node2/password.txt  --ws --ws.addr="0.0.0.0" --ws.api="personal,eth,net,web3,txpool" --ws.port="9001" --syncmode full --rpc.gascap 1000000000; exec bash"
gnome-terminal --title="Node 3" -- bash -c "geth --datadir node3 --port 30308 --bootnodes '$BOOTNODE' --networkid 12345 --allow-insecure-unlock --unlock 0x58D85998a7c6ed077f9FB913700f5f5Da539a786 --password node3/password.txt  --ws --ws.addr="0.0.0.0" --ws.api="personal,eth,net,web3,txpool" --ws.port="9002" --syncmode full --rpc.gascap 1000000000; exec bash"
gnome-terminal --title="Node 4" -- bash -c "geth --datadir node4 --port 30309 --bootnodes '$BOOTNODE' --networkid 12345 --allow-insecure-unlock --unlock 0x46CC7efbC0fb7F80c037B33c7fe416692Ea1075B --password node4/password.txt  --ws --ws.addr="0.0.0.0" --ws.api="personal,eth,net,web3,txpool" --ws.port="9003" --syncmode full --rpc.gascap 1000000000; exec bash"

echo "All nodes started."