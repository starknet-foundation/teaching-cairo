// This section shows how to do type casting between different integer types
// both using shorthand methods and the Option enum with "match"

#[cfg(test)]
mod tests {

    #[test]
    fn test_casting_to_bigger_type() {
        let a: u8 = 10;
        assert!(a.into() == 10_u16);
    }

    #[test]
    fn test_casting_to_smaller_type_that_fits() {
        let a: u16 = 10;
        assert!(a.try_into().unwrap() == 10_u8);
    }

    #[test]
    fn test_casting_to_smaller_type_that_overflows_1() {
        let a: u16 = 1000;
        let b: Option<u8> = a.try_into();
        assert!(b.is_none());
    }

    #[test]
    fn test_casting_to_smaller_type_that_overflows_2() {
        let a: u16 = 1000;
        let b: Option<u8> = a.try_into();
        let c = b.unwrap_or(255);
        assert!(c == 255_u8);
    }

    #[test]
    fn test_casting_to_smaller_type_that_overflows_3() {
        let a: u16 = 1000;
        let b: u8 = a.try_into().unwrap_or(255);
        assert!(b == 255_u8);
    }
}