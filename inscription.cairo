#[starknet::interface]
trait IInscription<TContractState> {
    fn inscription(ref self: TContractState, ins: Array<felt252>, to: starknet::ContractAddress);
}


#[starknet::contract]
mod Inscription {

    #[storage]
    struct Storage {}

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Ins: Ins,
    }

    #[derive(Drop, starknet::Event)]
    struct Ins {
        ins: Array<felt252>,
        from: starknet::ContractAddress,
        to: starknet::ContractAddress
    }
    

    #[external(v0)]
    impl Inscription of super::IInscription<ContractState> {
        fn inscription(ref self: ContractState, ins: Array<felt252>, to: starknet::ContractAddress){
           self.emit(Ins { ins: ins, from: starknet::get_caller_address(), to: to });
        }
    }
 
}
