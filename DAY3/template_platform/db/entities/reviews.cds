namespace com.win.template;

using {
    cuid,
    managed
} from '@sap/cds/common';

using {com.win.template as temp} from '../index';

entity Reviews : cuid, managed {
    @cds.odata.ValueList
    book   : Association to temp.Books;
    rating : temp.rating @assert.range;
    title  : temp.title @mandatory;
    descr  : temp.description @mandatory;
}

// input validation
annotate Reviews with {
    book   @mandatory  @assert.target;
    rating @assert.range;
    title  @mandatory;
}
