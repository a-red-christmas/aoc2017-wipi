use std::collections::HashSet;

const INPUT: &'static str = "5	1	10	0	1	7	13	14	3	12	8	10	7	12	0	6";

fn get_registers() -> Vec<u32> {
    INPUT.split_whitespace().map(|value| value.parse::<u32>().unwrap()).collect()
}

fn balance_registers() -> u32 {
    let mut seen: HashSet<Vec<u32>> = HashSet::new();
    let mut registers = get_registers();
    let mut steps = 0;
    println!("{:?}", registers);
    loop {
        if seen.contains(&registers) {
            return steps;
        }

        seen.insert(registers.to_vec());
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
