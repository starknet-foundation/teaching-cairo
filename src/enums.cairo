// This section shows how to use simple enums and enums with nested values.

#[cfg(test)]
mod tests {

    mod simple_enum {

        #[derive(Drop, PartialEq)]
        enum Error {
            DivideByZero,
            DividendSmallerThanDivisor,
            InexactDivision,
        }

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if divisor == 0 {
                return Err(Error::DivideByZero);
            }
            if divisor > dividend {
                return Err(Error::DividendSmallerThanDivisor);
            }
            if dividend % divisor != 0 {
                return Err(Error::InexactDivision);
            }
            Ok(dividend / divisor)
        }

        #[test]
        fn test_simple_enum() {
            let result: Result<u32, Error> = divide(10, 2);
            assert!(result == Ok(5));

            let result: Result<u32, Error> = divide(10, 0);
            assert!(result == Err(Error::DivideByZero));
        }
    }

    mod enums_with_values {

        #[derive(Drop, PartialEq)]
        enum Error {
            DivideByZero,
            DividendSmallerThanDivisor: Division,
            InexactDivision: Remainder,
        }

        #[derive(Drop, PartialEq)]
        struct Division {
            dividend: u32,
            divisor: u32,
        }

        type Remainder = u32;

        fn divide(dividend: u32, divisor: u32) -> Result<u32, Error> {
            if divisor == 0 {
                return Err(Error::DivideByZero);
            }
            if divisor > dividend {
                let division: Division = Division {
                    dividend,
                    divisor,
                };
                return Err(Error::DividendSmallerThanDivisor(division));
            }
            if dividend % divisor != 0 {
                let remainder = dividend % divisor;
                return Err(Error::InexactDivision(remainder));
            }
            Ok(dividend / divisor)
        }

        #[test]
        fn test_enums_with_values() {
            let result: Result<u32, Error> = divide(10, 2);
            assert!(result == Ok(5));

            let result: Result<u32, Error> = divide(10, 0);
            assert!(result == Err(Error::DivideByZero));

            let result: Result<u32, Error> = divide(10, 3);
            assert!(result == Err(Error::InexactDivision(1)));

            let result: Result<u32, Error> = divide(4, 10);
            assert!(result == Err(Error::DividendSmallerThanDivisor(Division { dividend: 4, divisor: 10 })));
        }
    }
}