Rem  Copyright ArtOfBI.com - All Rights Reserved.
Rem
Rem    NAME
Rem      AdvWorks_Create_User_Script.sql
Rem
Rem    DESCRIPTION
Rem      This script provides the logic to create a user, grant the appropriate
Rem	 privileges and tablespace areas for this tutorial to run under.
Rem      .
Rem
Rem    NOTES
Rem      .
Rem
Rem    REQUIREMENTS
Rem      - Oracle database 10g or better
Rem      - PL/SQL Web Toolkit
Rem
Rem
Rem    MODIFIED   (MM/DD/YYYY)
Rem      cscreen   08/14/2009 - Created
Rem      cscreen   12/15/2009 - Finalized




create user advworks identified by advworks;

alter user advworks
   default tablespace users
   temporary tablespace temp
   quota unlimited on users;

grant
   create session,
   resource
to advworks;

commit;
/
show errors


prompt S C R I P T    C O M P L E T E ! !