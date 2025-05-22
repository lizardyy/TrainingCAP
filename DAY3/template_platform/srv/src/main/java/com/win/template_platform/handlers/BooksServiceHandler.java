package com.win.template_platform.handlers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.Result;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Update;
import com.sap.cds.ql.cqn.AnalysisResult;
import com.sap.cds.ql.cqn.CqnAnalyzer;
import com.sap.cds.ql.cqn.CqnInsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.reflect.CdsAssociationType;
import com.sap.cds.reflect.CdsAssociationType.Cardinality;
// import com.sap.cds.reflect.CdsAnnotation;
import com.sap.cds.reflect.CdsBaseType;
import com.sap.cds.reflect.CdsElement;
import com.sap.cds.reflect.CdsEntity;
import com.sap.cds.reflect.CdsModel;
import com.sap.cds.reflect.CdsSimpleType;
import com.sap.cds.reflect.CdsType;
import com.sap.cds.services.cds.CqnService;

import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.After;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.bookservice.AddReviewContext;
import cds.gen.bookservice.BookService_;

import cds.gen.bookservice.Authors;

import cds.gen.bookservice.Books;
import cds.gen.bookservice.Books_;
import cds.gen.bookservice.Reviews;
import cds.gen.bookservice.Reviews_;

import com.win.template_platform.common.RatingCalculator;

@Component
@ServiceName(BookService_.CDS_NAME)
public class BooksServiceHandler implements EventHandler {
    // @Autowired
    // private CqnAnalyzer analyzer;
    
    @Autowired
    private PersistenceService db;
    
    @Autowired
    private CdsModel model;

    @Autowired
    private RatingCalculator ratingCalculator;

    
    // BooksServiceHandler(PersistenceService db, CdsModel model) {
    //     this.db = db;
    //     this.analyzer = CqnAnalyzer.create(model);
    //     this.model = model;
    // }

    // @On(event = AddReviewContext.CDS_NAME)
    // public void addReview(AddReviewContext context) {

    //     System.out.println("test result from here：/");

    //     CqnSelect select = context.getCqn();
    //     AnalysisResult result = analyzer.analyze(select);
    //     Map<String, Object> targetKeys = result.targetKeys();
    //     String bookId = (String) targetKeys.get(Books.ID);

    //     Reviews review = Reviews.create();
    //     review.setBookId(bookId);
    //     review.setRating(context.getRating());
    //     review.setTitle(context.getTitle());
    //     review.setDescr(context.getDescr());

    //     // CqnSelect select2 = Select.from(Reviews_.CDS_NAME).byId(bookId);
    //     CqnInsert insert = Insert.into(Reviews_.CDS_NAME).entry(review);
    //     Result dbResult = db.run(insert);
    //     Reviews newReview = dbResult.single(Reviews.class);
    //     context.setResult(newReview);
    // }

    // @Before(event = CqnService.EVENT_READ)
    // public void inspectEntity() {
        
    //     CdsEntity productsEntity = model.getEntity("com.win.template.Books");
    //     if (productsEntity != null) {
    //         CdsElement titleElement = productsEntity.getElement("title");
    //         // Stream<CdsElement> elements = productsEntity.elements();
            
    //         boolean titleKey = titleElement.isKey(); // false
    //         CdsType titleType = titleElement.getType(); // CdsSimpleType

    //         if (titleType.isSimple()) { // true
    //             CdsSimpleType simpleTitle = titleType.as(CdsSimpleType.class);
    //             String titleTypeName = simpleTitle.getQualifiedName(); // "cds.String"
    //             CdsBaseType titleBaseType = simpleTitle.getType(); // CdsBaseType.STRING
    //             Class<?> titleJavaType = simpleTitle.getJavaType(); // String.class
    //             Boolean titleLocalized = simpleTitle.get("localized"); // true
    //             Integer titleLength = simpleTitle.get("length"); // 111
    //             System.out.println("Title Type Name: " + titleTypeName);
    //             System.out.println("Title Base Type: " + titleBaseType);
    //             System.out.println("Title Java Type: " + titleJavaType);
    //             System.out.println("Title Localized: " + titleLocalized);
    //             System.out.println("Title Length: " + titleLength);

    //         }
    //     }          
    // }

    // @Before(event = CqnService.EVENT_READ)
    // public void inspectAuthorAssociation() {
        
    //     CdsEntity productsEntity = model.getEntity("com.win.template.Books");
    //     if (productsEntity != null) {

    //     CdsElement categoryElement = productsEntity.getElement("author");
    //     CdsAssociationType toCategory = categoryElement.getType();

    //     CdsEntity category = toCategory.getTarget(); // Entity: my.bookshop.Authors
    //     boolean association = toCategory.isAssociation(); // true
    //     boolean composition = toCategory.isComposition(); // false

    //     Cardinality cardinality = toCategory.getCardinality();
    //     String sourceMax = cardinality.getSourceMax(); // "*"
    //     String targetMin = cardinality.getTargetMin(); // "0"
    //     String targetMax = cardinality.getTargetMax(); // "1"

    //     System.out.println("Source Max: " + sourceMax);
    //     System.out.println("Target Min: " + targetMin);
    //     System.out.println("Target Max: " + targetMax);

    //     }
    // }  

    // @Before(event = CqnService.EVENT_READ)
    // public void bookselect() {
    //     Authors author = Authors.create();
    //     author.setId(100);

    //     Books book = Books.create();
    //     book.setId("101");

    //     Insert insert = Insert.into(BOOKS).entry(book);
    //     Result result = db.run(insert);
    //     System.out.println(result);
    // }

     @On(event = AddReviewContext.CDS_NAME)
    public void onAddReview(AddReviewContext context) {

        String bookId = (String) CqnAnalyzer.create(model).analyze(context.getCqn()).targetKeys().get(Books.ID);

        Reviews review = Reviews.create();
        review.setBookId(bookId);
        review.setRating(context.getRating());
        review.setTitle(context.getTitle());
        review.setDescr(context.getDescr());

        context.setResult(db.run(Insert.into(Reviews_.CDS_NAME).entry(review)).single(Reviews.class));
    }

    @After(event = AddReviewContext.CDS_NAME)
    public void afterAddedReview(AddReviewContext context) {
        String bookId = context.getResult().getBookId();
        ratingCalculator.setBookRating(bookId);
        Books book = Books.create();
        book.setId(bookId);
        db.run(Update.entity(BookService_.BOOKS, b -> b.matching(book)).data(Books.IS_REVIEWABLE,
                false));
    }

    @Before(event = CqnService.EVENT_READ, entity = Books_.CDS_NAME)
    public void ininBooksBeforeRead() {
        ratingCalculator.initBookRatings();
        System.out.println("masuk");
    }

    @Before(event = CqnService.EVENT_CREATE, entity = Books_.CDS_NAME)
    public void initBookBeforeCreate(Books book) {
        book.setStatusCode("A");
        book.setIsbn(getNextIsbn());
    }

    private String getNextIsbn() {
        String isbnPrefix = "Win-";
        String isbnSuffix = "1000000000";
        return isbnPrefix + isbnSuffix;
    }

    @On(event = CqnService.EVENT_CREATE, entity = Books_.CDS_NAME)
    public void changeBookOnCreate(Books book) {
        if (book.getStock() == 0) {
            book.setStatusCode("O");
        }
    }

    @On(event = CqnService.EVENT_UPDATE, entity = Books_.CDS_NAME)
    public void changeBookOnUpdate(Books book) {
        book.setStatusCode(book.getStock() == 0 ? "O" : "A");
    }
}
