#!/usr/bin/env bash

if [ $(which geth) == "geth not found" ];then
    echo "geth not found, please install geth or set geth to path"
    exit 2
fi

root=`pwd`

osEnv=$1
if [ ${osEnv} ];then
    if [ ${osEnv} == "1" ];then
        ipc="${HOME}/.ethereum/geth.ipc"
    elif [ ${osEnv} == "2" ];then
        ipc="${HOME}/Library/Ethereum/geth.ipc"
    else
        echo "linux 1 ; oxs = 2"
        exit 1
    fi
else
    echo "plz tall me your os env, linux = 1 or oxs = 2"
    exit 1
fi

etherbase=$(cat .etherbase)
pwd=$(cat .pwd)

if [ ${etherbase} ];then

    if [ $2 == "test" ];then
        geth --identity "private_net" \
         --rpc --rpcport "8545" \
         --rpccorsdomain "*" \
         --datadir "${root}/data" \
         --port "30303" \
         --ipcpath "${ipc}" \
         --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
         --networkid 82403 \
         --nat "any"  \
         --etherbase "${etherbase}" \
         --password <(echo ${pwd}) \
         --unlock "${etherbase}" \
         --mine \
         --minerthreads=1
    else
        geth --identity "private_net" \
         --rpc --rpcport "8545" \
         --rpccorsdomain "*" \
         --datadir "${root}/data" \
         --port "30303" \
         --ipcpath "${ipc}" \
         --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
         --networkid 82403 \
         --nat "any"  \
         --etherbase "${etherbase}" \
         --password <(echo ${pwd}) \
         --unlock "${etherbase}" \
         console
    fi

else
    geth --identity "private_net" \
     --rpc --rpcport "8545" \
     --rpccorsdomain "*" \
     --datadir "${root}/data" \
     --port "30303" \
     --ipcpath "${ipc}" \
     --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" \
     --networkid 82403 \
     --nat "any"  \
     console
fi
