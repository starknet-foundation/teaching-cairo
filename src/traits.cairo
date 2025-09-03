#[derive(Drop)]
struct Human {
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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_create_characters() {
        let mut human: Human = HumanActionImpl::new();
        human.train();
        human.study();
        assert!(human.strength == 25);
        assert!(human.intelligence == 25);
    }
}