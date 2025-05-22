using {com.win.template as temp} from '../db/index';

@path: 'books'
service BookService {
  entity Books   as projection on temp.Books actions {
                      action addReview(rating : temp.rating_enum, title : temp.title, descr : temp.description) returns Reviews;
                    };

  entity Reviews as projection on temp.Reviews;
  entity Authors as projection on temp.Authors;
  entity Orders as projection on temp.Orders;
  entity OrderHeaders as projection on temp.OrderHeaders;

}
