// This section shows the different integer types and how to declare them
// using an explict type or a suffix literal. The _ prefix is just to stop
// the compiler from complaining about "unused variables".
// The section also covers how to add project dependencies like Alexandria

fn unsigned_integers() {
    let _a: u8 = 255;
    let _b: u16 = 65535;
    let _c: u32 = 4294967295;
    let _d: u64 = 18446744073709551615;
    let _e: u128 = 340282366920938463463374607431768211455;
    let _f: u256 = 115792089237316195423570985008687907853269984665640564039457584007913129639935;

    let _g = 255_u8;
    let _h = 65535_u16;
    let _i = 4294967295_u32;
    let _j = 18446744073709551615_u64;
    let _k = 340282366920938463463374607431768211455_u128;
    let _l = 115792089237316195423570985008687907853269984665640564039457584007913129639935_u256;

    // usize is the same as u32
    let _m: usize = 4294967295;
    let _n = 4294967295_usize;
}

fn signed_integers() {
    let _a: i8 = -128;
    let _b: i16 = -32768;
    let _c: i32 = -2147483648;
    let _d: i64 = -9223372036854775808;
    let _e: i128 = -170141183460469231731687303715884105728;
    // let _f: i256 = -57896044618658097711785492504343953926634992332820282019728792003956564819968; // i256 doesn't exist

    let _g = 127_i8;
    let _h = 32767_i16;
    let _i = 2147483647_i32;
    let _j = 9223372036854775807_i64;
    let _k = 170141183460469231731687303715884105727_i128;
    // let l = 57896044618658097711785492504343953926634992332820282019728792003956564819967_i256; // i256 doesn't exist

    // isize doesn't exist
    // let _m: isize = -2147483648;
    // let _n = -2147483648_isize;
}

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
    fn test_mixing_types_success() {
        let a: u8 = 3;
        let b: i8 = 5;
        assert!(a + b.try_into().unwrap() == 8_u8);
    }

    #[test]
    #[should_panic]
    fn test_mixing_types_fail() {
        let a: u8 = 3;
        let b: i8 = -5;
        assert!(a + b.try_into().unwrap() == 8_u8);
    }

    #[test]
    fn test_advanced_math() {
        let a: u32 = 4;
        assert!(fast_power(a, 2) == 16);
        assert!(fast_sqrt(a.into(), 1) == 2);
    }
}