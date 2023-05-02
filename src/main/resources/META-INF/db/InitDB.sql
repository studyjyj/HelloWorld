-------------------------------- TABLE DROP ------------------------------------
DROP TABLE AT_RPLY;
DROP TABLE AT_REVIEW;
DROP TABLE ATTRACTION;
DROP TABLE ZONE;
DROP TABLE NOTICE;
DROP TABLE QNABOARD;
DROP TABLE TICKET_RESDETAIL;
DROP TABLE TICKET_RES;
DROP TABLE TICKET;
DROP TABLE THREVIEW;
DROP TABLE THEATER_SEAT;
DROP TABLE THEATER_RES;
DROP TABLE THEATER;
DROP TABLE ADMIN;
DROP TABLE MEMBER_GRADE;
DROP TABLE MEMBER;

-- SEQUENCE DROP
DROP SEQUENCE THREVIEW_SEQ;
DROP SEQUENCE THRCODE_SEQ;
DROP SEQUENCE THCODE_SEQ;
DROP SEQUENCE QNABOARD_SEQ;
DROP SEQUENCE TICKET_RESDETAIL_SEQ;
DROP SEQUENCE TICKET_RES_SEQ;
DROP SEQUENCE TICKET_SEQ;
DROP SEQUENCE NOTICE_SEQ;
DROP SEQUENCE ATTRACTION_SEQ;
DROP SEQUENCE AT_REVIEW_SEQ;
DROP SEQUENCE AT_RPLY_SEQ;

SELECT * FROM TABS;

------------------------------ SEQUENCE CREATE ---------------------------------
CREATE SEQUENCE TICKET_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE TICKET_RES_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE TICKET_RESDETAIL_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE QNABOARD_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE THCODE_SEQ
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE THRCODE_SEQ 
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE THREVIEW_SEQ 
    MAXVALUE 9999
    NOCACHE
    NOCYCLE;
CREATE SEQUENCE NOTICE_SEQ  
    MAXVALUE 99999 
    NOCACHE 
    NOCYCLE;
CREATE SEQUENCE ATTRACTION_SEQ 
    MAXVALUE 999 
    NOCACHE 
    NOCYCLE;
CREATE SEQUENCE AT_REVIEW_SEQ 
    MAXVALUE 9999999 
    NOCACHE 
    NOCYCLE;
CREATE SEQUENCE AT_RPLY_SEQ  
    MAXVALUE 9999999 
    NOCACHE 
    NOCYCLE;

-------------------------------- TABLE CREATE ----------------------------------
-- 회원 테이블
-- MEMBER
CREATE TABLE MEMBER_GRADE (
    GRADE VARCHAR2(10) PRIMARY KEY,
    LOWVI NUMBER(3) NOT NULL,
    HIGHVI NUMBER(3) NOT NULL,
    DISC NUMBER(3) NOT NULL
);

CREATE TABLE MEMBER (
    mID VARCHAR2(40) PRIMARY KEY,
    mMAIL VARCHAR2(50) NOT NULL UNIQUE,
    mPW VARCHAR2(20) NOT NULL,
    mNAME VARCHAR2(20) NOT NULL,
    mTEL VARCHAR2(15) NOT NULL UNIQUE,
    mVISIT NUMBER(3) DEFAULT 0 NOT NULL 
);

-- 관리자 테이블
-- ADMIN
CREATE TABLE ADMIN (
    adID    VARCHAR2(50) PRIMARY KEY,
    adPW    VARCHAR2(50) NOT NULL,
    adNAME  VARCHAR2(50) NOT NULL,
    adNUM   VARCHAR2(50) NOT NULL,
    adEMAIL VARCHAR2(50) NOT NULL
);

-- 공연 관련 테이블
-- THEATER
CREATE TABLE THEATER (
    thCODE    VARCHAR2(6) PRIMARY KEY,
    thNAME    VARCHAR2(50) NOT NULL,
    thCONTENT VARCHAR2(100) NOT NULL,
    thTIME    VARCHAR2(10) NOT NULL,
    thLOC     VARCHAR2(50) NOT NULL,
    thSEAT    VARCHAR2(2) NOT NULL,
    thPRICE   NUMBER(9) NOT NULL,
    thIMG1    VARCHAR2(100) NOT NULL,
    thSCHEDULE NUMBER(1) NOT NULL
);

-- THEATER_RES
CREATE TABLE THEATER_RES (
    thrCODE VARCHAR2(20) PRIMARY KEY, 
    mID     VARCHAR2(40) NOT NULL,
    thCODE  VARCHAR2(6) NOT NULL REFERENCES THEATER(thCODE),
    thrCNT  NUMBER(3) NOT NULL,
    thrORDERDATE TIMESTAMP NOT NULL,
    thrREVIEW    NUMBER(1), 
    thrTOTPRICE  NUMBER(10) NOT NULL,
    thrDATE      DATE NOT NULL
);

-- THEATER_SEAT     
CREATE TABLE THEATER_SEAT (
    SEATCODE VARCHAR2(4) PRIMARY KEY,
    thrCODE  VARCHAR2(20) NOT NULL REFERENCES THEATER_RES(thrCODE)
);

-- THEATER_REVIEW    
CREATE TABLE THREVIEW (
    thrNUM     NUMBER(4) PRIMARY KEY,
    thrCODE    VARCHAR2(20) NOT NULL, 
    mID        VARCHAR2(40) NOT NULL REFERENCES MEMBER(mID),
    thrTITLE   VARCHAR2(50) NOT NULL,
    thrCONTENT VARCHAR2(4000) NOT NULL,
    thrRDATE   DATE NOT NULL
);

-- 티켓 예약 테이블
-- TICKET
CREATE TABLE TICKET(
    tCODE VARCHAR2(6) PRIMARY KEY,
    tNAME VARCHAR2(50) NOT NULL,
    tSUB VARCHAR2(255) NOT NULL,
    tTYPE VARCHAR2(50) NOT NULL,
    tPRICE NUMBER(9) NOT NULL,
    tCONTENT VARCHAR2(4000) NOT NULL,
    tIMG VARCHAR2(255) NOT NULL
);

-- TICKET_RES
CREATE TABLE TICKET_RES(
    trCODE VARCHAR2(20) PRIMARY KEY,
    mID VARCHAR2(40) NOT NULL REFERENCES MEMBER(mID),
    trORDERDATE TIMESTAMP DEFAULT SYSDATE,
    trTOTPRICE NUMBER(9),
    TRRESULT NUMBER(1) DEFAULT 0
);

-- TICKET_RESDETAIL
CREATE TABLE TICKET_RESDETAIL(
    trdCODE NUMBER(4) PRIMARY KEY,
    trCODE VARCHAR2(20) NOT NULL REFERENCES TICKET_RES(trCODE),
    trdNAME VARCHAR2(50) NOT NULL,
    trdTYPE VARCHAR2(50) NOT NULL,
    trdCNT NUMBER(3) NOT NULL,
    trdDATE DATE NOT NULL,
    trdRESULT NUMBER(1) DEFAULT 0
);

-- 놀이동산 관련 테이블
-- ZONE
CREATE TABLE ZONE (
    zNAME VARCHAR2(50) PRIMARY KEY,
    zPLACE VARCHAR2 (100),
    zLAT NUMBER(10,6), 
    zLNG NUMBER(10,6)
);

-- ATTRACTION 
CREATE TABLE ATTRACTION (
    atCODE   NUMBER(3) PRIMARY KEY,
    atNAME VARCHAR2(50) NOT NULL UNIQUE,
    atCONTENT CLOB NOT NULL,
    atADDR VARCHAR2 (100) NOT NULL,
    atPOST NUMBER(5) NOT NULL,
    atIMAGE VARCHAR2 (200) DEFAULT 'noImg.png',
    atRDATE DATE DEFAULT SYSDATE NOT NULL,
    atOLD NUMBER(3) DEFAULT 0 NOT NULL,
    atHEIGHT NUMBER(3) DEFAULT 0 NOT NULL,
    atWEIGHT NUMBER(3) DEFAULT 0 NOT NULL,
    atLAT NUMBER(10,6), 
    atLNG NUMBER(10,6),
    atYOUTUBE VARCHAR2(200),
    atNOP NUMBER(3),
    adID  VARCHAR2(50) REFERENCES ADMIN(adID) NOT NULL,
    zNAME VARCHAR2(50) REFERENCES ZONE(zNAME) NOT NULL
);

-- AT_REVIEW
CREATE TABLE AT_REVIEW (
    arvNUM NUMBER(7) PRIMARY KEY,
    arvRDATE DATE DEFAULT SYSDATE NOT NULL,
    arvCONTENT VARCHAR2(4000) NOT NULL,
    arvRATING NUMBER(2,1) NOT NULL,
    arv_HIT NUMBER(6) DEFAULT 0, 
    atCODE NUMBER(3) REFERENCES ATTRACTION(atCODE) NOT NULL,
    mID VARCHAR2(40) REFERENCES MEMBER(mID)
);

-- AT_RPLY
CREATE TABLE AT_RPLY(
    apyNum NUMBER(7) PRIMARY KEY,
    adID VARCHAR2(50) REFERENCES ADMIN(adID),
    mID VARCHAR2(50) REFERENCES MEMBER(mID),
    atCODE NUMBER(3) REFERENCES ATTRACTION(atCODE) NOT NULL,
    apyTITLE VARCHAR2(50) NOT NULL,
    apyCONTENT VARCHAR2(4000) NOT NULL,
    apyRDATE DATE DEFAULT SYSDATE NOT NULL,
    apyGROUP NUMBER(7),
    apySTEP NUMBER(7),
    apyINDENT NUMBER(7),
    apyIP VARCHAR2(30) 
);

-- 1:1 문의 게시판
-- QNABOARD
CREATE TABLE QNABOARD(
    qaNUM NUMBER(4) PRIMARY KEY,
    mID VARCHAR2(40) REFERENCES MEMBER(mID),
    adID VARCHAR2(40) REFERENCES ADMIN(adID),
    qaCat VARCHAR2(50) NOT NULL,
    qaTITLE VARCHAR2(50) NOT NULL,
    qaCONTENT VARCHAR2(4000) NOT NULL,
    qaPW VARCHAR2(20) NOT NULL,
    qaRDATE TIMESTAMP DEFAULT SYSDATE,
    qaHIT NUMBER(4) DEFAULT 0,
    qaGROUP NUMBER(4) NOT NULL,
    qaSTEP NUMBER(4) NOT NULL,
    qaINDENT NUMBER(4) NOT NULL,
    qaIP VARCHAR2(20) NOT NULL
);

-- 공지사항 테이블
-- NOTICE 
CREATE TABLE NOTICE(
    nNO      NUMBER(5) PRIMARY KEY,
    nTITLE   VARCHAR2(50) NOT NULL,
    nCONTENT VARCHAR2(100) DEFAULT 'noImg.png' NOT NULL,
    nRDATE   DATE DEFAULT SYSDATE NOT NULL,
    nTYPE    VARCHAR2(50) NOT NULL,
    adID     VARCHAR2(50) REFERENCES ADMIN(adID) NOT NULL
);

COMMIT;