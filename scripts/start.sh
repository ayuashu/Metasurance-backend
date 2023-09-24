#!/bin/bash
IMAGE_TAG="latest"
DOCKER_COMPOSE_FILE="/home/ubuntu/Metasurance-backend/docker-compose-cli.yaml"

# Export the IMAGE_TAG variable to make it available to docker-compose
export IMAGE_TAG

echo "Creating containers... "
docker-compose -f "$DOCKER_COMPOSE_FILE" up -d

echo 
echo "Containers started" 
echo 
docker ps

#    echo
#    #Creating channel and join org1
#    docker exec -it cli ./scripts/channel/createChannel.sh
#    #Creating channel and join org2
#    docker exec -e "CORE_PEER_LOCALMSPID=Org2MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp" -e "CORE_PEER_ADDRESS=peer0.org2.example.com:7051" -it cli ./scripts/channel/joinpeer.sh

# TODO This approach is hacky; instead, identify where hyperledger/fabric-ccenv is pulled and update the tag to 1.4.3
# docker pull hyperledger/fabric-ccenv:1.4.3
# docker tag hyperledger/fabric-ccenv:1.4.3 hyperledger/fabric-ccenv:latest

#docker-compose -f ./docker-compose-cli.yaml up -d
#echo 
#echo "Containers started" 
#echo 
#docker ps

docker exec -it cli ./scripts/channel/createChannel.sh

echo "Joining Verifier to channel..."
docker exec -it cli ./scripts/channel/join-peer.sh peer0 verifier VerifierMSP 10051 1.0
echo "Joining User to channel..."
docker exec -it cli ./scripts/channel/join-peer.sh peer0 user UserMSP 9051 1.0
echo "Joining Asset to channel..." 
docker exec -it cli ./scripts/channel/join-peer.sh peer0 asset AssetMSP 11051 1.0