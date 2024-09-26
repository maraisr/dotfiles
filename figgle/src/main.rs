#![feature(allocator_api)]
#![feature(let_chains)]
#![feature(type_alias_impl_trait)]

use std::ops::Deref;

use miette::SourceCode;
use parser::{read_span, Definition};

extern crate bumpalo;
extern crate miette;
extern crate thiserror;

mod diagnostics;
mod lexer;
mod parser;

fn main() -> miette::Result<()> {
	let args = std::env::args().collect::<Vec<String>>();
	if args.len() == 2 {
		let path = &args[1];
		let buffer = std::fs::read_to_string(path).expect("Failed to read file");
		let arena = bumpalo::Bump::new();
		let parser = parser::Parser::new(&buffer, &arena);
		match parser.parse() {
			Ok(ast) => {
				println!("{ast:?}");

				// for item in ast.iter() {
				// 	let s = read_span(&buffer, &item.span);
				// 	println!("{:?}\n---\n{}\n---\n", item, s);

				// 	match item.deref() {
				// 		Definition::Task(a) => {
				// 			let name = &a.name;
				// 			let s = read_span(&buffer, &name.span);
				// 			println!("{:?}\n---\n{}\n---\n", name, s);
				// 		}
				// 		_ => {}
				// 	}
				// }
			},
			Err(e) => return Err(e.with_source_code(buffer.clone())),
		};
	}

	Ok(())

	//    let stdin = std::io::stdin();
	//    let mut handle = stdin.lock();

	//    loop {
	//        let mut line = String::new();
	//        let bytes = handle.read_line(&mut line).expect("Failed to read line");
	//        if bytes == 0 {
	//            break;
	//        }

	//        let lexer = lexer::Lexer::new(&line);
	//        for token in lexer {
	//            let s = &line[token.start..token.end];
	//            println!("{token:?} {s:?}");
	//        }
	//    }
}
