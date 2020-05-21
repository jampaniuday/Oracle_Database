---------------------------------------------------------------------------------------------------------------------------------
DBMS_SCHEDULER | DBMS_JOB | 11g

DBMS_SCHEDULER.CREATE_JOB | DBMS_SCHEDULER.CREATE_PROGRAM   | DBMS_SCHEDULER.create_schedule| DBMS_SCHEDULER.CREATE_WINDOW | DBMS_SCHEDULER.CREATE_CHAIN 


#Estrutura completa da package DBMS_SCHEDULER
DESC DBMS_SCHEDULER


#Estrutura completa da package DBMS_JOB
DESC DBMS_JOB



Data Structures
The DBMS_SCHEDULER package defines OBJECT types and TABLE types


OBJECT Types

JOBARG Object Type

JOB Object Type

JOBATTR Object Type

SCHEDULER$_STEP_TYPE Object Type

TABLE Types

JOBARG_ARRAY Table Type

JOB_ARRAY Table Type

JOBATTR_ARRAY Table Type

SCHEDULER$_STEP_TYPE_LIST Table Type





JOB Object Type
This type is used by the CREATE_JOBS procedure and represents a job in a batch of jobs.

Syntax

TYPE job IS OBJECT (
   job_name             VARCHAR2(100),
   job_class            VARCHAR2(32),
   job_style            VARCHAR2(11),
   job_template         VARCHAR2(100)
   program_action       VARCHAR2(4000),
   action_type          VARCHAR2(20),
   schedule_name        VARCHAR2(65),
   repeat_interval      VARCHAR2(4000),
   schedule_limit       INTERVAL DAY(2) TO SECOND(6),
   start_date           TIMESTAMP(6) WITH TIME ZONE,
   end_date             TIMESTAMP(6) WITH TIME ZONE,
   event_condition      VARCHAR2(4000),
   queue_spec           VARCHAR2(100),
   number_of_args       NUMBER,
   arguments            JOBARG_ARRAY,
   priority             NUMBER,
   job_weight           NUMBER,
   max_run_duration     INTERVAL DAY(2) TO SECOND(6),
   max_runs             NUMBER,
   max_failures         NUMBER,
   logging_level        NUMBER,
   restartable          VARCHAR2(5),
   stop_on_window_exit  VARCHAR2(5),
   raise_events         NUMBER,
   comments             VARCHAR2(240),
   auto_drop            VARCHAR2(5),
   enabled              VARCHAR2(5),
   follow_default_tz    VARCHAR2(5),
   parallel_instances   VARCHAR2(5),
   aq_job               VARCHAR2(5),
   instance_id          NUMBER)



JOB Constructor Function
This constructor function constructs a job object.

Syntax

constructor function job (
   job_name            IN VARCHAR2,
   job_style           IN VARCHAR2 DEFAULT 'REGULAR',
   job_template        IN VARCHAR2 DEFAULT NULL,
   program_action      IN VARCHAR2 DEFAULT NULL,
   action_type         IN VARCHAR2 DEFAULT NULL,
   schedule_name       IN VARCHAR2 DEFAULT NULL,
   repeat_interval     IN VARCHAR2 DEFAULT NULL,
   event_condition     IN VARCHAR2 DEFAULT NULL,
   queue_spec          IN VARCHAR2 DEFAULT NULL,
   start_date          IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   end_date            IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   number_of_args      IN NATURAL DEFAULT NULL,
   arguments           IN JOBARG_ARRAY DEFAULT NULL,
   job_class           IN VARCHAR2 DEFAULT 'DEFAULT_JOB_CLASS',
   schedule_limit      IN INTERVAL DAY TO SECOND DEFAULT NULL,
   priority            IN NATURAL DEFAULT NULL,
   job_weight          IN NATURAL DEFAULT NULL,
   max_run_duration    IN INTERVAL DAY TO SECOND DEFAULT NULL,
   max_runs            IN NATURAL DEFAULT NULL,
   max_failures        IN NATURAL DEFAULT NULL,
   logging_level       IN NATURALN DEFAULT 64,
   restartable         IN BOOLEAN DEFAULT FALSE,
   stop_on_window_exit IN BOOLEAN DEFAULT FALSE,
   raise_events        IN NATURAL DEFAULT NULL,
   comments            IN VARCHAR2 DEFAULT NULL,
   auto_drop           IN BOOLEAN DEFAULT TRUE,
   enabled             IN BOOLEAN DEFAULT FALSE,
   follow_default_tz   IN BOOLEAN DEFAULT FALSE,
   parallel_instances  IN BOOLEAN DEFAULT FALSE,
   aq_job              IN BOOLEAN DEFAULT FALSE,
   instance_id         IN NATURAL DEFAULT NULL)
   RETURN SELF AS RESULT;





Using DBMS_SCHEDULER

Rules and Limits
The following rules apply when using the DBMS_SCHEDULER package:

Only SYS can do anything in SYS schema.

Several of the procedures accept comma-delimited lists of object names. When a list of names is provided, the Scheduler will stop executing the list on the very first object that returns an error. This means that the Scheduler will not perform the task on the objects in the list after the one that caused the error. For example, consider the statement DBMS_SCHEDULER.STOP_JOB ('job1, job2, job3, sys.jobclass1, sys.jobclass2, sys.jobclass3'); If job3 could not be stopped, then job1 and job2 will be stopped, but the jobs in jobclass1, jobclass2, and jobclass3 will not be stopped.

Performing an action on an object that does not exist returns a PL/SQL exception stating that the object does not exist.







Operational Notes
The Scheduler uses a rich calendaring syntax to enable you to define repeating schedules, such as "every Tuesday and Friday at 4:00 p.m." or "the second Wednesday of every month." This calendaring syntax is used in calendaring expressions in the repeat_interval argument of a number of package subprograms. Evaluating a calendaring expression results in a set of discrete timestamps.


Calendaring Syntax

In the following calendaring syntax, * means 0 or more.

repeat_interval = regular_schedule | combined_schedule
 
regular_schedule = frequency_clause
[";" interval_clause] [";" bymonth_clause] [";" byweekno_clause]
[";" byyearday_clause] [";" bydate_clause] [";" bymonthday_clause]
[";" byday_clause] [";" byhour_clause] [";" byminute_clause]
[";" bysecond_clause] [";" bysetpos_clause] [";" include_clause]
[";" exclude_clause] [";" intersect_clause][";" periods_clause]
[";" byperiod_clause]
 
combined_schedule = schedule_list [";" include_clause]
[";" exclude_clause] [";" intersect_clause]
frequency_clause = "FREQ" "=" ( predefined_frequency | user_defined_frequency )
predefined_frequency = "YEARLY" | "MONTHLY" | "WEEKLY" | "DAILY" | 
   "HOURLY" | "MINUTELY" | "SECONDLY"
user_defined_frequency = named_schedule

interval_clause = "INTERVAL" "=" intervalnum
   intervalnum = 1 through 99
bymonth_clause = "BYMONTH" "=" monthlist
   monthlist = monthday ( "," monthday)*
   month = numeric_month | char_month
   numeric_month = 1 | 2 | 3 ...  12
   char_month = "JAN" | "FEB" | "MAR" | "APR" | "MAY" | "JUN" |
   "JUL" | "AUG" | "SEP" | "OCT" | "NOV" | "DEC"
byweekno_clause = "BYWEEKNO" "=" weeknumber_list
   weeknumber_list = weeknumber ( "," weeknumber)*
   weeknumber = [minus] weekno
   weekno = 1 through 53
byyearday_clause = "BYYEARDAY" "=" yearday_list
   yearday_list = yearday ( "," yearday)*
   yearday = [minus] yeardaynum
   yeardaynum = 1 through 366
bydate_clause = "BYDATE" "=" date_list
   date_list = date ( "," date)*
   date = [YYYY]MMDD [ offset | span ]
bymonthday_clause = "BYMONTHDAY" "=" monthday_list
   monthday_list = monthday ( "," monthday)*
   monthday = [minus] monthdaynum
   monthdaynum = 1 through 31
byday_clause = "BYDAY" "=" byday_list
   byday_list = byday ( "," byday)*
   byday = [weekdaynum] day
   weekdaynum = [minus] daynum
   daynum = 1 through 53 /* if frequency is yearly */
   daynum = 1 through 5  /* if frequency is monthly */
   day = "MON" | "TUE" | "WED" | "THU" | "FRI" | "SAT" | "SUN"
byhour_clause = "BYHOUR" "=" hour_list
   hour_list = hour ( "," hour)*
   hour = 0 through 23
byminute_clause = "BYMINUTE" "=" minute_list
   minute_list = minute ( "," minute)*
   minute = 0 through 59
bysecond_clause = "BYSECOND" "=" second_list
   second_list = second ( "," second)*
   second = 0 through 59
bysetpos_clause = "BYSETPOS" "=" setpos_list
   setpos_list = setpos ("," setpos)*
   setpos = [minus] setpos_num
   setpos_num = 1 through 9999

include_clause = "INCLUDE" "=" schedule_list
exclude_clause = "EXCLUDE" "=" schedule_list
intersect_clause = "INTERSECT" "=" schedule_list
schedule_list = schedule_clause ("," schedule_clause)*
schedule_clause = named_schedule [ offset ]
named_schedule = [schema "."] schedule
periods_clause = "PERIODS" "=" periodnum
byperiod_clause = "BYPERIOD" "=" period_list
period_list = periodnum ("," periodnum)*
periodnum = 1 through 100

offset = ("+" | "-") ["OFFSET:"] duration_val
span = ("+" | "-" | "^") "SPAN:" duration_val
duration_val = dur-weeks | dur_days
dur_weeks = numofweeks "W"
dur_days = numofdays "D"
numofweeks = 1 through 53
numofdays = 1 through 376
minus = "-"



Name	Description
FREQ

This specifies the type of recurrence. It must be specified. The possible predefined frequency values are YEARLY, MONTHLY, WEEKLY, DAILY, HOURLY, MINUTELY, and SECONDLY. Alternatively, specifies an existing schedule to use as a user-defined frequency.

INTERVAL

This specifies a positive integer representing how often the recurrence repeats. The default is 1, which means every second for secondly, every day for daily, and so on. The maximum value is 999.

BYMONTH

This specifies which month or months you want the job to execute in. You can use numbers such as 1 for January and 3 for March, as well as three-letter abbreviations such as FEB for February and JUL for July.

BYWEEKNO

This specifies the week of the year as a number. It follows ISO-8601, which defines the week as starting with Monday and ending with Sunday; and the first week of a year as the first week, which is mostly within the Gregorian year. That last definition is equivalent to the following two variants: the week that contains the first Thursday of the Gregorian year; and the week containing January 4th.

The ISO-8601 week numbers are integers from 1 to 52 or 53; parts of week 1 may be in the previous calendar year; parts of week 52 may be in the following calendar year; and if a year has a week 53, parts of it must be in the following calendar year.

As an example, in the year 1998 the ISO week 1 began on Monday December 29th, 1997; and the last ISO week (week 53) ended on Sunday January 3rd, 1999. So December 29th, 1997, is in the ISO week 1998-01; and January 1st, 1999, is in the ISO week 1998-53.

byweekno is only valid for YEARLY.

Examples of invalid specifications are "FREQ=YEARLY; BYWEEKNO=1; BYMONTH=12" and "FREQ=YEARLY;BYWEEKNO=53;BYMONTH=1".

BYYEARDAY

This specifies the day of the year as a number. Valid values are 1 to 366. An example is 69, which is March 10 (31 for January, 28 for February, and 10 for March). 69 evaluates to March 10 for non-leap years and March 9 in leap years. -2 will always evaluate to December 30th independent of whether it is a leap year.

BYDATE

This specifies a list of dates, where each date is of the form [YYYY]MMDD. A list of consecutive dates can be generated by using the SPAN modifier, and a date can be adjusted with the OFFSET modifier. An example of a simple BYDATE clause is the following:

BYDATE=0115,0315,0615,0915,1215,20060115

The following SPAN example is equivalent to BYDATE=0110,0111,0112,0113,0114, which is a span of 5 days starting at 1/10:

BYDATE=0110+SPAN:5D

The plus sign in front of the SPAN keyword indicates a span starting at the supplied date. The minus sign indicates a span ending at the supplied date, and the "^" sign indicates a span of n days or weeks centered around the supplied date. If n is an even number, it is adjusted up to the next odd number.

Offsets adjust the supplied date by adding or subtracting n days or weeks. BYDATE=0205-OFFSET:2W is equivalent to BYDATE=0205-14D (the OFFSET: keyword is optional), which is also equivalent to BYDATE=0122.

BYMONTHDAY

This specifies the day of the month as a number. Valid values are 1 to 31. An example is 10, which means the 10th day of the selected month. You can use the minus sign (-) to count backward from the last day, so, for example, BYMONTHDAY=-1 means the last day of the month and BYMONTHDAY=-2 means the next to last day of the month.

BYDAY

This specifies the day of the week from Monday to Sunday in the form MON, TUE, and so on. Using numbers, you can specify the 26th Friday of the year, if using a YEARLY frequency, or the 4th THU of the month, using a MONTHLY frequency. Using the minus sign, you can say the second to last Friday of the month. For example, -1 FRI is the last Friday of the month.

BYHOUR

This specifies the hour on which the job is to run. Valid values are 0 to 23. As an example, 10 means 10 a.m.

BYMINUTE

This specifies the minute on which the job is to run. Valid values are 0 to 59. As an example, 45 means 45 minutes past the chosen hour.

BYSECOND

This specifies the second on which the job is to run. Valid values are 0 to 59. As an example, 30 means 30 seconds past the chosen minute.

BYSETPOS

This selects one or more items by position in the list of timestamps that result after the whole calendaring expression is evaluated. It is useful for requirements such as running a job on the last workday of the month. Rather than attempting to express this with the other BY clauses, you can code the calendaring expression to evaluate to a list of every workday of the month, and then add the BYSETPOS clause to select only the last item of that list. Assuming that workdays are Monday through Friday, the syntax would then be:

FREQ=MONTHLY; BYDAY=MON,TUE,WED,THU,FRI; BYSETPOS=-1
Valid values are 1 through 9999. A negative number selects an item from the end of the list (-1 is the last item, -2 is the next to last item, and so on) and a positive number selects from the front of the list. The BYSETPOS clause is always evaluated last. BYSETPOS is only supported with the MONTHLY and YEARLY frequencies.

The BYSETPOS clause is applied to the list of timestamps once per frequency period. For example, when the frequency is defined as MONTHLY, the Scheduler determines all valid timestamps for the month, orders that list, and then applies the BYSETPOS clause. The Scheduler then moves on to the next month and repeats the procedure. Assuming a start date of Jun 10, 2004, the example evaluates to: Jun 30, Jul 30, Aug 31, Sep 30, Oct 29, and so on.

INCLUDE

This includes one or more named schedules in the calendaring expression. That is, the set of timestamps defined by each included named schedule is added to the results of the calendaring expression. If an identical timestamp is contributed by both an included schedule and the calendaring expression, it is included in the resulting set of timestamps only once. The named schedules must have been defined with the CREATE_SCHEDULE procedure.

EXCLUDE

This excludes one or more named schedules from the calendaring expression. That is, the set of timestamps defined by each excluded named schedule is removed from the results of the calendaring expression. The named schedules must have been defined with the CREATE_SCHEDULE procedure.

INTERSECT

This specifies an intersection between the calendaring expression results and the set of timestamps defined by one or more named schedules. Only the timestamps that appear both in the calendaring expression and in one of the named schedules are included in the resulting set of timestamps.

For example, assume that the named schedule last_sat indicates the last Saturday in every month, and that for the year 2005, the only months where the last day of the month is also a Saturday are April and December. Assume also that the named schedule end_qtr indicates the last day of each quarter in 2005:

3/31/2005, 6/30/2005, 9/30/2005, 12/31/2005
The following calendaring expression results in these dates:

3/31/2005, 4/30/2005, 6/30/2005, 9/30/2005, 12/31/2005
FREQ=MONTHLY; BYMONTHDAY=-1; INTERSECT=last_sat,end_qtr
In this example, the terms FREQ=MONTHLY; BYMONTHDAY=-1 indicate the last day of each month.

PERIODS

This identifies the number of periods that together form one cycle of a user defined frequency. It is used in the repeat_interval expression of the schedule that defines the user defined frequency. It is mandatory when the repeat_interval expression in the main schedule contains a BYPERIOD clause. The following example defines the quarters of a fiscal year.

FREQ=YEARLY;BYDATE=0301,0601,0901,1201;PERIODS=4
BYPERIOD

This selects periods from a user defined frequency. For example, if a main schedule names a user defined frequency schedule that defines the fiscal quarters shown in the previous example, the clause BYPERIOD=2,4 in the main schedule selects the 2nd and 4th fiscal quarters.







BYDATE Clause Rules 
The following are rules for the BYDATE clause.

If dates in the BYDATE clause do not have their optional year component, the job runs on those dates every year.

The job execution times on the included dates are derived from the BY clauses in the calendaring expression. For example, if repeat_interval is defined as

freq=daily;byhour=8,13,18;byminute=0;bysecond=0;bydate=0502,0922
then the execution times on 05/02 and 09/22 are 8:00 a.m., 1:00 p.m., and 6:00 p.m.



EXCLUDE Clause Rules 
Excluded dates without a time component are 24 hour periods. All timestamps that fall on an excluded date are removed. In the following example, jan_fifteen is a named schedule that resolves to the single date of 01/15:

freq=monthly;bymonthday=15,30;byhour=8,13,18;byminute=0;bysecond=0;
     exclude=jan_fifteenth
In this case, all three instances of the job are removed for 01/15.




COPY_JOB Procedure
This procedure copies all attributes of an existing job to a new job. The new job is created disabled, while the state of the existing job is unaltered.

Syntax

DBMS_SCHEDULER.COPY_JOB (
   old_job                IN VARCHAR2,
   new_job                IN VARCHAR2);
Parameters

Table 114-14 COPY_JOB Procedure Parameters

Parameter	Description
old_job

The name of the existing job

new_job

The name of the new job


Usage Notes

Copying a job requires privileges to create a job in the schema of the new job (the CREATE JOB system privilege if it is in the user's own schema, and the CREATE ANY JOB system privilege otherwise). If the old job is not in the user's own schema, then he needs to additionally have ALTER privileges on the old job or the CREATE ANY JOB system privilege.




CREATE_CREDENTIAL Procedure
This procedure creates a stored username/password pair in a database object called a credential.

Syntax

DBMS_SCHEDULER.CREATE_CREDENTIAL (
   credential_name         IN VARCHAR2,
   username                IN VARCHAR2,
   password                IN VARCHAR2,
   database_role           IN VARCHAR2 DEFAULT NULL,
   windows_domain          IN VARCHAR2 DEFAULT NULL,
   comments                IN VARCHAR2 DEFAULT NULL);



Table 114-16 CREATE_CREDENTIAL Procedure Parameters

Parameter	Description
credential_name

This is the name that will be used to refer to the credential. It can optionally be prefixed with a schema. This cannot be set to NULL. It is converted to upper case unless enclosed in double-quotes.

username

This is the user name that will be used to login to the operating system to run a job if this credential is chosen. This cannot be set to NULL.

password

This is the password that will be used to login to the remote operating system to run a job if this credential is chosen. This cannot be set to NULL and is case sensitive. The password is stored obfuscated and is not displayed in the Scheduler dictionary views.

database_role

Reserved for future use.

windows_domain

For a Windows remote executable target, this is the domain that the specified user belongs to. The domain will be converted to uppercase automatically.

comments

This is a text string that can be used to describe the credential. This field is not used by the Scheduler.




CREATE_JOB Procedure
This procedure creates a single job (regular or lightweight). If you create the job enabled by setting the enabled attribute to TRUE, the Scheduler automatically runs the job according to its schedule. If you create the job disabled, the job does not run until you enable it with the SET_ATTRIBUTE Procedure.

The procedure is overloaded. The different functionality of each form of syntax is presented along with the syntax declaration.

Syntax

Creates a job in a single call without using an existing program or schedule:

DBMS_SCHEDULER.CREATE_JOB (
   job_name             IN VARCHAR2,
   job_type             IN VARCHAR2,
   job_action           IN VARCHAR2,
   number_of_arguments  IN PLS_INTEGER              DEFAULT 0,
   start_date           IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   repeat_interval      IN VARCHAR2                 DEFAULT NULL,
   end_date             IN TIMESTAMP WITH TIME ZONE DEFAULT NULL,
   job_class            IN VARCHAR2                 DEFAULT 'DEFAULT_JOB_CLASS',
   enabled              IN BOOLEAN                  DEFAULT FALSE,
   auto_drop            IN BOOLEAN                  DEFAULT TRUE,
   comments             IN VARCHAR2                 DEFAULT NULL);




Parameter	Description
job_name

This attribute specifies the name of the job and uniquely identifies the job. The name has to be unique in the SQL namespace. For example, a job cannot have the same name as a table in a schema. If the job being created will reside in another schema, it must be qualified with the schema name.

If job_name is not specified, an error is generated. If you want to have a name generated by the Scheduler, you can use the GENERATE_JOB_NAME procedure to generate a name and then use the output in the CREATE_JOB procedure. The GENERATE_JOB_NAME procedure call generates a number from a sequence, which is the job name. You can prefix the number with a string. The job name will then be the string with the number from the sequence appended to it. See "GENERATE_JOB_NAME Function" for more information.

job_type

This attribute specifies the type of job that you are creating. If it is not specified, an error is generated. The supported values are:

'PLSQL_BLOCK'

This specifies that the job is an anonymous PL/SQL block. Job or program arguments are not supported when the job or program type is PLSQL_BLOCK. In this case, the number of arguments must be 0.

'STORED_PROCEDURE'

This specifies that the job is a PL/SQL or Java stored procedure, or an external C subprogram. Only procedures, not functions with return values, are supported.

'EXECUTABLE'

This specifies that the job is a job external to the database. External jobs are anything that can be executed from the operating system's command line. Anydata arguments are not supported with a job or program type of EXECUTABLE. The job owner must have the CREATE EXTERNAL JOB system privilege before the job can be enabled or run.

'CHAIN'

This specifies that the job is a chain. Arguments are not supported for a chain, so number_of_arguments must be 0.

job_action

This attribute specifies the action of the job. The following actions are possible:

For a PL/SQL block, the action is to execute PL/SQL code. These blocks must end with a semi-colon. For example, my_proc(); or BEGIN my_proc(); END; or DECLARE arg pls_integer := 10; BEGIN my_proc2(arg); END;. Note that the Scheduler wraps job_action in its own block and passes the following to PL/SQL for execution: DECLARE ... BEGIN job_action END; This is done to declare some internal Scheduler variables. You can include any Scheduler metadata attribute except event_message in your PL/SQL code. You use the attribute name as you use any other PL/SQL identifier, and the Scheduler assigns it a value. See Table 114-30 for details on available metadata attributes.

For a stored procedure, the action is the name of the stored procedure. You have to specify the schema if the procedure resides in another schema than the job.

PL/SQL procedures with INOUT or OUT arguments are not supported as job_action when the job or program type is STORED_PROCEDURE.

For an executable, the action is the name of the external executable, including the full path name, but excluding any command-line arguments. If the action starts with a single question mark ('?'), the question mark is replaced by the path to the Oracle home directory for a local job or to the Scheduler agent home for a remote job. If the action contains an at-sign ('@') and the job is local, the at-sign is replaced with the SID of the current Oracle instance.

For a chain, the action is the name of a Scheduler chain object. You have to specify the schema of the chain if it resides in a different schema than the job.

If job_action is not specified for an inline program, an error is generated when creating the job.

number_of_arguments

This attribute specifies the number of arguments that the job expects. The range is 0-255, with the default being 0.

program_name

The name of the program associated with this job. If the program is of type EXECUTABLE, the job owner must have the CREATE EXTERNAL JOB system privilege before the job can be enabled or run.

start_date

This attribute specifies the first date and time on which this job is scheduled to start. If start_date and repeat_interval are left null, then the job is scheduled to run as soon as the job is enabled.

For repeating jobs that use a calendaring expression to specify the repeat interval, start_date is used as a reference date. The first time the job will be scheduled to run is the first match of the calendaring expression that is on or after the current date and time.

The Scheduler cannot guarantee that a job will execute on an exact time because the system may be overloaded and thus resources unavailable.

event_condition

This is a conditional expression based on the columns of the event source queue table. The expression must have the syntax of an Advanced Queuing rule. Accordingly, you can include user data properties in the expression provided that the message payload is an object type, and that you prefix object attributes in the expression with tab.user_data. For more information on rules, see the DBMS_AQADM.ADD_SUBSCRIBER procedure.

queue_spec

This argument specifies the queue into which events that start this particular job will be enqueued (the source queue). If the source queue is a secure queue, the queue_spec argument is a string containing a pair of values of the form queue_name, agent name. For non-secure queues, only the queue name need be provided. If a fully qualified queue name is not provided, the queue is assumed to be in the job owner's schema. In the case of secure queues, the agent name provided should belong to a valid agent that is currently subscribed to the queue.

repeat_interval

This attribute specifies how often the job should repeat. You can specify the repeat interval by using calendaring or PL/SQL expressions.

The expression specified is evaluated to determine the next time the job should run. If repeat_interval is not specified, the job will run only once at the specified start date. See "Calendaring Syntax" for further information.

schedule_name

The name of the schedule, window, or window group associated with this job.

job_class

The class this job is associated with.

end_date

This attribute specifies the date and time after which the job expires and is no longer run. After the end_date, if auto_drop is TRUE, the job is dropped. If auto_drop is FALSE, the job is disabled and the STATE of the job is set to COMPLETED.

If no value for end_date is specified, the job repeats forever unless max_runs or max_failures is set, in which case the job stops when either value is reached.

The value for end_date must be after the value for start_date. If it is not, an error is generated when the job is enabled.

comments

This attribute specifies a comment about the job. By default, this attribute is NULL.

job_style

Style of the job to create. This argument can have one of the following values:

'REGULAR' - a regular job will be created. This is the default.

'LIGHTWEIGHT' - a lightweight job is created. This value is permitted only when the job references a program object. Use lightweight jobs when you have many short-duration jobs that run frequently. Under certain circumstances, using lightweight jobs can deliver a small performance gain.

enabled

This attribute specifies whether the job is created enabled or not. The possible settings are TRUE or FALSE. By default, this attribute is set to FALSE and, therefore, the job is created as disabled. A disabled job means that the metadata about the job has been captured and the job exists as a database object but the Scheduler will ignore it and the job coordinator will not pick the job for processing. In order for the job coordinator to process the job, the job has to be enabled. You can enable a job by setting this argument to TRUE or by using the ENABLE procedure.

auto_drop

This flag, if TRUE, causes a job to be automatically dropped after it has completed or has been automatically disabled. A job is considered completed if:

Its end date (or its schedule's end date) has passed.

It has run max_runs number of times. max_runs must be set with SET_ATTRIBUTE.

It is not a repeating job and has run once.

A job is disabled when it has failed max_failures times. max_failures is also set with SET_ATTRIBUTE.

If this flag is set to FALSE, the jobs are not dropped and their metadata is kept until the job is explicitly dropped with the DROP_JOB procedure.

By default, jobs are created with auto_drop set to TRUE.












refes: https://docs.oracle.com/cd/B28359_01/appdev.111/b28419/d_sched.htm#BABEJGCH
obs:
desc: 

---------------------------------------------------------------------------------------------------------------------------------
