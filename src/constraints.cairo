// This section shows how to define constraints in functions

#[derive(Drop)]
struct Human {
    health: u32,
    strength: u32,
}

#[derive(Drop)]
struct Orc {
    health: u32,
    strength: u32,
}

trait Action<T> {
    fn new() -> T;
    fn get_health(self: @T) -> u32;
    fn get_strength(self: @T) -> u32;
    fn is_alive(self: @T) -> bool;
    fn train(ref self: T);
    fn heal(ref self: T);
    fn hurt(ref self: T);
}

impl HumanImpl of Action<Human> {
    fn new() -> Human {
        Human {
            health: 100,
            strength: 20,
        }
    }

    fn get_health(self: @Human) -> u32 {
        *self.health
    }

    fn get_strength(self: @Human) -> u32 {
        *self.strength
    }

    fn is_alive(self: @Human) -> bool {
        *self.health > 0
    }

    fn train(ref self: Human) {
        if self.is_alive() {
            self.strength += 5;
        }
    }

    fn heal(ref self: Human) {
        if self.is_alive() {
            self.health += 10;
        }
    }    

    fn hurt(ref self: Human) {
        if self.get_health() > 10 {
            self.health -= 10;
        } else {
            self.health = 0;
        }
    }
}

impl OrcImpl of Action<Orc> {
    fn new() -> Orc {
        Orc {
            health: 100,
            strength: 50,
        }
    }

    fn get_health(self: @Orc) -> u32 {
        *self.health
    }

    fn get_strength(self: @Orc) -> u32 {
        *self.strength
    }

    fn is_alive(self: @Orc) -> bool {
        *self.health > 0
    }

    fn train(ref self: Orc) {
        if self.is_alive() {    
            self.strength += 10;
        }
    }

    fn heal(ref self: Orc) {
        if self.is_alive() {
            self.health += 5;
        }
    }

    fn hurt(ref self: Orc) {
        if self.get_health() > 10 {
            self.health -= 10;
        } else {
            self.health = 0;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn human_vs_human_fight(ref human_1: Human, ref human_2: Human) -> Result<(), ByteArray> {
        if !human_1.is_alive() || !human_2.is_alive() {
            return Result::Err("One of the opponents is already dead");
        }

        if human_1.get_strength() == human_2.get_strength() {
            human_1.hurt();
            human_2.hurt();
        } else if human_1.get_strength() > human_2.get_strength() {
            human_2.hurt();
        } else {
            human_1.hurt();
        }
        
        return Result::Ok(());
    }

    // TODO: Add tests for orc vs orc, human vs orc, and orc vs human fights
    // fn orc_vs_orc_fight(ref orc_1: Orc, ref orc_2: Orc) -> Result<(), ByteArray> { ... }
    // fn human_vs_orc_fight(ref human: Human, ref orc: Orc) -> Result<(), ByteArray> { ... }
    // fn orc_vs_human_fight(ref orc: Orc, ref human: Human) -> Result<(), ByteArray> { ... }

    #[test]
    fn test_human_vs_human_fight() {

        let mut edric: Human = HumanImpl::new();
        let mut alaric: Human = HumanImpl::new();

        match human_vs_human_fight(ref edric, ref alaric) {
            Result::Ok(()) => {
                assert!(edric.get_health() == 90);
                assert!(alaric.get_health() == 90);
                assert!(edric.is_alive());
                assert!(alaric.is_alive());
            },
            Result::Err(_e) => assert!(false),
        }
    }
    
    fn fight<T1, T2, +Action<T1>, +Action<T2>, +Drop<T1>, +Drop<T2>>(ref opponent_1: T1, ref opponent_2: T2) -> Result<(), ByteArray>  {
        if !opponent_1.is_alive() || !opponent_2.is_alive() {
            return Result::Err("One of the opponents is already dead");
        }

        if opponent_1.get_strength() == opponent_2.get_strength() {
            opponent_1.hurt();
            opponent_1.hurt();
        } else if opponent_1.get_strength() > opponent_2.get_strength() {
            opponent_2.hurt();
        } else {
            opponent_1.hurt();
        }
        
        return Result::Ok(());
    }

    #[test]
    fn test_fight() {
        let mut edric = HumanImpl::new();
        let mut gorbag = OrcImpl::new();

        match fight(ref edric, ref gorbag) {
            Result::Ok(()) => {
                assert!(edric.get_health() == 90);
                assert!(gorbag.get_health() == 100);
                assert!(edric.is_alive());
                assert!(gorbag.is_alive());
            },
            Result::Err(_e) => assert!(false),
        }
    }   
}