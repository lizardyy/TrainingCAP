namespace com.win.bookstore;

using {com.win.bookstore as temp} from '../index';
using {sap.common.CodeList} from '@sap/cds/common';

type rating_enum : temp.rating enum {
    Best  = 5;
    Good  = 4;
    Avg   = 3;
    Poor  = 2;
    Worst = 1;
}

entity status: CodeList{
    key code : String(1) enum {
        soldOut ='O';
        onSelling = 'A';
        Outdated = 'X';
    } default 'O'
}