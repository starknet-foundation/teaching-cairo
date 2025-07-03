// This section shows how to define constraints on traits

#[derive(Drop)]
struct Human {
    is_alive: bool,
    health: u32,
    strength: u32,
}

#[derive(Drop)]
struct Orc {
    is_alive: bool,
    health: u32,
    strength: u32,
}

trait Action<T> {
    fn get_is_alive(ref self: T) -> bool {
        self.is_alive
    }
    fn get_health(ref self: T) -> u32 {
        self.health
    }
    fn get_strength(ref self: T) -> u32 {
        self.strength
    }
    fn hurt(ref self: T) {
        if self.health > 10 {
            self.health -= 10;
        } else {
            self.health = 0;
            self.is_alive = false;
        }
    };
    fn train(ref self: T);
    fn heal(ref self: T);
    fn new() -> T;
}

impl HumanImpl of Action<Human> {
    fn new() -> Human {
        Human {
            is_alive: true,
            health: 100,
            strength: 20,
        }
    }

    fn train(ref self: Human) {
        self.strength += 5;
    }

    fn heal(ref self: Human) {
        self.health += 10;
    }
}

impl OrcImpl of Action<Orc> {
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

    fn heal(ref self: Orc) {
        self.health += 5;
    }
}

#[cfg(test)]
mod tests {

    mod no_constraints {

        use super::super::*;

        fn human_vs_human_fight(ref human_1: Human, ref human_2: Human) -> Result<(), ByteArray> {
            if !human_1.get_is_alive() || !human_2.get_is_alive() {
                return Result::Err("One of the opponents is already dead");
            }

            if human_1.get_strength() == human_2.get_strength() {
                human_1.hurt();
                human_2.hurt();
            }   else if human_1.get_strength() > human_2.get_strength() {
                human_2.hurt();
            } else {
                human_1.hurt();
            }
            
            return Result::Ok(());
        }
        
        fn orc_vs_orc_fight(ref orc_1: Orc, ref orc_2: Orc) {
            // TODO: Implement
        }
        
        fn human_vs_orc_fight(ref human: Human, ref orc: Orc) {
            // TODO: Implement
        }
        
        fn orc_vs_human_fight(ref orc: Orc, ref human: Human) {
            // TODO: Implement
        }

        #[test]
        fn test_human_vs_human_fight() {

            let mut edric = HumanImpl::new();
            let mut alaric = HumanImpl::new();

            match human_vs_human_fight(ref edric, ref alaric) {
                Result::Ok(()) => {
                    assert!(edric.get_is_alive());
                    assert!(alaric.get_is_alive());
                    assert!(edric.get_health() == 90);
                    assert!(alaric.get_health() == 90);
                },
                Result::Err(_e) => assert!(false),
            }
        }
    }

    mod constraints {

        // Sometimes the compiler complains if I don't define more constraints like
        // fn fight<T, +Action<T>, +Drop<T>, +Destruct<T>>(ref op1: T, ref op2: T) { ... }

        fn fight<T, +Action<T>>(ref opponent_1: T, ref opponent_2: T) {
            if opponent_1.get_is_alive() == false || opponent_2.get_is_alive() == false {
                panic!("One of the opponents is already dead");
            }

            if opponent_1.get_strength() == opponent_2.get_strength() {
                opponent_1.hurt();
                opponent_2.hurt();
            } else if opponent_1.get_strength() > opponent_2.get_strength() {
                opponent_2.hurt();
            } else {
                opponent_1.hurt();
            }
        }

        #[test]
        fn test_fight() {
            let mut edric = HumanImpl::new();
            let mut gorbag = OrcImpl::new();

            fight(edric, gorbag);

            assert!(edric.get_is_alive() == true);
            assert!(gorbag.get_is_alive() == true);
            assert!(edric.get_health() == 90);
            assert!(gorbag.get_health() == 100);
        }
    }
}