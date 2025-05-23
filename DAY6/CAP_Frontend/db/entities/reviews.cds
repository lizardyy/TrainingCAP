namespace com.win.bookstore;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {com.win.bookstore as temp} from '../index';

entity Reviews : cuid, managed {
    @cds.odata.ValueList
    book   : Association to temp.Books;
    rating : temp.rating;
    title  : temp.title;
    descr  : temp.description;
}

// input validation
annotate Reviews with {
    book   @mandatory  @assert.target;
    rating @assert.range;
    title  @mandatory;
}
