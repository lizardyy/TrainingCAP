namespace com.win.bookstore;

using {
    cuid,
    Currency,
    managed
} from '@sap/cds/common';

using {com.win.bookstore as temp} from '../index';

@fiori.draft.enabled
entity Books : cuid, managed {
    title        : localized temp.title;
    descr        : localized temp.description;
    stock        : Integer;
    price        : temp.price;
    currency     : Currency;
    rating       : temp.rating;
    review       : Association to many temp.Reviews on review.book = $self;
    isReviewable : temp.Tech_Boolean not null default true;
}

// input validation
annotate Books with {
    title @mandatory;
    stock @mandatory;
}
