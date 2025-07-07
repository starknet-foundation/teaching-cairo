// This section covers the anatomy of a function, how to return a value
// with and without using the "return" keyword, how to pass arguments
// and how to use closures

fn foo() -> u32 {
    5
}

fn bar() -> u32 {
    foo()
}

fn baz() -> u32 {
    return 10;
}

fn double(x: u32) -> u32 {
    x * 2
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn test_foo() {
        assert!(foo() == 5);
    }

    #[test]
    fn test_bar() {
        assert!(bar() == 5);
    }

    #[test]
    fn test_baz() {
        assert!(baz() == 10);
    }

    #[test]
    fn test_double() {
        assert!(double(5) == 10);
    }

    #[test]
    fn test_closures() {    
        let add = |a: u32| {
            |b| a + b
        };

        let add_five = add(5);
        assert!(add_five(10) == 15);

        let add_ten = add(10);
        assert!(add_ten(10) == 20);
    }
}