// This section covers the anatomy of a function and how to return a value
// with and without using the "return" keyword

fn foo() -> u32 {
    5
}

fn bar() -> u32 {
    foo()
}

fn baz() -> u32 {
    return 10;
}    

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_foo() {
        assert(foo() == 5, 'foo should return 5');
    }

    #[test]
    fn test_bar() {
        assert(bar() == 5, 'bar should return 5');
    }

    #[test]
    fn test_baz() {
        assert(baz() == 10, 'bar should return 5');
    }
}