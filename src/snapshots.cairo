// This section shows how ownership works and how to use snapshots 
// and the desnap operator

#[cfg(test)]
mod tests {

    #[derive(Drop)]
    struct Person {
        height: u32,
        age: u32,
    }

    fn get_age(person: Person) -> u32 {
        person.age
    }

    #[test]
    fn test_get_age() {
        let person = Person {
            height: 180,
            age: 30,
        };
        let age = get_age(person);
        assert!(age == 30);
        // assert!(person.age == 30); // ownership not returned
    }

    fn get_age_return_ownership(person: Person) -> (u32, Person) {
        (person.age, person)
    }

    #[test]
    fn test_get_age_return_ownership() {
        let person = Person {
            height: 180,
            age: 30,
        };
        let (age, person) = get_age_return_ownership(person);
        assert!(age == 30);
        assert!(person.age == 30);
    }

    fn get_age_with_snapshot(person: @Person) -> u32 {
        *person.age
    }

    #[test]
    fn test_get_age_with_snapshot() {
        let person = Person {
            height: 180,
            age: 30,
        };
        let age = get_age_with_snapshot(@person);
        assert!(age == 30);
        assert!(person.age == 30);
    }
}