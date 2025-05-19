namespace com.win.bookstore;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {com.win.bookstore as bs} from '../index';

entity Reviews : cuid, managed {
    @cds.odata.ValueList
    book   : Association to bs.Books;
    rating : bs.rating;
    title  : bs.title;
    descr  : bs.description;
}

// input validation
annotate Reviews with {
    book   @mandatory  @assert.target;
    rating @assert.range;
    title  @mandatory;
}
