// This section shows how mutability, shadowing and constants work

#[cfg(test)]
mod tests {

    // #[test]
    // fn test_immutability() {
    //     let a: u32 = 1;
    //     a = 2; // cannot mutate
    // }

    #[test]
    fn test_shadowing() {
        let _a: u32 = 1;
        let _a: u8 = 2;
        assert!(_a == 2_u8);
    }

    #[test]
    fn test_mutability() {
        let mut a: u32 = 1;
        a = 2; // it must be of the same type
        assert!(a == 2_u32);
    }

    #[test]
    fn test_constant() {
        const A: u32 = 1; // mut keyword is not allowed
        assert!(A == 1_u32);
    }
}