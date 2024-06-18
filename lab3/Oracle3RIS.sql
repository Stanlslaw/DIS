--PROFILE
create profile C##PFPAE limit
  password_life_time 180 
  sessions_per_user 3 
  failed_login_attempts 7 
  password_lock_time 1
  password_reuse_time 10 
  password_grace_time default 
  connect_time 180 
  idle_time 30; 

  select * from dba_profiles where profile='C##PFPAE';
--ROLE
 create role C##RL_PAE;
 select * from dba_roles where role like '%PAE%';
  GRANT CREATE SESSION TO C##RL_PAE;
  GRANT CREATE VIEW, DROP ANY VIEW TO C##RL_PAE;
  GRANT CREATE PROCEDURE, DROP ANY PROCEDURE TO C##RL_PAE;
  GRANT CREATE TABLE, DROP ANY TABLE TO C##RL_PAE;

select * from dba_sys_privs where grantee like '%C##RL_PAE';

--USER
  create user C##PAE identified by 12345
    profile C##PFPAE
    account unlock;
 GRANT CREATE DATABASE LINK TO C##PAE;

    select * from all_users where username like '%PAE%';

GRANT C##RL_PAE TO C##PAE;
GRANT ALL PRIVILEGES TO C##PAE;
---------------------------------------------------
CREATE DATABASE LINK TEA
CONNECT TO C##AKA IDENTIFIED BY "12345"
USING '192.168.64.138/PAVEL';


drop database link TEA;
---------------------------------------
---------------------------------------
---------------------------------------

create table RIS(
    id int primary key,
    str varchar(20), 
    numb NUMBER GENERATED ALWAYS AS IDENTITY
);
--drop table RIS;
select * from RIS@TEA;
select * from RIS;
--delete RIS@TEA;
--delete RIS;
commit;
rollback;

begin
    insert into RIS(id,str) values(2,'tolya');
    insert into RIS@TEA(id,str) values(2,'stas');
commit;
end;
truncate table RIS
truncate table RIS@TEA

select * from RIS@TEA;
select * from RIS;

begin
    insert into RIS(id,str) values(3,'andrey');
    update RIS@TEA set str='tanya123' where str ='stas';
commit;
end;

begin
    update RIS set str='react' where str ='andrey';
    insert into RIS@TEA(id,str) values(6,'budka');
commit;
end;

select * from RIS@TEA;
select * from RIS;

begin
    insert into RIS@TEA(id,str) values(21,'slivy');
commit;
end;

select * from RIS@TEA;
select * from RIS;

begin
    delete from RIS where id = 2;
end;

commit;