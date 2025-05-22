namespace com.win.template;

using {com.win.template as temp} from '../index';

entity Authors {
    key ID        : Integer;
        title     : String;
        name      : String(100);
        firstName : String;
        lastName  : String;
        age       : Integer;
        books     : Association to many temp.Books
                        on books.author = $self;
}
