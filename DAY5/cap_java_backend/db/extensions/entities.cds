using {com.win.bookstore as bs} from '../index';

extend bs.Books with {
    isbn : bs.ISBN;
}

// input validation
annotate bs.Books with {
    isbn @mandatory;
}
