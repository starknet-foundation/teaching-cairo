// This section shows how to refactor the default fibonacci code that 
// comes with a new Scarb project into its own module and then how to 
// execute to create and verify a validity proof with Stwo

#[executable]
fn main() -> u32 {
    fib(16)
}

fn fib(mut n: u32) -> u32 {
    let mut a: u32 = 0;
    let mut b: u32 = 1;
    while n != 0 {
        n = n - 1;
        let temp = b;
        b = a + b;
        a = temp;
    };
    a
}

#[cfg(test)]
mod tests {
    use super::fib;

    #[test]
    fn it_works() {
        assert!(fib(16) == 987);
    }
} 