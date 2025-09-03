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
}