#!/bin/bash
ls
cd ..
export IMAGE_TAG=1.4
export PATH=$PATH:~/hfl-1.4.4/bin

# Set the FABRIC_CFG_PATH
export FABRIC_CFG_PATH=/home/ubuntu/Metasurance-backend

echo "Generating cryto material for peers..."
[ -d $FABRIC_CFG_PATH/crypto-config ] || mkdir -p $FABRIC_CFG_PATH/crypto-config
cryptogen generate --config=$FABRIC_CFG_PATH/crypto-config.yaml --output=$FABRIC_CFG_PATH/crypto-config

echo "Generating channel artifacts and genesis block..."
[ -d $FABRIC_CFG_PATH/channel-artifacts ] || mkdir -p $FABRIC_CFG_PATH/channel-artifacts
configtxgen -profile MetaOrdererGenesis -outputBlock $FABRIC_CFG_PATH/channel-artifacts/genesis.block -channelID mychannel
configtxgen -profile MetaChannel -outputCreateChannelTx $FABRIC_CFG_PATH/channel-artifacts/channel.tx -channelID mychannel

