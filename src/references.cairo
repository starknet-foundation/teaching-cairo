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
        let mut person = Person {
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
        let mut person = Person {
            height: 180,
            age: 30,
        };
        let person = make_person_older_return_ownership(person);
        assert!(person.age == 31);
    }

    fn make_person_older_with_reference(ref person: Person) {
        person.age += 1;
    }

    #[test]
    fn test_make_person_older_with_reference() {
        let mut person = Person {
            height: 180,
            age: 30,
        };  
        make_person_older_with_reference(ref person);
        assert!(person.age == 31);
    }

    // #[derive(Drop, Copy)]
    // struct Animal {
    //     weight: u32,
    //     age: u32,
    // }

    // fn return_ownership(x: u32) -> (u32, u32) {
    //     let y = x + 1;
    //     (y, x)
    // }

    // #[test]
    // #[should_panic]
    // fn test_return_ownership() {
    //     let mut a = 1;
    //     return_ownership(a);
    //     assert!(a == 1);
    // }

    // fn borrow_ownership(x: &mut u32) {
    //     *x = 2;
    // }

    // #[test]
    // fn test_borrow_ownership() {
    //     let mut a = 1;
    //     borrow_ownership(&mut a);
    //     assert!(a == 2);
    // }

    // #[test]
    // fn test_snapshot_ownership() {
    //     let mut a = 1;
    //     let snap_before = @a; // snapshot before mutation
    //     a = 2;
    //     let snap_after = @a; // snapshot after mutation
    //     assert!(*snap_before == 1);
    //     assert!(*snap_after == 2);
    // }
}