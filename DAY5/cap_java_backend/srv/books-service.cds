using {com.win.bookstore as bs} from '../db/index';

@path: 'books'
service BookService {
  entity Books   as projection on bs.Books actions {
                      action addReview(rating : bs.rating_enum, title : bs.title, descr : bs.description) returns Reviews;
                    };

  entity Reviews as projection on bs.Reviews;
}
