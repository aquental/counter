#[starknet::interface]
trait ICounterContract<TContractState> {
    fn get_counter(self: @TContractState) -> u32;
    fn inc_counter(ref self: TContractState);
}

#[starknet::contract]
mod CounterContract {
    use counter::ICounterContract;
    #[storage]
    struct Storage {
        contador: u32,
    }
    #[constructor]
    fn constructor(ref self: ContractState, contador_inicial: u32) {
        self.contador.write(contador_inicial);
    }
    #[abi(embed_v0)]
    impl CounterContract of super::ICounterContract<ContractState> {
        fn get_counter(self: @ContractState) -> u32 {
            self.contador.read()
        }
        fn inc_counter(ref self: ContractState) {
            self.contador.write(self.contador.read() + 1);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::CounterContract;

    #[test]
    fn it_works() {
        assert(1 == 1, 'it works!');
    }
}
