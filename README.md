How to Make Inscription On Starknet

We know that BTC's inscription carries data through utxo, and EVM's inscription carries data through calldata in ETH transfer, and then uses an offline indexer to identify user operations and balance information. But these don't seem to work in Starknet. Because Starknet is the layer 2 of ETH, and ETH is a contract on Starknet, transfers require operating the contract and cannot carry data. As a result, many people use smart contracts to store json data and try to use hot spots to charge fees. The transaction fee is high and you have to pay additional fees, which loses the meaning of the inscription. 
If we want to implement the inscription protocol on Starknet, how should we do it? First of all, only smart contracts can be used because there are no EOA accounts on Starknet; Secondly, the smart contract must be extremely simple and cannot perform too many calculations or storage, so as to minimize on-chain operation fees and put complex calculations and storage off-chain.
Therefore, we designed the following contract model:

#[derive(Drop, starknet::Event)] 
    struct Ins { 
        ins: Array<felt252>, 
        from: starknet::ContractAddress, 
        to: starknet::ContractAddress } 
    fn inscription(ref self: ContractState, ins: Array<felt252>, to: starknet::ContractAddress){
         self.emit(Ins { ins: ins, from: starknet::get_caller_address(), to: to });
    }

Yes, it has only one event (the cost of throwing an event is extremely low, which is convenient for large-scale adoption), which is used to throw out the user's inscription information, operation address, and to address for offline indexers to retrieve and calculate. 

Contract on starknet mainnet: 0x0600386e4cd85d7bb925892b61b14ff019d3dd8e31432f4b97c8ee2462e0375d

About the inscription protocol, please refer to the SNSC-20 description(https://snsc-20.gitbook.io/snsc-20-standard/).


