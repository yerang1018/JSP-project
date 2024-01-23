drop table member cascade constraints purge;
drop table board cascade constraints purge;
drop table reply cascade constraints purge;
drop table saved cascade constraints purge;

create sequence member_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;


create sequence board_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;


create sequence reply_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;
    
create sequence save_seq 
    start with 1
    maxvalue 99999
    increment by 1
    nocycle
    nocache;    
    
    

create table member (
    idx         number              default member_seq.nextval primary key,
    userid      varchar2(100)       unique not null,
    userpw      varchar2(100)       not null,
    username    varchar2(100)       not null,
    email       varchar2(500)       not null
);


create table board (    --  �ܷ�Ű : member�� �ִ� ȸ���� �Խñ��� �ۼ��� �� ���� 
    idx         number              default board_seq.nextval primary key,
    title       varchar2(1000)      not null,
    image       varchar2(3000)      default 'default.jpg',
    category    varchar2(100)       check (category in('����' , '����')) not null,
    writer      varchar2(100),      
    content     varchar2(4000)      not null,
    writeDate   Date                default sysdate,
    deleted     number              default 0 check(deleted between 0 and 1),
    
    constraint board_member_fk 
    foreign key(writer) 
    REFERENCES member(userid) on delete set null
);



create table reply (    --  �ܷ�Ű 1 : ���� �Խñ��� ���� == reply ���̺��� board_idx
                        --  �ܷ�Ű 2 : member ���̺� �ִ� ȸ���� ����� �ۼ��� �� �ִ�
    idx             number          default reply_seq.nextval primary key,
    board_idx       number          not null, 
    writer          varchar2(100),
    content         varchar2(2000)  not null,
    writeDate       date            default sysdate,
    parent_idx      NUMBER          DEFAULT 0,
    reply_depth     number          default 0,
    
    constraint reply_board_fk
    foreign key(board_idx)
    REFERENCES board(idx),
    
    constraint reply_member_fk 
    foreign key(writer) 
    REFERENCES member(userid) on delete set null
);



create table saved (  
                        
    idx         number          default save_seq.nextval primary key,
    board_idx   number          not null, 
    memberId    varchar2(100),
    
    
    constraint save_board_fk
    foreign key(board_idx)
    REFERENCES board(idx),
    
    constraint save_member_fk
    foreign key(memberId)
    REFERENCES member(userid) on delete set null
);


--  ���̵����� ����
insert into member (userid, userpw, username, email) values ('test', '1234', '�׽�Ʈ', 'test@naver.com');
insert into member (userid, userpw, username, email) values ('it', 'it', '����Ƽ', 'it@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju1', '1234','���ֻ����ۿ�','jeju1@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju2', '1234','���ֹ���','jeju2@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju3', '1234','�����ѷ�','jeju3@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju4', '1234','�ڿ���','jeju4@naver.com');
INSERT INTO member (userid, userpw, username, email) VALUES ('jeju5', '1234','���ֳ���������','jeju5@naver.com');


insert into board (title, image, category, writer, content) values ('���ֻ� �ع�', '1.jpg', '����', 'test', '���ֵ��� ���� �ع��� �� �Ծ���Ѵ�..');
insert into board (title, image, category, writer, content) values ('��ⱹ�� ����', '2.jpg', '����', 'test', '��ⱹ�� �ʹ� ���־��');
insert into board (title, image, category, writer, content) values ('���ֵ� ī��', '3.jpg', '����', 'it', '�����̶� Ŀ�Ƕ� �߾�︳�ϴ�');
insert into board (title, image, category, writer, content) values ('���� ����', '4.jpg', '����', 'test', '���Ƕ��̽��� �ְ�');
insert into board (title, image, category, writer, content) values ('�ع����', '5.jpg', '����', 'jeju1', '���ֵ� �ع��� �� �̽��մϴ�');
insert into board (title, image, category, writer, content) values ('���� �ؼ�����', '6.jpg', '����', 'it', '�ٴٰ� �ʹ� ���޴ϴ� ~ ^^');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '���� ������Ź','����¼ҹ�.jpg', '����' , 'jeju1' , '���� ���� �¼ҹ�/������ ������ �ټ� �ɽ��� �� ������ ����û�� ������� ��������� ������ ���� ���� �� �ֽ��ϴ� ������ ������ �� ������ ��ĥ���� ��� ������ �԰� �Ѵ� ��� ���� �Ǿ� �־� ���� ������ ���� ���� �����ϰ� �´´� 
�ع����� �ٱ� ���� ��ħ�� Ư���� �İ����� �Դ� ��� ���� �ִ� ����Ʈ�� ������ ������ ���̽�ũ���� �Ծȿ��� �������� �����鼭 ��մ� �İ��� �������� �Բ� ��� �� �ִ�');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '���� �𸮳�Ʒ��', '�޷ε�.jpg', '����', 'jeju2', '���� �𸮳� �Ʒ�� /
TBC ȿ���� �ι�2���� �ں����� �����鼭 ȭ���� �� �޷ε� ��ū�� ����� �ε巯�� �޷ΰ� ������ ��� ���� �� ��︮�� ��ȭ�� ��������');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '���� �Ｚ��', '�Ｚ��.jpg' , '����', 'jeju1', '�Ｚ�� ���������� ���ֿ��� ������ �� ���ƿ� ���� �̻� ����̴� ��ó�� ����� ���ɰŸ��� �־ ���� ��ȭ�ñ⿡ ���߾� ���ְ��� �ȴٸ� 
�̻� �������� ���� ���� �� �ִ� ����̱⵵ �ϴ� ');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '�Ѷ�� ��ϴ�', '��ϴ�.jpg', '����', 'jeju4', '���� �Ѷ�� ��ϴ� /
���ֿ� ���ٸ� �� �����⸦ ��õ�ϴ� ��ϴ� 1�� �� ���ذ� ���� ���� �տ� �ű� ������ 3�밡 ���� �׾ƾ� �� �� �ִٴ� ���� �ִ� ��鼭 �ѹ��� �����ٸ� �ڿ��� ��ġ�� �ŷ�� �� �ִ� ����̴�');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '���� ��������', '��������.jpg' , '����', 'jeju5', '�������� /
������ ���� �̻� �������������� �㿡 ���� ���� ���� ���� 10�� �� �̻� ������ ������ �ϳ��̴� ����̳� ���� �ö� �ʿ���� �����忡�� ���� ���ϴÿ� �� ���� ������ �ٴٸ� �� �� �ִ� �� �� �ϳ��̴�');

INSERT INTO board (title, image, category, writer, content) VALUES (
        '���� ����ؼ�����', '����ؼ�����.jpg', '����', 'jeju5', '����ؼ����� /
���� ������ �ٴ��� ������ �ٴٸ� ������ �ִ� ��� �� �ϳ��̴� �� ���� ���Ľð��� �湮�ϸ� ������ �����⸦ ���� �� �ִ� �ٴ� �� �ϳ� �ؼ������� �����ϱ� ������ ����� ���� ���� �����ϰ� �ٴ� ��å�� �ϰ� �ʹٸ� ��õ�ϴ� ������');



--  ���̵����� ����
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;

INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;

INSERT INTO board (title, image, category, writer, content)
    select title, image, category, writer, content from board;
    
    
    

commit;