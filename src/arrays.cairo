// This section shows how to use arrays, spans and for loops

#[cfg(test)]
mod tests {

    #[test]
    fn test_array_macro() {
        let mut arr: Array<u8> = array![1, 2, 3];
        arr.append(4);
        let removed_value = arr.pop_front();
        let first_value = *arr.at(0);
        let test_value = *arr.get(0).unwrap().unbox();

        assert!(arr.len() == 3);
        assert!(removed_value == Some(1));
        assert!(first_value == 2);
        assert!(test_value == 2);
    }

    fn add_array(arr: Span<u8>) -> u8 {
        let mut sum: u8 = 0;
        for i in 0..arr.len() {
            sum += *arr.at(i);
        }
        sum
    }

    #[test]
    fn test_iterate_array() {
        let arr: Array<u8> = array![1, 2, 3];
        let sum = add_array(arr.span());
        assert!(sum == 6);
    }
}