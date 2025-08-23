// This section builds on top of the "snapshots" module to show how
// to use references

#[cfg(test)]
mod tests {

    #[derive(Drop)]
    struct Person {
        height: u32,
        age: u32,
    }

    fn make_person_older(mut person: Person) {
        person.age += 1;
    }

    #[test]
    #[ignore]
    fn test_take_ownership() {
        let mut person: Person = Person {
            height: 180,    
            age: 30,
        };
        make_person_older(person);
        // assert!(person.age == 31); // ownership not returned
    }

    fn make_person_older_return_ownership(mut person: Person) -> Person {
        person.age += 1;
        person
    }

    #[test]
    fn test_return_ownership() {
        let mut person: Person = Person {
            height: 180,
            age: 30,
        };
        let person: Person = make_person_older_return_ownership(person);
        assert!(person.age == 31);
    }

    fn make_person_older_with_reference(ref person: Person) {
        person.age += 1;
    }

    #[test]
    fn test_make_person_older_with_reference() {
        let mut person: Person = Person {
            height: 180,
            age: 30,
        };  
        make_person_older_with_reference(ref person);
        assert!(person.age == 31);
    }
}