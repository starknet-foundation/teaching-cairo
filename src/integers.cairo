#[cfg(test)]
mod tests {
    use alexandria_math::fast_power::fast_power;
    use alexandria_math::fast_root::fast_sqrt;

    #[test]
    fn test_basic_uint_math() {
        let a: u8 = 3;
        let b: u8 = 5;

        assert!(a + b == 8);
        assert!(b - a == 2);
        assert!(a * b == 15);
        assert!(b / a == 1);
        assert!(b % a == 2);
    }

    #[test]
    #[should_panic]
    fn test_uint_overflow_protection() {
        let a: u8 = 255;
        let b: u8 = 1;
        a + b;
    }

    #[test]
    #[should_panic]
    fn test_uint_underflow_protection() {
        let a: u8 = 0;
        let b: u8 = 1;
        a - b;
    }

    #[test]
    fn test_basic_int_math() {
        let a: i8 = 3;
        let b: i8 = 5;

        assert!(a + b == 8);
        assert!(a - b == -2);
        assert!(a * b == 15);
        assert!(b / a == 1);
        assert!(b % a == 2);
    }

    #[test]
    #[should_panic]
    fn test_int_overflow_protection() {
        let a: i8 = 127;
        let b: i8 = 1;
        a + b;
    }

    #[test]
    #[should_panic]
    fn test_int_underflow_protection() {
        let a: i8 = -128;
        let b: i8 = 1;
        a - b;
    }

    #[test]
    fn test_advanced_math() {
        let a: u32 = 4;
        assert!(fast_power(a, 2) == 16);
        assert!(fast_sqrt(a.into(), 1) == 2);
    }
}