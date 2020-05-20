/**************************************************************
 * FILE NAME:  xe.sql                                         *
 *                                                            *
 * PURPOSE: Test conection in database oracle                 *
 *                                                            *
 *                                                            *
 * Date        Author                       Release           *
 * 14-09-19    Pedro Akira Danno Lima       -------           *
 *                                                            * 
 *************************************************************/


/*nome da instancias*/ 
SELECT instance_Name FROM V$INSTANCE;



/*nome instancia e status=open|mount|nomount...*/
SELECT INSTANCE_NAME,STATUS FROM V$INSTANCE;



/*informacoes sobre instancias*/ 
SELECT * FROM V$INSTANCE;



/*informacoes sobre o BD*/
SELECT * FROM V$DATABASE;


/*mostrar todas as tabelas*/
SELECT * FROM ALL_TABLES;


/*mostrar paremetros spfile*/
SHOW parameter spfile;



/*mostrar file_name do tipo .dbf*/
SELECT file_name FROM dba_data_files;



/*mostrar tablespaces do db*/
SELECT TABLESPACE_NAME FROM DBA_TABLESPACES;


/*mostrar usuarios logados no DB*/
SELECT * FROM V$SESSION;



/*mostrar parametro de bloco*/
SHOW PARAMETER BLOCK 


/*lista de usuários no Oracle Database*/
select username from dba_users;



/*connect rman*/
$ rman target /


/*connect sqlplus*/
$ sqlplus / as sysdba


/*connect asm*/
$ asmcmd


/*mostrar usuario atual*/
show user





/*recyclebin é um sinônimo público para a visão user_recyclebin*/
/*objetos do usuário estão na lixeira*/
SELECT * FROM RECYCLEBIN;

/*objetos do usuário estão na lixeira*/
show recyclebin


/*estrutura da lixeira (tabela recyclebin)*/
desc recyclebin

/*limpar lixeira*/	
PURGE RECYCLEBIN;


/*Recuperando objetos da Lixeira*/
FLASHBACK TABLE employees TO BEFORE DROP;



/*banco está em modo ARCHIVELOG*/
SELECT LOG_MODE FROM V$DATABASE;



/*comandos rman*/

/*Para exibir a configuração atual da ferramenta execute:*/
SHOW ALL;


/*CONECTION NAME*/
SHOW CON_NAME;



/*todos os processo oracle database*/
ps -ef | grep orcl
/*orcl nome do banco de dados/instancia*/



/*ativar o servico listener*/
lsnrctl start


/*ativar o servico web*/
emctl start dbconsole;


/*testar tns*/
tnsping localhost



/*dicionairo de dados*/
select * from dict;
select TABLE_NAME from dict;
/*2628 rows selected*/



#vemos a estrutura completa da package DBMS_SCHEDULER
desc dbms_scheduler




/**********************************************************************************************************
*											REFERENCIAS 												  *
*													  													  *
*https://www.askmlabs.com/2018/09/install-oracle-database-18c-in-silent_8.html    			  			  *
*http://glufke.net/oracle/viewtopic.php?t=7023 								  							  *
*https://www.udemy.com/course/administracao-de-banco-de-dados-oracle-12c/learn/lecture/14570178#overview  *
*https://www.udemy.com/course/curso-completo-de-banco-de-oracle-dba/learn/lecture/13356994#overview       *
***********************************************************************************************************/



















