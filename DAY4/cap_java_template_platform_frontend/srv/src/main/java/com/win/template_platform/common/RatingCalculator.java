package com.win.template_platform.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.OptionalDouble;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.bookservice.BookService_;
import cds.gen.com.win.template.Books;
import cds.gen.com.win.template.Reviews;

/**
 * Takes care of calculating the average rating of a book based on its review
 * ratings.
 */
@Component
public class RatingCalculator {

    @Autowired
    private PersistenceService db;

    /**
     * Initializes the ratings for all existing books based on their reviews.
     */
    public void initBookRatings() {
        Result result = db.run(Select.from(BookService_.BOOKS).columns(b -> b.ID()));
        for (Books book : result.listOf(Books.class)) {
            setBookRating(book.getId());
        }
    }

    /**
     * Sets the average rating for the given book.
     *
     * @param bookId
     */
    public void setBookRating(String bookId) {
        Result run = db.run(Select.from(BookService_.BOOKS, b -> b.filter(b.ID().eq(bookId)).review()));

        Stream<Double> ratings = run.streamOf(Reviews.class).map(r -> r.getRating().doubleValue());
        BigDecimal rating = getAvgRating(ratings);
        db.run(Update.entity(BookService_.BOOKS, b -> b.matching(Books.create(bookId))).data(Books.RATING, rating));
    }

    static BigDecimal getAvgRating(Stream<Double> ratings) {
        OptionalDouble avg = ratings.mapToDouble(Double::doubleValue).average();
        if (!avg.isPresent()) {
            return BigDecimal.ZERO;
        }
        return BigDecimal.valueOf(avg.getAsDouble()).setScale(1, RoundingMode.HALF_UP);
    }
}
