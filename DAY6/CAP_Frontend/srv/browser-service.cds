using {com.win.bookstore as bs} from '../db/index';

@path: 'browser'
service BrowserService {

  @readonly
  entity Books   as
    projection on bs.Books
    excluding {
      createdBy,
      modifiedBy
    } actions {
      action addReview(rating : bs.rating_enum, title : bs.title, descr : bs.description) returns Reviews;
    };

  @readonly
  entity Reviews as projection on bs.Reviews;

}
