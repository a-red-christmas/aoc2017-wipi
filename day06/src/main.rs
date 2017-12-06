use std::collections::HashMap;

const INPUT: &'static str = "5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6";

fn get_registers() -> Vec<u32> {
    INPUT.split_whitespace().map(|value| value.parse::<u32>().unwrap()).collect()
}

fn balance_registers() -> u32 {
    let mut seen: HashMap<Vec<u32>, u32> = HashMap::new();
    let mut registers = get_registers();
    let mut steps = 0;
    println!("{:?}", registers);
    loop {
        match seen.get(&registers) {
            Some(original_step) => return steps - original_step,
            None => ()
        }

        seen.insert(registers.to_vec(), steps);
        steps += 1;
        let mut max = 0;
        let mut idx = 0;
        for x in 0..registers.len() {
            if registers[x] > max {
                max = registers[x];
                idx = x;
            }
        }

        let to_distribute = registers[idx];
        registers[idx] = 0;
        for _ in 0..to_distribute {
            idx = (idx + 1) % registers.len();
            registers[idx] = registers[idx] + 1;
        }

        println!("{:?}", registers);
    }
}

fn main() {
    println!("{}", balance_registers());
}
