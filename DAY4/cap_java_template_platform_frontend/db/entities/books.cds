namespace com.win.template;

using {
    cuid,
    Currency,
    managed
} from '@sap/cds/common';

using {com.win.template as temp} from '../index';

@fiori.draft.enabled
entity Books : cuid, managed {
    title        : localized temp.title;
    descr        : localized temp.description;
    stock        : Integer;
    price        : temp.price;
    currency     : Currency;
    rating       : temp.rating;
    review       : Association to many temp.Reviews
                    on review.book = $self;
    isReviewable : temp.Tech_Boolean not null default true;
    status       : Association to temp.status @readomly;
    virtual criticality : Integer;
    virtual PrioCriticality : Integer;
    coverImage    : LargeBinary @Core.MediaType: 'image/png';
    media : LargeBinary @Core.MediaType: mediaType @Core.ContentDisposition.Filename: fileName;
    fileName : String;
    mediaType : String  @Core.IsMediaType
}

// input validation
annotate Books with {
    title @mandatory;
    stock @mandatory;
}
