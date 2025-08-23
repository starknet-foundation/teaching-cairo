// This section shows how ownership works, how to use snapshots, 
// the desnap operator and how to create a custom types with structs

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
        let person: Person = Person {
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
        let person: Person = Person {
            height: 180,
            age: 30,
        };
        let (age, person): (u32, Person) = get_age_return_ownership(person);
        assert!(age == 30);
        assert!(person.age == 30);
    }

    fn get_age_with_snapshot(person: @Person) -> u32 {
        *person.age
    }

    #[test]
    fn test_get_age_with_snapshot() {
        let person: Person = Person {
            height: 180,
            age: 30,
        };
        let age = get_age_with_snapshot(@person);
        assert!(age == 30);
        assert!(person.age == 30);
    }
}