// This sections shows an alternative to snapshots for complex types
// using the "Copy" trait

#[cfg(test)]
mod tests {

    fn add_one(x: u32) -> u32 {
        x + 1
    }

    #[test]
    fn test_add_one() {
        let x = 1;
        let y = add_one(x); // x is copied
        assert!(y == 2);
        assert!(x == 1); // ownership is never moved
    }

    #[derive(Drop, Copy)]
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
        let age = get_age(person); // person is copied
        assert!(age == 30);
        assert!(person.age == 30); // ownership is never moved
    }

    fn increase_age(mut person: Person) {
        person.age += 1;
    }

    #[test]
    fn test_increase_age() {
        let person: Person = Person {
            height: 180,
            age: 30,
        };
        increase_age(person); // person is copied
        assert!(person.age == 30); // only copy was modified, not original
    }
}