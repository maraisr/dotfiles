use std::marker::PhantomData;

pub struct Source<'a> {
    start: *const u8,
    end: *const u8,
    cursor: *const u8,
    _m: PhantomData<&'a str>,
}

impl<'a> Source<'a> {
    pub fn new(text: &'a str) -> Self {
        let start = text.as_ptr();
        let end = unsafe { start.add(text.len()) };
        Self {
            start,
            end,
            cursor: start,
            _m: PhantomData,
        }
    }

    #[inline]
    pub fn is_eof(&self) -> bool {
        self.cursor == self.end
    }

    #[inline]
    pub fn offset(&self) -> usize {
        self.cursor as usize - self.start as usize
    }

    #[inline]
    pub fn peek_byte(&self) -> Option<u8> {
        if self.is_eof() {
            return None;
        }
        Some(unsafe { *self.cursor.as_ref().unwrap_unchecked() })
    }

    #[inline]
    pub fn bump(&mut self) {
        unsafe {
            self.cursor = self.cursor.add(1);
        }
    }

    #[inline]
    pub fn peek(&self) -> Option<char> {
        let c = self.peek_byte()?;
        if !c.is_ascii() {
            panic!("Only ASCII characters are supported");
        }
        Some(c as char)
    }

    #[inline]
    pub fn next(&mut self) -> Option<char> {
        let c = self.peek();
        self.bump();
        c
    }
}
