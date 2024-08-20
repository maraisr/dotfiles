mod lexer;

fn main() {
    let args = std::env::args().collect::<Vec<String>>();
    if args.len() == 2 {
        let path = &args[1];
        let buffer = std::fs::read_to_string(path).expect("Failed to read file");
        let lexer = lexer::Lexer::new(&buffer);
        for token in lexer {
            let s = &buffer[token.span.start..token.span.end];
            println!("{token:?} {s:?}");
        }
    }

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
