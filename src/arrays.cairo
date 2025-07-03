#[cfg(test)]
mod tests {

    #[test]
    fn test_new_array() {
        let mut arr: Array<u8> = Array::new();
        arr.push(1);
        arr.push(2);
        arr.push(3);

        assert!(arr.len() == 3);
    }

    #[test]
    fn test_array_macro() {
        let arr: Array<u8> = array![1, 2, 3];
        arr.push(4);
        assert!(arr.len() == 3);
    }
}