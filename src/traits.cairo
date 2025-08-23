// This section shows how to define traits, implementations, generics and the factory pattern

#[cfg(test)]
mod tests {

    mod traits {

        #[derive(Drop)]
        struct Human {
            health: u32,
            strength: u32,
            intelligence: u32,
        }

        #[derive(Drop)]
        struct Orc {
            health: u32,
            strength: u32,
            intelligence: u32,
        }

        trait HumanAction {
            fn new() -> Human;
            fn train(ref self: Human);
            fn study(ref self: Human);
        }

        impl HumanActionImpl of HumanAction {
            fn new() -> Human {
                Human {
                    health: 100,
                    strength: 20,
                    intelligence: 20,
                }
            }

            fn train(ref self: Human) {
                self.strength += 5;
            }

            fn study(ref self: Human) {
                self.intelligence += 5;
            }
        }

        trait OrcAction {
            fn new() -> Orc;
            fn train(ref self: Orc);
            fn study(ref self: Orc);
        }

        impl OrcActionImpl of OrcAction {
            fn new() -> Orc {
                Orc {
                    health: 100,
                    strength: 50,
                    intelligence: 5,
                }
            }

            fn train(ref self: Orc) {
                self.strength += 10;
            }

            fn study(ref self: Orc) {
                self.intelligence += 1;
            }   
        }

        #[test]
        fn test_create_characters() {
            let mut human: Human = HumanActionImpl::new();
            let mut orc: Orc = OrcActionImpl::new();

            human.study();
            orc.study();

            assert!(human.intelligence == 25);
            assert!(orc.intelligence == 6);
        }
    }

    mod generics {

        #[derive(Drop)]
        struct Human {
            strength: u32,
            intelligence: u32,
        }

        #[derive(Drop)]
        struct Orc {
            strength: u32,
            intelligence: u32,
        }

        trait Action<T> {
            fn new() -> T;
            fn train(ref self: T);
            fn study(ref self: T);
        }

        impl HumanImpl of Action<Human> {
            fn new() -> Human {
                Human {
                    strength: 20,
                    intelligence: 20,
                }
            }

            fn train(ref self: Human) {
                self.strength += 5;
            }

            fn study(ref self: Human) {
                self.intelligence += 5;
            }
        }

        impl OrcImpl of Action<Orc> {
            fn new() -> Orc {
                Orc {
                    strength: 50,
                    intelligence: 5,
                }
            }

            fn train(ref self: Orc) {
                self.strength += 10;
            }

            fn study(ref self: Orc) {
                self.intelligence += 1;
            }
        }

        #[test]
        fn test_create_characters() {
            let mut human: Human = HumanImpl::new();
            let mut orc: Orc = OrcImpl::new();

            human.study();
            orc.study();

            assert!(human.intelligence == 25);
            assert!(orc.intelligence == 6);
        }
    }
}