import React, { useState, useEffect, useCallback } from 'react';
import { fundingRoundabi } from '../abis.js'

const Web3Info = (props: any) => {
    const { web3Context } = props;
    const { networkId, networkName, accounts, providerName, lib } = web3Context;

    const FundingRound = new lib.eth.Contract(fundingRoundabi, "0x15193182069D52a04a24A6113C891b7d4eA1B838")

    const [balance, setBalance] = useState(0);
  
    const getBalance = useCallback(async () => {
      let balance =
        accounts && accounts.length > 0 ? lib.utils.fromWei(await lib.eth.getBalance(accounts[0]), 'ether') : 'Unknown';
      setBalance(balance);
    }, [accounts, lib.eth, lib.utils]);
  
    useEffect(() => {
        console.log(accounts)
      getBalance();
    }, [accounts, getBalance, networkId]);
  
    const requestAuth = async (web3Context: { requestAuth: () => any; }) => {
      try {
        await web3Context.requestAuth();
      } catch (e) {
        console.error(e);
      }
    };
  
    const requestAccess = useCallback(() => requestAuth(web3Context), []);

    const deposit = useCallback(async () => {
        let amount = await FundingRound.methods.depositAmount("5000000000000000000").send({ from: accounts[0], value: "5000000000000000000"})
    }, [FundingRound])

    const withdraw = useCallback(async () => {
        let amount = await FundingRound.methods.withdraw().send({ from: accounts[0]})
    }, [FundingRound])

  return (
    <div>
      <h3> {props.title} </h3>
      <div>Network: {networkId ? `${networkId} – ${networkName}` : 'No connection'}</div>
      <div>Your address: {accounts && accounts.length ? accounts[0] : 'Unknown'}</div>
      <div>Your ETH balance: {balance}</div>
      <div>Provider: {providerName}</div>
      <button onClick={deposit}>Deposit</button>
      {accounts && accounts.length ? (
        <div>Accounts & Signing Status: Access Granted</div>
      ) : !!networkId && providerName !== 'infura' ? (
        <div>
          <button onClick={requestAccess}>Request Access</button>
        </div>
      ) : (
        <div>
            
        </div>
      )}
      <button onClick={withdraw}>Withdraw</button>
    </div>
  );
}

export default Web3Info