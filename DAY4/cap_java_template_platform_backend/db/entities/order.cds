namespace com.win.template;

using {com.win.template as temp} from '../index';

entity Orders {
    key ID     : String;
        header : Composition of one  temp.OrderHeaders;
        items  : Composition of many OrderItems;
        status : String;
}

aspect OrderItems {
    key ID     : Integer;
        book   : Association to temp.Books;
        quantity : Integer;
}
