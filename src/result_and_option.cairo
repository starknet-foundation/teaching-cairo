// This section builds on top of "casting" where the Option enum was introduced
// to compare the Option and Result enums and when to use each one

// Option: value or nothing.
fn find_even(x: u32) -> Option<u32> {
    if x % 2 == 0 { 
        Option::Some(x) 
    } else { 
        Option::None 
    }
}

// Result: value or error (with info about the error).
fn divide(a: u32, b: u32) -> Result<u32, ByteArray> {
    if b == 0 { 
        Result::Err("Can't divide by zero")
    } else { 
        Result::Ok(a / b) 
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_divide_by_zero_should_fail_method() {
        let result = divide(10, 0);
        assert!(result.is_err());
    }

    #[test]
    fn test_divide_by_zero_should_fail_match() {
        let result = divide(10, 0);
        
        match result {
            Result::Err(_) => assert!(true),
            Result::Ok(_) => assert!(false),
        }
    }

    #[test]
    fn test_divide_by_zero_should_fail_match_error() {
        let result = divide(10, 0);
        
        match result {
            Result::Err(error) => assert!(error == "Can't divide by zero"),
            Result::Ok(_) => assert!(false),
        }
    }

    #[test]
    fn test_divide_by_zero_should_fail_enum_shorthand() {
        let result = divide(10, 0);
        
        match result {
            Err(_) => assert!(true),
            Ok(_) => assert!(false),
        }
    }

    #[test]
    fn test_divide_by_zero_should_error_match_default() {
        let result = divide(10, 0);
        
        match result {
            Err(_) => assert!(true),
            _ => assert!(false),
        }
    }
}