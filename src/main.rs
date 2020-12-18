use std::fs::File;
use std::io::prelude::*;
use wasmer::wat2wasm;
use wasmer_runtime::{error, imports, instantiate, Func};

fn get_wasm(fname: &'static str) -> Vec<u8> {
    let mut f = File::open(fname).unwrap();
    let mut buffer = Vec::new();
    f.read_to_end(&mut buffer).unwrap();
    wat2wasm(&buffer).unwrap().to_vec()
}

fn main() -> error::Result<()> {
    // We're not importing anything, so make an empty import object.
    let import_object = imports! {};
    let wasm = get_wasm("fib.wat");

    let instance = instantiate(&wasm, &import_object)?;

    let fib: Func<i32, i32> = instance.exports.get("fib")?;

    let value = fib.call(10)?;

    assert_eq!(value, 55);

    Ok(())
}
