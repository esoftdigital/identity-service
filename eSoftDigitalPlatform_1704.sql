PGDMP  *    5                |            eSoftDigitalPlatform    16.2    16.2 �   �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    17297    eSoftDigitalPlatform    DATABASE     �   CREATE DATABASE "eSoftDigitalPlatform" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_India.1252';
 &   DROP DATABASE "eSoftDigitalPlatform";
                postgres    false            �           0    0    DATABASE "eSoftDigitalPlatform"    COMMENT     F   COMMENT ON DATABASE "eSoftDigitalPlatform" IS 'eSoftDigitalPlatform';
                   postgres    false    5510                        2615    17298    ADMIN    SCHEMA        CREATE SCHEMA "ADMIN";
    DROP SCHEMA "ADMIN";
                postgres    false                        2615    17299    API    SCHEMA        CREATE SCHEMA "API";
    DROP SCHEMA "API";
                postgres    false                        2615    17300    APIDATA    SCHEMA        CREATE SCHEMA "APIDATA";
    DROP SCHEMA "APIDATA";
                postgres    false            	            2615    17301    BACKUP    SCHEMA        CREATE SCHEMA "BACKUP";
    DROP SCHEMA "BACKUP";
                postgres    false            
            2615    17302    CONFIG    SCHEMA        CREATE SCHEMA "CONFIG";
    DROP SCHEMA "CONFIG";
                postgres    false                        2615    17303    DATA    SCHEMA        CREATE SCHEMA "DATA";
    DROP SCHEMA "DATA";
                postgres    false                        2615    17304    DETAIL    SCHEMA        CREATE SCHEMA "DETAIL";
    DROP SCHEMA "DETAIL";
                postgres    false                        2615    17305    ERROR    SCHEMA        CREATE SCHEMA "ERROR";
    DROP SCHEMA "ERROR";
                postgres    false                        2615    17306    EXE    SCHEMA        CREATE SCHEMA "EXE";
    DROP SCHEMA "EXE";
                postgres    false                        2615    17307    FIND    SCHEMA        CREATE SCHEMA "FIND";
    DROP SCHEMA "FIND";
                postgres    false                        2615    17308    FUNC    SCHEMA        CREATE SCHEMA "FUNC";
    DROP SCHEMA "FUNC";
                postgres    false                        2615    17309    KEEP    SCHEMA        CREATE SCHEMA "KEEP";
    DROP SCHEMA "KEEP";
                postgres    false                        2615    17310    KICKOUT    SCHEMA        CREATE SCHEMA "KICKOUT";
    DROP SCHEMA "KICKOUT";
                postgres    false                        2615    17311    LEAD    SCHEMA        CREATE SCHEMA "LEAD";
    DROP SCHEMA "LEAD";
                postgres    false                        2615    17312    LINK    SCHEMA        CREATE SCHEMA "LINK";
    DROP SCHEMA "LINK";
                postgres    false                        2615    17313    LIST    SCHEMA        CREATE SCHEMA "LIST";
    DROP SCHEMA "LIST";
                postgres    false                        2615    17314    LKP    SCHEMA        CREATE SCHEMA "LKP";
    DROP SCHEMA "LKP";
                postgres    false                        2615    17315    LOGS    SCHEMA        CREATE SCHEMA "LOGS";
    DROP SCHEMA "LOGS";
                postgres    false                        2615    17316    SEARCH    SCHEMA        CREATE SCHEMA "SEARCH";
    DROP SCHEMA "SEARCH";
                postgres    false                        2615    17317    STAGE    SCHEMA        CREATE SCHEMA "STAGE";
    DROP SCHEMA "STAGE";
                postgres    false                        2615    17318    STORE    SCHEMA        CREATE SCHEMA "STORE";
    DROP SCHEMA "STORE";
                postgres    false                        2615    17319    SWEEP    SCHEMA        CREATE SCHEMA "SWEEP";
    DROP SCHEMA "SWEEP";
                postgres    false                        2615    17320    TRACK    SCHEMA        CREATE SCHEMA "TRACK";
    DROP SCHEMA "TRACK";
                postgres    false                        2615    17321 	   TRANSLATE    SCHEMA        CREATE SCHEMA "TRANSLATE";
    DROP SCHEMA "TRANSLATE";
                postgres    false                        2615    17322    XREF    SCHEMA        CREATE SCHEMA "XREF";
    DROP SCHEMA "XREF";
                postgres    false                        2615    17323 
   XREFCONFIG    SCHEMA        CREATE SCHEMA "XREFCONFIG";
    DROP SCHEMA "XREFCONFIG";
                postgres    false            l           1255    17324 �   AddexecutionProgress(character varying, character varying, character varying, character varying, date, time without time zone, time without time zone, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE "LOGS"."AddexecutionProgress"(IN "@ExecutionProcessName" character varying, IN "@ExecutionObjectName" character varying, IN "@StepDescription" character varying, IN "@Request" character varying, IN "@ProcessDate" date, IN "@StartTime" time without time zone, IN "@EndTime" time without time zone, IN "@PG_BackEnd_PID" integer, IN "@RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@ServerName"		 	VARCHAR;			
	"@DatabaseName"			VARCHAR;			
	"@SchemaName"		  	VARCHAR;			
	"@Duration"			  	TIME;			
	"@CurrentQuery"		  	VARCHAR;		
	"@Inet_Client_Addr"	  	INET;		
	"@Inet_Server_Addr"	  	INET;
	"@ApplicationName"	  	VARCHAR;	
	"@PG_BackEnd_PID"	  	INT;		
	"@VersionNo"			VARCHAR;
	"@IsLog"				BOOLEAN;
	"@RequestDate"			TIMESTAMP;
	"@IsDisabled"			BOOLEAN;
	"@SessionUser"			NAME;

BEGIN

	
/****************************************************************************************************************************************
Procedure		:   "LOGS"."AddexecutionProgress"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	
					CALL "LOGS"."AddexecutionProgress" ()

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-03					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/

	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================

	DROP TABLE IF EXISTS HostName;
	CREATE TEMP TABLE HostName (HostName VARCHAR) ON COMMIT DROP;
	-- filling the column with the result of the command
	COPY HostName (HostName) FROM PROGRAM 'hostname';
	
	
	"@IsLog" = TRUE;		--Note :  We need to Set TRUE OR FALSE  TRUE : START , FALSE = STOP
	
	"@ServerName"			= (SELECT HostName FROM HostName LIMIT 1);
	"@DatabaseName"			= CURRENT_DATABASE();		
	"@SchemaName"			= CURRENT_SCHEMA();			
	"@Duration"				= ("@EndTime" - "@StartTime");		
	"@CurrentQuery"			= Current_Query();	
	"@Inet_Client_Addr"		= Inet_Client_Addr();	
	"@Inet_Server_Addr"		= Inet_Server_Addr();	
	"@ApplicationName"		= Current_Setting('application_name');
	"@PG_BackEnd_PID"		= Pg_Backend_Pid();	
	"@VersionNo"			= Version();
	"@RequestDate"			= NOW();
	"@IsDisabled"			= FALSE;
	"@SessionUser"			= CURRENT_USER;
	
	

	
	IF 	"@IsLog" IS TRUE THEN
	
		INSERT
			INTO "TRACK"."ExecutionProgress"
			(
				"IsDisabled"			  	   
				,"CreatedOn"			  	   
				,"CreatedByUserName"	  	   
				,"UpdatedOn"			  	   
				,"UpdatedByUserName"
				,"ServerName"
				,"DatabaseName"	
				,"ProcessDate"					
				,"ExecutionProcessName"		   
				,"ExecutionObjectName"		   
				,"StepDescription"		  	   
				,"Request"		  	    		
				,"StartTime"				  	
				,"EndTime"				  		
				,"Duration"						
				,"CurrentQuery"					
				,"Inet_Client_Addr"				
				,"Inet_Server_Addr"				
				,"PG_BackEnd_PID"				
				,"SessionUser"					
				,"ApplicationName"				
				,"VersionNo"			

			)
		SELECT
				 "@IsDisabled"							  	   
				,"@RequestDate"							  	   
				,"@RequestUserName" 		  	   
				,"@RequestDate"							  	   
				,"@RequestUserName"
				,"@ServerName"
				,"@DatabaseName"	
				,"@ProcessDate"					
				,"@ExecutionProcessName"		   
				,"@ExecutionObjectName"		   
				,"@StepDescription"		  	   
				,"@Request"		  	    		
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@Duration"						
				,"@CurrentQuery"					
				,"@Inet_Client_Addr"				
				,"@Inet_Server_Addr"				
				,"@PG_BackEnd_PID"				
				,"@SessionUser"					
				,"@ApplicationName"				
				,"@VersionNo";			

	END IF;

END
$$;
 �  DROP PROCEDURE "LOGS"."AddexecutionProgress"(IN "@ExecutionProcessName" character varying, IN "@ExecutionObjectName" character varying, IN "@StepDescription" character varying, IN "@Request" character varying, IN "@ProcessDate" date, IN "@StartTime" time without time zone, IN "@EndTime" time without time zone, IN "@PG_BackEnd_PID" integer, IN "@RequestUserName" character varying);
       LOGS          postgres    false    23            m           1255    17325 �   DatabaseErrorLog(character varying, integer, character varying, character varying, character varying, character varying, character varying, character varying) 	   PROCEDURE     =  CREATE PROCEDURE "LOGS"."DatabaseErrorLog"(IN "@ExecutionProcessName" character varying, IN "@PG_BackEnd_PID" integer, IN "@Returned_SQLState" character varying, IN "@Message_Text" character varying, IN "@PG_Exception_Detail" character varying, IN "@PG_Exception_Hint" character varying, IN "@PG_Exception_Context" character varying, IN "@RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@ServerName"		 	VARCHAR;			
	"@DatabaseName"			VARCHAR;
	"@ApplicationName"		VARCHAR;
	"@PG_BackEnd_PID"	  	INT;		
	"@Version"				VARCHAR;
	"@RequestDate"			TIMESTAMP;
	"@IsDisabled"			BOOLEAN;
	"@IsLog"				BOOLEAN;

BEGIN

	
/****************************************************************************************************************************************
Procedure		:   "LOGS"."DatabaseErrorLog"
Create Date		:   2024-Apr-04
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	
					CALL "LOG"."DatabaseErrorLog" ()

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-04					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/

	
	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================

	DROP TABLE IF EXISTS HostName;
	CREATE TEMP TABLE HostName (HostName VARCHAR) ON COMMIT DROP;
	-- filling the column with the result of the command
	COPY HostName (HostName) FROM PROGRAM 'hostname';
	
	
	"@IsLog" = TRUE;		--Note :  We need to Set TRUE OR FALSE  TRUE : START , FALSE = STOP
	
	"@ServerName"		= (SELECT HostName FROM HostName LIMIT 1);
	"@ApplicationName"	= Current_Setting('application_name');
	"@DatabaseName"		= CURRENT_DATABASE();		
	"@PG_BackEnd_PID"	= Pg_Backend_Pid();	
	"@Version"			= Version();
	"@RequestDate"		= NOW();
	"@IsDisabled"		= FALSE;
	

	
	IF 	"@IsLog" IS TRUE THEN
			
		INSERT
			INTO "ERROR"."DatabaseError"
		(
			 "IsDisabled"			
			,"CreatedOn"			
			,"CreatedByUserName"	
			,"UpdatedOn"			
			,"UpdatedByUserName"	
			,"ServerName"			
			,"DatabaseName"		
			,"ExecutionProcessName"
			,"PG_BackEnd_PID"		
			,"Returned_SQLState"	
			,"Message_Text"				
			,"PG_Exception_Detail"	
			,"PG_Exception_Hint"	
			,"PG_Exception_Context"	
			,"ApplicationName"
			,"Version"				
		
		)
		SELECT
			 "@IsDisabled"			
			,"@RequestDate"			
			,"@RequestUserName"	
			,"@RequestDate"		
			,"@RequestUserName"	
			,"@ServerName"			
			,"@DatabaseName"
			,"@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"				
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@ApplicationName"
			,"@Version";					

	END IF;

END
$$;
 v  DROP PROCEDURE "LOGS"."DatabaseErrorLog"(IN "@ExecutionProcessName" character varying, IN "@PG_BackEnd_PID" integer, IN "@Returned_SQLState" character varying, IN "@Message_Text" character varying, IN "@PG_Exception_Detail" character varying, IN "@PG_Exception_Hint" character varying, IN "@PG_Exception_Context" character varying, IN "@RequestUserName" character varying);
       LOGS          postgres    false    23            n           1255    17326 d   AddApplication(smallint, smallint, character varying, character varying, boolean, character varying)    FUNCTION     c%  CREATE FUNCTION "STORE"."AddApplication"("@FlagID" smallint, "@ApplicationID" smallint, "@ApplicationName" character varying, "@ApplicationCode" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "ApplicationID" smallint, "ApplicationName" character varying, "ApplicationCode" character varying, "Status" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."AddApplication"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."AddApplication"(FlagID,ApplicationID,ApplicationName,ApplicationCode,IsDisabled,RequestUserName)
					SELECT * FROM "STORE"."AddApplication"(2,1,'','','',FALSE,'')

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-11					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/


	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.AddApplication';
	"@ExecutionObjectName" 		= 'LKP.Application';
	"@StepDescription" 			= 'Application Creation';
	"@Request"					= CONCAT_WS(',',"@FlagID","@ApplicationID","@ApplicationName","@ApplicationCode","@IsDisabled","@RequestUserName");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();

 					
		

	"@RequestDate"			= NOW();
	"@RequestUserName"		= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);
	"@ApplicationName"		= INITCAP("@ApplicationName");
	"@ApplicationCode" 		= UPPER("@ApplicationCode");
	
	


	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================
	
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================


	IF "@FlagID" = 1 THEN --View

		RETURN QUERY
		SELECT
			 '000'::VARCHAR				AS ResponseCode
			,'SUCCESS'::VARCHAR			AS ResponseString
			,"ApplicationID"			AS ApplicationID
			,"ApplicationName"			AS ApplicationName
			,''::VARCHAR				AS ApplicationCode 
			,''::VARCHAR 				AS Status
			,''::VARCHAR 				AS RequestDate
			,''::VARCHAR				AS RequestUserName
		FROM 
			"LKP"."Application" LA
		WHERE
			1 = 1
		ORDER BY "ApplicationName" ASC;
	
	END IF;


	IF "@FlagID" = 2 THEN -- Edit 

		RETURN QUERY
		SELECT
			 '000'::VARCHAR													AS ResponseCode
			,'SUCCESS'::VARCHAR												AS ResponseString
			,"ApplicationID"												AS ApplicationID
			,"ApplicationName"												AS ApplicationName
			,"ApplicationCode"												AS ApplicationCode
			,IIF(LA."IsDisabled" IS TRUE,'Active','InActive')::VARCHAR 	AS Status
			,TO_CHAR("UpdatedOn",'DD/MM/YYYY HH12:MM:SS AM')::VARCHAR 		AS RequestDate
			,"UpdatedByUserName" 											AS RequestUserName
		FROM 
			"LKP"."Application" LA
		WHERE
			1 = 1
			AND LA."ApplicationID" = "@ApplicationID"
		ORDER BY LA."ApplicationName" ASC;
	
	END IF;

	IF "@FlagID" = 3 THEN -- Save 

		IF NOT EXISTS (SELECT 1 FROM "LKP"."Application" WHERE 1 = 1  AND ("ApplicationName" ILIKE "@ApplicationName" OR "ApplicationCode" ILIKE "@ApplicationCode") LIMIT 1) THEN

				INSERT
					INTO "LKP"."Application"
				(
					 "IsDisabled"			
					,"CreatedOn"			
					,"CreatedByUserName"	
					,"UpdatedOn"			
					,"UpdatedByUserName"	
					,"ApplicationName"				
					,"ApplicationCode"		
				)
				VALUES
				(
					 "@IsDisabled"			
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RequestDate"			
					,"@RequestUserName"
					,"@ApplicationName"				
					,"@ApplicationCode"	
				);		

				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Saved Successfully...!'::VARCHAR		AS ResponseString
					,0::SMALLINT							AS ApplicationID
					,''::VARCHAR 							AS ApplicationName
					,''::VARCHAR							AS ApplicationCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		ELSE
			
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS ApplicationID
					,''::VARCHAR 							AS ApplicationName
					,''::VARCHAR							AS ApplicationCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		END IF;

	END IF;


	IF "@FlagID" = 4 THEN -- Update 

		IF EXISTS (SELECT 1 FROM "LKP"."Application" WHERE 1 = 1 AND "ApplicationID" = "@ApplicationID") THEN 
						

			IF NOT EXISTS (SELECT 1 FROM "LKP"."Application" WHERE 1 = 1 AND "ApplicationID" != "@ApplicationID" AND ("ApplicationName" ILIKE "@ApplicationName" OR "ApplicationCode" ILIKE "@ApplicationCode") LIMIT 1) THEN 

				UPDATE
					"LKP"."Application" 
				SET
					"ApplicationName" 		= "@ApplicationName" 
					,"ApplicationCode" 		= "@ApplicationCode" 
					,"IsDisabled"			= "@IsDisabled"
					,"UpdatedOn"			= "@RequestDate"
					,"UpdatedByUserName"	= "@RequestUserName"
				WHERE
					1 = 1
					AND "ApplicationID" = "@ApplicationID";
				
		
				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Updated Successfully...!'::VARCHAR	AS ResponseString
					,"@ApplicationID"::SMALLINT				AS ApplicationID
					,''::VARCHAR 							AS ApplicationName
					,''::VARCHAR							AS ApplicationCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			ELSE
				
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS ApplicationID
					,''::VARCHAR 							AS ApplicationName
					,''::VARCHAR							AS ApplicationCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			END IF;

		ELSE
			
			RETURN QUERY
			SELECT
				 '-101'::VARCHAR						AS ResponseCode
				,'Does Not Exists'::VARCHAR				AS ResponseString
				,0::SMALLINT							AS ApplicationID
				,''::VARCHAR 							AS ApplicationName
				,''::VARCHAR							AS ApplicationCode
				,''::VARCHAR 							AS Status
				,''::VARCHAR							AS RequestDate
				,''::VARCHAR							AS RequestUserName;
	
		END IF;

	 END IF;


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			 "@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
 �   DROP FUNCTION "STORE"."AddApplication"("@FlagID" smallint, "@ApplicationID" smallint, "@ApplicationName" character varying, "@ApplicationCode" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying);
       STORE          postgres    false    26            o           1255    17328 u   AddApplicationFeature(smallint, smallint, smallint, character varying, character varying, boolean, character varying)    FUNCTION     �+  CREATE FUNCTION "STORE"."AddApplicationFeature"("@FlagID" smallint, "@ApplicationID" smallint, "@ApplicationFeatureID" smallint, "@ApplicationFeatureName" character varying, "@ApplicationFeatureCode" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "ApplicationFeatureID" smallint, "ApplicationFeatureName" character varying, "ApplicationFeatureCode" character varying, "Status" character varying, "ApplicationName" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."AddApplicationFeature"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."AddApplicationFeature"(FlagID,ApplicationID,ApplicationFeatureID,ApplicationFeatureName,ApplicationFeatureCode,IsDisabled,RequestUserName)
					SELECT * FROM "STORE"."AddApplicationFeature"(2,1,'','','',FALSE,'')

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-11					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/


	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.AddApplicationFeature';
	"@ExecutionObjectName" 		= 'LKP.ApplicationFeature';
	"@StepDescription" 			= 'Application Feature Creation';
	"@Request"					= CONCAT_WS(',',"@FlagID","@ApplicationID","@ApplicationFeatureID","@ApplicationFeatureName","@ApplicationFeatureCode","@IsDisabled","@RequestUserName");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();

 					
		

	"@RequestDate"				= NOW();
	"@RequestUserName"			= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);
	"@ApplicationFeatureName"	= INITCAP("@ApplicationFeatureName");
	"@ApplicationFeatureCode" 	= UPPER("@ApplicationFeatureCode");
	
	


	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================
	
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================


	IF "@FlagID" = 1 THEN --For Application DropDown

		RETURN QUERY
		SELECT
			 '000'::VARCHAR				AS ResponseCode
			,'SUCCESS'::VARCHAR			AS ResponseString
			,"ApplicationID"			AS ApplicationFeatureID
			,"ApplicationName"			AS ApplicationFeatureName
			,''::VARCHAR				AS ApplicationFeatureCode 
			,''::VARCHAR				AS ApplicationName 
			,''::VARCHAR 				AS Status
			,''::VARCHAR 				AS RequestDate
			,''::VARCHAR				AS RequestUserName
		FROM 
			"LKP"."Application" LA
		WHERE
			1 = 1
		ORDER BY "ApplicationName" ASC;
	
	END IF;


	IF "@FlagID" = 2 THEN --For Application Feature DopDown

		RETURN QUERY
		SELECT
			 '000'::VARCHAR					AS ResponseCode
			,'SUCCESS'::VARCHAR				AS ResponseString
			,"ApplicationFeatureID"			AS ApplicationFeatureID
			,"ApplicationFeatureName"		AS ApplicationFeatureName
			,''::VARCHAR					AS ApplicationFeatureCode 
			,''::VARCHAR 					AS Status
			,''::VARCHAR					AS ApplicationName
			,''::VARCHAR 					AS RequestDate
			,''::VARCHAR					AS RequestUserName
		FROM 
			"LKP"."ApplicationFeature" LAF
		WHERE
			1 = 1
			AND LAF."ApplicationID" = "@ApplicationID"
		ORDER BY "ApplicationFeatureName" ASC;
	
	END IF;


	IF "@FlagID" = 3 THEN -- Edit 

		RETURN QUERY
		SELECT
			 '000'::VARCHAR					AS ResponseCode
			,'SUCCESS'::VARCHAR				AS ResponseString
			,"ApplicationFeatureID"			AS ApplicationFeatureID
			,"ApplicationFeatureName"		AS ApplicationFeatureName
			,''::VARCHAR					AS ApplicationFeatureCode 
			,''::VARCHAR 					AS Status
			,''::VARCHAR					AS ApplicationName
			,''::VARCHAR 					AS RequestDate
			,''::VARCHAR					AS RequestUserName
		FROM 
			"LKP"."ApplicationFeature" LAF
		WHERE
			1 = 1
			AND LAF."ApplicationID" = "@ApplicationID"
			AND LAF."ApplicationFeature_ID" = "@ApplicationFeatureID"
		ORDER BY "ApplicationFeatureName" ASC;
	
	END IF;

	IF "@FlagID" = 4 THEN -- Save 

		IF NOT EXISTS (SELECT 1 FROM "LKP"."ApplicationFeature" WHERE 1 = 1 AND "ApplicationFeatureID" = "@ApplicationFeatureID" AND ("ApplicationFeatureName" ILIKE "@ApplicationFeatureName" OR "ApplicationFeatureCode" ILIKE "@ApplicationFeatureCode") LIMIT 1) THEN

				INSERT
					INTO "LKP"."ApplicationFeature"
				(
					 "IsDisabled"			
					,"CreatedOn"			
					,"CreatedByUserName"	
					,"UpdatedOn"			
					,"UpdatedByUserName"	
					,"ApplicationID"
					,"ApplicationFeatureName"				
					,"ApplicationFeatureCode"		
				)
				VALUES
				(
					 "@IsDisabled"			
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RequestDate"			
					,"@RequestUserName"
					,"@ApplicationID"
					,"@ApplicationFeatureName"				
					,"@ApplicationFeatureCode"	
				);		

				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Saved Successfully...!'::VARCHAR		AS ResponseString
					,0::SMALLINT							AS ApplicationFeatureID
					,''::VARCHAR 							AS ApplicationFeatureName
					,''::VARCHAR							AS ApplicationFeatureCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS ApplicationName
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		ELSE
			
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS ApplicationFeatureID
					,''::VARCHAR 							AS ApplicationFeatureName
					,''::VARCHAR							AS ApplicationFeatureCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS ApplicationName
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		END IF;

	END IF;


	IF "@FlagID" = 5 THEN -- Update 

		IF EXISTS (SELECT 1 FROM "LKP"."ApplicationFeature" WHERE 1 = 1 AND "ApplicationID" = "@ApplicationID" AND "ApplicationFeatureID" = "@ApplicationFeatureID") THEN 
						

			IF NOT EXISTS (SELECT 1 FROM "LKP"."ApplicationFeature" WHERE 1 = 1 AND "ApplicationID" = "@ApplicationID" AND "ApplicationFeatureID" != "@ApplicationFeatureID" AND ("ApplicationFeatureName" ILIKE "@ApplicationFeatureName" OR "ApplicationFeatureCode" ILIKE "@ApplicationFeatureCode") LIMIT 1) THEN 

				UPDATE
					"LKP"."ApplicationFeature" 
				SET
					"ApplicationFeatureName" 	= "@ApplicationFeatureName" 
					,"ApplicationFeatureCode" 	= "@ApplicationFeatureCode" 
					,"IsDisabled"				= "@IsDisabled"
					,"UpdatedOn"				= "@RequestDate"
					,"UpdatedByUserName"		= "@RequestUserName"
				WHERE
					1 = 1
					AND "ApplicationID" = "@ApplicationID"
					AND "ApplicationFeatureID" = "@ApplicationFeatureID";
				
		
				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Updated Successfully...!'::VARCHAR	AS ResponseString
					,0::SMALLINT							AS ApplicationFeatureID
					,''::VARCHAR 							AS ApplicationFeatureName
					,''::VARCHAR							AS ApplicationFeatureCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS ApplicationName
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			ELSE
				
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS ApplicationFeatureID
					,''::VARCHAR 							AS ApplicationFeatureName
					,''::VARCHAR							AS ApplicationFeatureCode
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS ApplicationName
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			END IF;

		ELSE
			
			RETURN QUERY
			SELECT
				 '-101'::VARCHAR						AS ResponseCode
				,'Does Not Exists'::VARCHAR				AS ResponseString
				,0::SMALLINT							AS ApplicationFeatureID
				,''::VARCHAR 							AS ApplicationFeatureName
				,''::VARCHAR							AS ApplicationFeatureCode
				,''::VARCHAR 							AS Status
				,''::VARCHAR							AS ApplicationName
				,''::VARCHAR							AS RequestDate
				,''::VARCHAR							AS RequestUserName;
	
		END IF;

	 END IF;


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			 "@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
   DROP FUNCTION "STORE"."AddApplicationFeature"("@FlagID" smallint, "@ApplicationID" smallint, "@ApplicationFeatureID" smallint, "@ApplicationFeatureName" character varying, "@ApplicationFeatureCode" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying);
       STORE          postgres    false    26            p           1255    17330 �   AddGeographyType(smallint, smallint, smallint, character varying, character varying, character varying, smallint, boolean, character varying)    FUNCTION     p,  CREATE FUNCTION "STORE"."AddGeographyType"("@FlagID" smallint, "@CountryID" smallint, "@GeographyTypeID" smallint, "@GeographyTypeName" character varying, "@GeographyTypeCode" character varying, "@GeographyTypeDescription" character varying, "@ParentGeographyTypeID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "GeographyTypeID" smallint, "GeographyTypeName" character varying, "GeographyTypeCode" character varying, "GeographyTypeDescription" character varying, "ParentGeographyType" character varying, "Status" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."AddGeographyType"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."AddGeographyType"("@FlagID","@CountryID","@GeographyTypeID","@GeographyTypeName","@GeographyTypeCode","@GeographyTypeDescription","@ParentGeographyTypeID","@IsDisabled","@RequestUserName")
					SELECT * FROM "STORE"."AddGeographyType"()

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-10					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/

		
	
	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.AddGeographyType';
	"@ExecutionObjectName" 		= 'LKP.GeographyType';
	"@StepDescription" 			= '';
	"@Request"					= CONCAT_WS(',',"@FlagID","@CountryID","@GeographyTypeID","@GeographyTypeName","@GeographyTypeCode","@GeographyTypeDescription","@ParentGeographyTypeID","@IsDisabled","@RequestUserName");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();
	"@RequestDate"				= NOW();
	"@RequestUserName"			= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);
 					
		



	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================

	"@GeographyTypeName" 		= INITCAP("@GeographyTypeName");	
	"@GeographyTypeCode"		= UPPER("@GeographyTypeCode");		
	"@GeographyTypeDescription"	= INITCAP("@GeographyTypeDescription");
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================

	IF "@FlagID" = 1 THEN  -- For Country Drop Down

		RETURN QUERY
		SELECT
			'000'::VARCHAR			AS ResponseCode
			,'SUCCESS'::VARCHAR		AS ResponseString
			,"CountryID"			AS CountryID
			,"CountryName"			AS CountryName
			,''::VARCHAR			AS CountryCode
			,''::VARCHAR			AS CountryDescription
			,''::VARCHAR			AS ParentCountry
			,''::VARCHAR			AS Status
			,''::VARCHAR			AS RequestDate
			,''::VARCHAR			AS RequestUserName
		FROM 						
			"LKP"."Country" LC
		WHERE
			1 = 1
			AND LC."IsDisabled" IS FALSE
		ORDER BY LC."CountryCode" ASC;
	
	END IF;

	IF "@FlagID" = 2 THEN  -- For View

		RETURN QUERY
		SELECT
			'000'::VARCHAR						AS ResponseCode
			,'SUCCESS'::VARCHAR					AS ResponseString
			,LGT."GeographyTypeID"				AS GeographyTypeID
			,LGT."GeographyTypeName"			AS GeographyTypeName
			,LGT."GeographyTypeCode"			AS GeographyTypeCode
			,LGT."GeographyTypeDescription"	AS GeographyTypeDescription
			,PLGT."GeographyTypeName"			AS ParentGeographyTypeName
			,''::VARCHAR 						AS Status
			,''::VARCHAR 						AS RequestDate
			,''::VARCHAR						AS RequestUserName
		FROM 
			"LKP"."GeographyType" LGT
			LEFT JOIN "LKP"."GeographyType" PLGT
				ON PLGT."ParentGeographyTypeID" = LGT."GeographyTypeID"
		WHERE
			1 = 1
			AND LGT."CountryID" = "@CountryID"
		ORDER BY LGT."GeographyTypeCode" ASC;
	
	END IF;

	
	IF "@FlagID" = 3 THEN  -- For GeographyType DopDown 

		RETURN QUERY
		SELECT
			'000'::VARCHAR				AS ResponseCode
			,'SUCCESS'::VARCHAR			AS ResponseString
			,"GeographyTypeID"			AS GeographyTypeID
			,"GeographyTypeName"		AS GeographyTypeName
			,''::VARCHAR				AS GeographyTypeCode
			,''::VARCHAR				AS GeographyTypeDescription
			,''::VARCHAR				AS ParentGeographyTypeName
			,''::VARCHAR 				AS Status
			,''::VARCHAR 				AS RequestDate
			,''::VARCHAR				AS RequestUserName
		FROM 
			"LKP"."GeographyType" LGT
		WHERE
			1 = 1
			AND LGT."CountryID" = "@CountryID"
		ORDER BY "GeographyTypeCode" ASC;
	
	END IF;


	IF "@FlagID" = 4 THEN -- For GeographyType Insert

		IF NOT EXISTS (SELECT 1 FROM "LKP"."GeographyType" LGT WHERE 1 = 1 AND LGT."CountryID" = "@CountryID" AND LGT."GeographyTypeCode" LIKE "@GeographyTypeCode" LIMIT 1) THEN 
			
			INSERT
				INTO "LKP"."GeographyType"
			(
				 "IsDisabled"
				,"CreatedOn"
				,"CreatedByUserName"
				,"UpdatedOn"
				,"UpdatedByUserName"
				,"CountryID"
				,"GeographyTypeName"
				,"GeographyTypeCode"
				,"GeographyTypeDescription"
				,"ParentGeographyTypeID"
	
			)
			VALUES
			(
				"@IsDisabled"
				,"@RequestDate"
				,"@RequestUserName"
				,"@RequestDate"
				,"@RequestUserName"
				,"@CountryID"
				,"@GeographyTypeName"
				,"@GeographyTypeCode"
				,"@GeographyTypeDescription"
				,"@ParentGeographyTypeID"
			);

		RETURN QUERY
		SELECT
			'000'::VARCHAR				AS ResponseCode
			,'Saved Successfully'::VARCHAR	AS ResponseString
			,0::SMALLINT				AS GeographyTypeID
			,''::VARCHAR				AS GeographyTypeName
			,''::VARCHAR				AS GeographyTypeCode
			,''::VARCHAR				AS GeographyTypeDescription
			,''::VARCHAR				AS ParentGeographyTypeName
			,''::VARCHAR 				AS Status
			,''::VARCHAR 				AS RequestDate
			,''::VARCHAR				AS RequestUserName;
	
		ELSE

			RETURN QUERY
			SELECT
				'-101'::VARCHAR				AS ResponseCode
				,'Already Exists'::VARCHAR	AS ResponseString
				,0::SMALLINT				AS GeographyTypeID
				,''::VARCHAR				AS GeographyTypeName
				,''::VARCHAR				AS GeographyTypeCode
				,''::VARCHAR				AS GeographyTypeDescription
				,''::VARCHAR				AS ParentGeographyTypeName
				,''::VARCHAR 				AS Status
				,''::VARCHAR 				AS RequestDate
				,''::VARCHAR				AS RequestUserName;

		END IF;
	
	END IF;
	
	
	IF "@FlagID" = 5 THEN  -- For GeographyType Edit 

		IF EXISTS (SELECT 1 FROM "LKP"."GeographyType" LGT WHERE 1 = 1 AND LGT."CountryID" = "@CountryID" AND LGT."GeographyTypeID" = "@GeographyTypeID" LIMIT 1) THEN 
			IF NOT EXISTS (SELECT 1 FROM "LKP"."GeographyType" LGT WHERE 1 = 1 AND LGT."CountryID" = "@CountryID" AND LGT."GeographyTypeID" != "@GeographyTypeID" AND LGT."GeographyTypeCode" LIKE "@GeographyTypeCode" LIMIT 1) THEN 

				UPDATE
					"LKP"."GeographyType" LGT
				SET
					 "GeographyTypeName"		= "@GeographyTypeName"
					,"GeographyTypeCode"		= "@GeographyTypeCode"
					,"GeographyTypeDescription"	= "@GeographyTypeDescription"
					,"ParentGeographyTypeID"	= "@ParentGeographyTypeID"
				WHERE
					1 = 1
					AND LGT."GeographyTypeID" = "@GeographyTypeID";

				RETURN QUERY
				SELECT
					'000'::VARCHAR						AS ResponseCode
					,'Updated Successfully'::VARCHAR	AS ResponseString
					,0::SMALLINT				AS GeographyTypeID
					,''::VARCHAR				AS GeographyTypeName
					,''::VARCHAR				AS GeographyTypeCode
					,''::VARCHAR				AS GeographyTypeDescription
					,''::VARCHAR				AS ParentGeographyTypeName
					,''::VARCHAR 				AS Status
					,''::VARCHAR 				AS RequestDate
					,''::VARCHAR				AS RequestUserName;
	
			ELSE

					RETURN QUERY
					SELECT
						'-101'::VARCHAR			AS ResponseCode
						,'Already Exists'::VARCHAR	AS ResponseString
						,0::SMALLINT			AS GeographyTypeID
						,''::VARCHAR			AS GeographyTypeName
						,''::VARCHAR			AS GeographyTypeCode
						,''::VARCHAR			AS GeographyTypeDescription
						,''::VARCHAR			AS ParentGeographyTypeName
						,''::VARCHAR 			AS Status
						,''::VARCHAR 			AS RequestDate
						,''::VARCHAR			AS RequestUserName;
			END IF;
	
	
		ELSE

			RETURN QUERY
			SELECT
				'-101'::VARCHAR				AS ResponseCode
				,'Does Not Exists'::VARCHAR	 AS ResponseString
				,0::SMALLINT			AS GeographyTypeID
				,''::VARCHAR			AS GeographyTypeName
				,''::VARCHAR			AS GeographyTypeCode
				,''::VARCHAR			AS GeographyTypeDescription
				,''::VARCHAR			AS ParentGeographyTypeName
				,''::VARCHAR 			AS Status
				,''::VARCHAR 			AS RequestDate
				,''::VARCHAR			AS RequestUserName;
	
		END IF;
	END IF;
	


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			 "@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
 Q  DROP FUNCTION "STORE"."AddGeographyType"("@FlagID" smallint, "@CountryID" smallint, "@GeographyTypeID" smallint, "@GeographyTypeName" character varying, "@GeographyTypeCode" character varying, "@GeographyTypeDescription" character varying, "@ParentGeographyTypeID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying);
       STORE          postgres    false    26            ^           1255    17332 �   AddLocationType(smallint, smallint, smallint, smallint, character varying, character varying, character varying, smallint, boolean, character varying, integer)    FUNCTION     �/  CREATE FUNCTION "STORE"."AddLocationType"("@FlagID" smallint, "@CountryID" smallint, "@ClientID" smallint, "@LocationTypeID" smallint, "@LocationTypeName" character varying, "@LocationTypeCode" character varying, "@LocationTypeDescription" character varying, "@ParentLocationTypeID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying, "@UserID" integer) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "LocationTypeID" smallint, "LocationTypeName" character varying, "LocationTypeCode" character varying, "LocationDescription" character varying, "ParentLocationType" character varying, "Status" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."AddGeographyType"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."AddLocationType"("@FlagID","@CountryID","@ClientID","@LocationTypeID","@LocationTypeName","@LocationTypeCode","@LocationTypeDescription","@ParentLocationTypeID","@IsDisabled","@RequestUserName","@UserID")
					SELECT * FROM "STORE"."AddLocationType"()

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-10					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/

		
	
	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.AddLocationType';
	"@ExecutionObjectName" 		= 'LKP.LocationType';
	"@StepDescription" 			= '';
	"@Request"					= CONCAT_WS(',',"@FlagID","@CountryID","@ClientID","@LocationTypeID","@LocationTypeName","@LocationTypeCode","@LocationTypeDescription","@ParentLocationTypeID","@IsDisabled","@RequestUserName");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();
	"@RequestDate"				= NOW();
	"@RequestUserName"			= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);
 					
		



	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================

	"@LocationTypeName" 		= INITCAP("@LocationTypeName");	
	"@LocationTypeCode"			= UPPER("@LocationTypeCode");		
	"@LocationTypeDescription"	= INITCAP("@LocationTypeDescription");
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================

	IF "@FlagID" = 1 THEN  -- For Country Drop Down

		RETURN QUERY
		SELECT
			'000'::VARCHAR			AS ResponseCode
			,'SUCCESS'::VARCHAR		AS ResponseString
			,"CountryID"			AS CountryID
			,"CountryName"			AS CountryName
			,''::VARCHAR			AS CountryCode
			,''::VARCHAR			AS CountryDescription
			,''::VARCHAR			AS ParentCountry
			,''::VARCHAR			AS Status
			,''::VARCHAR			AS RequestDate
			,''::VARCHAR			AS RequestUserName
		FROM 						
			"LKP"."Country" LC
		WHERE
			1 = 1
			AND LC."IsDisabled" IS FALSE
		ORDER BY LC."CountryCode" ASC;
	
	END IF;

	IF "@FlagID" = 2 THEN  -- For Client Drop Down

		RETURN QUERY
		SELECT
			'000'::VARCHAR			AS ResponseCode
			,'SUCCESS'::VARCHAR		AS ResponseString
			,C."ClientID"			AS ClientID
			,C."ClientName"			AS ClientName
			,''::VARCHAR			AS ClientCode
			,''::VARCHAR			AS ClientDescription
			,''::VARCHAR			AS ParentClient
			,''::VARCHAR			AS Status
			,''::VARCHAR			AS RequestDate
			,''::VARCHAR			AS RequestUserName
		FROM 						
			"DATA"."Client" C
		WHERE
			1 = 1
			AND C."CountryID" = "@CountryID"
			AND C."IsDisabled" IS FALSE
		ORDER BY C."ClientName" ASC;
	
	END IF;
	
	IF "@FlagID" = 3 THEN  -- For View

		RETURN QUERY
		SELECT
			'000'::VARCHAR						AS ResponseCode
			,'SUCCESS'::VARCHAR					AS ResponseString
			,LCT."LocationTypeID"				AS LocationTypeID
			,LCT."LocationTypeName"				AS LocationTypeName
			,LCT."LocationTypeCode"				AS LocationTypeCode
			,LCT."LocationTypeDescription"		AS LocationDescription
			,PLCT."LocationTypeName"			AS ParentLocationTypeName
			,''::VARCHAR 						AS Status
			,''::VARCHAR 						AS RequestDate
			,''::VARCHAR						AS RequestUserName
		FROM 
			"LKP"."LocationType" LCT
			LEFT JOIN "LKP"."LocationType" PLCT
				ON PLCT."ParentLocationTypeID" = LCT."LocationTypeID"
		WHERE
			1 = 1
			AND LCT."CountryID" = "@CountryID"
			AND LCT."ClientID" = "@ClientID"
		ORDER BY LCT."LocationTypeCode" ASC;
	
	END IF;

	
	IF "@FlagID" = 4 THEN  -- For GeographyType DopDown 

		RETURN QUERY
		SELECT
			'000'::VARCHAR				AS ResponseCode
			,'SUCCESS'::VARCHAR			AS ResponseString
			,LCT."LocationTypeID"		AS LocationTypeID
			,LCT."LocationTypeName"		AS LocationTypeName
			,''::VARCHAR				AS LocationTypeCode
			,''::VARCHAR				AS LocationTypeDescription
			,''::VARCHAR				AS ParentLocationTypeName
			,''::VARCHAR 				AS Status
			,''::VARCHAR 				AS RequestDate
			,''::VARCHAR				AS RequestUserName
		FROM 
			"LKP"."LocationType" LCT
		WHERE
			1 = 1
			AND LCT."CountryID" = "@CountryID"
			AND LCT."ClientID" = "@ClientID"
		ORDER BY "GeographyTypeCode" ASC;
	
	END IF;


	IF "@FlagID" = 5 THEN -- For LocationType Insert

		IF NOT EXISTS (SELECT 1 FROM "LKP"."LocationType" LCT WHERE 1 = 1 AND LCT."CountryID" = "@CountryID" AND LCT."ClientID" = "@ClientID" AND LCT."LocationTypeCode" LIKE "@LocationTypeCode" LIMIT 1) THEN 
			
			INSERT
				INTO "LKP"."LocationType"
			(
				 "IsDisabled"
				,"CreatedOn"
				,"CreatedByUserName"
				,"UpdatedOn"
				,"UpdatedByUserName"
				,"CountryID"
				,"ClientID"
				,"LocationTypeName"
				,"LocationTypeCode"
				,"LocationTypeDescription"
				,"ParentLocationTypeID"
	
			)
			VALUES
			(
				"@IsDisabled"
				,"@RequestDate"
				,"@RequestUserName"
				,"@RequestDate"
				,"@RequestUserName"
				,"@CountryID"
				,"@ClientID"
				,"@LocationTypeName"
				,"@LocationTypeCode"
				,"@LocationTypeDescription"
				,"@ParentLocationTypeID"
			);

		RETURN QUERY
		SELECT
			'000'::VARCHAR					AS ResponseCode
			,'Saved Successfully'::VARCHAR	AS ResponseString
			,0::SMALLINT					AS LocationTypeID
			,''::VARCHAR					AS LocationTypeName
			,''::VARCHAR					AS LocationTypeCode
			,''::VARCHAR					AS LocationTypeDescription
			,''::VARCHAR					AS ParentLocationTypeName
			,''::VARCHAR 					AS Status
			,''::VARCHAR 					AS RequestDate
			,''::VARCHAR					AS RequestUserName;
	
		ELSE

			RETURN QUERY
			SELECT
				'-101'::VARCHAR				AS ResponseCode
				,'Already Exists'::VARCHAR	AS ResponseString
				,0::SMALLINT				AS LocationTypeID
				,''::VARCHAR				AS LocationTypeName
				,''::VARCHAR				AS LocationTypeCode
				,''::VARCHAR				AS LocationTypeDescription
				,''::VARCHAR				AS ParentLocationTypeName
				,''::VARCHAR 				AS Status
				,''::VARCHAR 				AS RequestDate
				,''::VARCHAR				AS RequestUserName;

		END IF;
	
	END IF;
	
	
	IF "@FlagID" = 6 THEN  -- For LocationType Edit 

		IF EXISTS (SELECT 1 FROM "LKP"."LocationType" LCT WHERE 1 = 1 AND LCT."CountryID" = "@CountryID" AND LCT."ClientID" = "@ClientID" AND LCT."LocationTypeID" = "@LocationTypeID" LIMIT 1) THEN 
			IF NOT EXISTS (SELECT 1 FROM "LKP"."LocationType" LCT WHERE 1 = 1 AND LCT."CountryID" = "@CountryID" AND LCT."ClientID" = "@ClientID" AND LCT."LocationTypeID" != "@LocationTypeID" AND LCT."LocationTypeCode" LIKE "@LocationTypeCode" LIMIT 1) THEN 

				UPDATE
					"LKP"."LocationType" LCT
				SET
					 "LocationTypeName"			= "@LocationTypeName"
					,"LocationTypeCode"			= "@LocationTypeCode"
					,"LocationTypeDescription"	= "@LocationTypeDescription"
					,"ParentLocationTypeID"		= "@ParentLocationTypeID"
				WHERE
					1 = 1
					AND LCT."LocationTypeID" = "@LocationTypeID";

				RETURN QUERY
				SELECT
					'000'::VARCHAR						AS ResponseCode
					,'Updated Successfully'::VARCHAR	AS ResponseString
					,0::SMALLINT						AS LocationTypeID
					,''::VARCHAR						AS LocationTypeName
					,''::VARCHAR						AS LocationTypeCode
					,''::VARCHAR						AS LocationTypeDescription
					,''::VARCHAR						AS ParentLocationTypeName
					,''::VARCHAR 						AS Status
					,''::VARCHAR 						AS RequestDate
					,''::VARCHAR						AS RequestUserName;
	
			ELSE

					RETURN QUERY
					SELECT
						'-101'::VARCHAR				AS ResponseCode
						,'Already Exists'::VARCHAR	AS ResponseString
						,0::SMALLINT				AS LocationTypeID
						,''::VARCHAR				AS LocationTypeName
						,''::VARCHAR				AS LocationTypeCode
						,''::VARCHAR				AS LocationTypeDescription
						,''::VARCHAR				AS ParentLocationTypeName
						,''::VARCHAR 				AS Status
						,''::VARCHAR 				AS RequestDate
						,''::VARCHAR				AS RequestUserName;
			END IF;
	
	
		ELSE

			RETURN QUERY
			SELECT
				'-101'::VARCHAR					AS ResponseCode
				,'Does Not Exists'::VARCHAR		AS ResponseString
				,0::SMALLINT					AS LocationTypeID
				,''::VARCHAR					AS LocationTypeName
				,''::VARCHAR					AS LocationTypeCode
				,''::VARCHAR					AS LocationTypeDescription
				,''::VARCHAR					AS ParentLocationTypeName
				,''::VARCHAR 					AS Status
				,''::VARCHAR 					AS RequestDate
				,''::VARCHAR					AS RequestUserName;
	
		END IF;
	
	END IF;
	


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			 "@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
 t  DROP FUNCTION "STORE"."AddLocationType"("@FlagID" smallint, "@CountryID" smallint, "@ClientID" smallint, "@LocationTypeID" smallint, "@LocationTypeName" character varying, "@LocationTypeCode" character varying, "@LocationTypeDescription" character varying, "@ParentLocationTypeID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying, "@UserID" integer);
       STORE          postgres    false    26            q           1255    19068 p   AddRole(smallint, smallint, character varying, character varying, character varying, boolean, character varying)    FUNCTION     h#  CREATE FUNCTION "STORE"."AddRole"("@FlagID" smallint, "@RoleID" smallint, "@RoleName" character varying, "@RoleCode" character varying, "@RoleDescription" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "RoleID" smallint, "RoleName" character varying, "RoleCode" character varying, "RoleDescription" character varying, "Status" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."AddRole"
Create Date		:   2024-Apr-03
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."AddRole"(FlagID,'RoleID','RoleName','RoleCode','RoleDescription',Boolean,'LoginUser')
					SELECT * FROM "STORE"."AddRole"(2,1,'','','',FALSE,'')

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-03					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/


	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.AddRole';
	"@ExecutionObjectName" 		= 'LKP.Role';
	"@StepDescription" 			= 'Role Creation';
	"@Request"					= CONCAT_WS(',',"@FlagID","@RoleID","@RoleName","@RoleCode","@RoleDescription","@IsDisabled");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();

 					
		

	"@RequestDate"			= NOW();
	"@RequestUserName"		= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);
	"@RoleName"				= INITCAP("@RoleName");
	"@RoleCode" 			= UPPER("@RoleCode");
	"@RoleDescription"		= INITCAP("@RoleDescription");
	
	


	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================
	
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================


	IF "@FlagID" = 1 THEN --View

		RETURN QUERY
		SELECT
			 '000'::VARCHAR													AS ResponseCode
			,'SUCCESS'::VARCHAR												AS ResponseString
			,"RoleID"														AS RoleID
			,"RoleName"														AS RoleName
			,"RoleCode"::VARCHAR											AS RoleCode 
			,"RoleDescription"::VARCHAR										AS RoleDescription
			,"IsDisabled"::VARCHAR 											AS IsDisabled
			,TO_CHAR("CreatedOn",'DD/MM/YYYY HH12:MM:SS AM')::VARCHAR		AS RequestDate
			,"CreatedByUserName"::VARCHAR									AS RequestUserName
		FROM 
			"LKP"."Role" LR
		WHERE
			1 = 1
		ORDER BY "RoleName" ASC;
	
	END IF;

	IF "@FlagID" = 2 THEN -- Save 

		IF NOT EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1  AND ("RoleName" ILIKE "@RoleName" OR "RoleCode" ILIKE "@RoleCode") LIMIT 1) THEN

				INSERT
					INTO "LKP"."Role"
				(
					 "IsDisabled"			
					,"CreatedOn"			
					,"CreatedByUserName"	
					,"UpdatedOn"			
					,"UpdatedByUserName"	
					,"RoleName"				
					,"RoleDescription"		
					,"RoleCode"		
				)
				VALUES
				(
					 "@IsDisabled"			
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RoleName"				
					,"@RoleDescription"		
					,"@RoleCode"	
				);		

				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Saved Successfully...!'::VARCHAR		AS ResponseString
					,0::SMALLINT							AS RoleID
					,''::VARCHAR 							AS RoleName
					,''::VARCHAR							AS RoleCode
					,''::VARCHAR							AS RoleDescription
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		ELSE
			
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS RoleID
					,''::VARCHAR 							AS RoleName
					,''::VARCHAR							AS RoleCode
					,''::VARCHAR							AS RoleDescription
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;

		END IF;

	END IF;


	IF "@FlagID" = 3 THEN -- Update 

		IF EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1 AND "RoleID" = "@RoleID") THEN 
						

			IF NOT EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1 AND "RoleID" != "@RoleID" AND ("RoleName" ILIKE "@RoleName" OR "RoleCode" ILIKE "@RoleCode") LIMIT 1) THEN 

				UPDATE
					"LKP"."Role" 
				SET
					"RoleName" 				= "@RoleName" 
					,"RoleCode" 			= "@RoleCode" 
					,"RoleDescription"		= "@RoleDescription"
					,"IsDisabled"			= "@IsDisabled"
					,"UpdatedOn"			= "@RequestDate"
					,"UpdatedByUserName"	= "@RequestUserName"
				WHERE
					1 = 1
					AND "RoleID" = "@RoleID";
				
		
				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS ResponseCode
					,'Updated Successfully...!'::VARCHAR	AS ResponseString
					,"@RoleID"::SMALLINT					AS RoleID
					,''::VARCHAR 							AS RoleName
					,''::VARCHAR							AS RoleCode
					,''::VARCHAR							AS RoleDescription
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			ELSE
				
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS ResponseCode
					,'AlreadyExists'::VARCHAR				AS ResponseString
					,0::SMALLINT							AS RoleID
					,''::VARCHAR 							AS RoleName
					,''::VARCHAR							AS RoleCode
					,''::VARCHAR							AS RoleDescription
					,''::VARCHAR 							AS Status
					,''::VARCHAR							AS RequestDate
					,''::VARCHAR							AS RequestUserName;



			END IF;

		ELSE
			
			RETURN QUERY
			SELECT
				 '-101'::VARCHAR						AS ResponseCode
				,'Does Not Exists'::VARCHAR				AS ResponseString
				,0::SMALLINT							AS RoleID
				,''::VARCHAR 							AS RoleName
				,''::VARCHAR							AS RoleCode
				,''::VARCHAR							AS RoleDescription
				,''::VARCHAR 							AS Status
				,''::VARCHAR							AS RequestDate
				,''::VARCHAR							AS RequestUserName;
	
		END IF;

	 END IF;


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			 "@ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
 �   DROP FUNCTION "STORE"."AddRole"("@FlagID" smallint, "@RoleID" smallint, "@RoleName" character varying, "@RoleCode" character varying, "@RoleDescription" character varying, "@IsDisabled" boolean, "@RequestUserName" character varying);
       STORE          postgres    false    26            _           1255    17336 M   ClientRoleAllocation(integer, smallint, smallint, boolean, character varying)    FUNCTION     �$  CREATE FUNCTION "STORE"."ClientRoleAllocation"("@FlagID" integer, "@ClientID" smallint, "@RoleID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying) RETURNS TABLE("ResponseCode" character varying, "ResponseString" character varying, "ClientID" smallint, "RoleID" smallint, "RoleCode" character varying, "RoleName" character varying, "Status" character varying, "RequestDate" character varying, "RequestUserName" character varying)
    LANGUAGE plpgsql
    AS $$
# variable_conflict use_column
DECLARE
	"@RequestDate"  		TIMESTAMP;

DECLARE
	"@ExecutionProcessName" 	VARCHAR;
	"@ExecutionObjectName" 		VARCHAR;
	"@StepDescription" 			VARCHAR;
	"@Request"					VARCHAR;
	"@ProcessDate"				DATE;
	"@StartTime"				TIME;
	"@EndTime"				  	TIME;
	"@PG_BackEnd_PID"			INT;

DECLARE
	 "@Returned_SQLState"			VARCHAR;	
	 "@PG_Datatype_Name"			VARCHAR;
	 "@Message_Text"				VARCHAR;
	 "@PG_Exception_Detail"			VARCHAR;
	 "@PG_Exception_Hint"			VARCHAR;
	 "@PG_Exception_Context"		VARCHAR;

BEGIN

/****************************************************************************************************************************************
Procedure		:   "STORE"."ClientRoleAllocation"
Create Date		:   2024-Apr-09
Author			:   eSoftDigital
Description		:    
Parameter(s)	:   @Parm1		- description and usage
                    @Parm2		- description and usage
					@Parm3		- description and usage

Usage			:	SELECT * FROM "STORE"."ClientRoleAllocation"(FlagID,'ClientID','RoleID','RoleCode','RoleDescription',Boolean,'LoginUser')
					SELECT * FROM "STORE"."ClientRoleAllocation"(2,1,'','','',FALSE,'')

*****************************************************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)		    Author					Requirement				Ticket No			Comments
----------------------		---------------------	----------------		-----------			-----------------------------------------
2024-04-03					DS (Dinesh)				Initial 				-					-

*******************************************************************************************************************************************/


	--=================================================================================================
		--------------------------------------- INITIAL VALUE ASSIGNING ----------------------------
	--=================================================================================================


	"@ExecutionProcessName" 	= 'STORE.ClientRoleAllocation';
	"@ExecutionObjectName" 		= 'XREF.ClientRole';
	"@StepDescription" 			= 'Role Creation';
	"@Request"					= CONCAT_WS(',',"@FlagID","@ClientID","@RoleID","@IsDisabled","@RequestUserName");
	"@ProcessDate"				= NOW();
	"@StartTime"				= NOW();
	"@PG_BackEnd_PID"			= PG_BackEnd_PID();

 					 			
	"@RequestDate"			= NOW();
	"@RequestUserName"		= COALESCE(NULLIF("@RequestUserName",''),CURRENT_USER);

	
	


	--=================================================================================================
	---------------------------------------- PRE DATA VALIDATION -----------------------------------
	--=================================================================================================
	
	
	--=================================================================================================
		---------------------------------------- BUSINESS LOGIC -----------------------------------
	--=================================================================================================


	IF "@FlagID" = 1 THEN --View

		RETURN QUERY
		SELECT
			 '000'::VARCHAR				AS "ResponseCode"
			,'SUCCESS'::VARCHAR			AS "ResponseString"
			,"RoleID"
			,"RoleName"
			,"RoleCode"
			,"RoleDescription"
			,TO_CHAR("UpdatedOn",'DD/MM/YYYY HH12:MM:SS AM')::VARCHAR AS RequestDate
			,"UpdatedByUserName" AS RequestUserName
			,IIF(LR."IsDisabled" IS TRUE,'Active','InActive')::VARCHAR AS "Status"
		FROM 
			"LKP"."Role" LR
		WHERE
			1 = 1
		ORDER BY "RoleName" ASC;
	
	END IF;


	IF "@FlagID" = 2 THEN -- Edit 

		RETURN QUERY
		SELECT
			 '000'::VARCHAR			AS "ResponseCode"
			,'SUCCESS'::VARCHAR			AS "ResponseString"
			,"RoleID"
			,"RoleName"
			,"RoleCode"
			,"RoleDescription"
			,TO_CHAR("UpdatedOn",'DD/MM/YYYY HH12:MM:SS AM')::VARCHAR AS RequestDate
			,"UpdatedByUserName" AS RequestUserName
			,IIF(LR."IsDisabled" IS TRUE,'Active','InActive')::VARCHAR AS "Status"
		FROM 
			"LKP"."Role" LR
		WHERE
			1 = 1
			AND LR."RoleID" = "@RoleID"
		ORDER BY "RoleName" ASC;
	
	END IF;

	IF "@FlagID" = 3 THEN -- Save 

		IF NOT EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1  AND ("RoleName" ILIKE "@RoleName" OR "RoleCode" ILIKE "@RoleCode") LIMIT 1) THEN

				INSERT
					INTO "LKP"."Role"
				(
					 "IsDisabled"			
					,"CreatedOn"			
					,"CreatedByUserName"	
					,"UpdatedOn"			
					,"UpdatedByUserName"	
					,"RoleName"				
					,"RoleDescription"		
					,"RoleCode"		
				)
				VALUES
				(
					 "@IsDisabled"			
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RequestDate"			
					,"@RequestUserName"
					,"@RoleName"				
					,"@RoleDescription"		
					,"@RoleCode"	
				);		

				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS "ResponseCode"
					,'Saved Successfully...!'::VARCHAR		AS "ResponseString"
					,0::INT 								AS "RoleID"
					,''::VARCHAR 							AS "RoleName"
					,''::VARCHAR							AS "RoleCode"
					,''::VARCHAR							AS "RoleDescription"
					,''::VARCHAR							AS "RequestDate"
					,''::VARCHAR							AS "RequestUserName"
					,''::VARCHAR 							AS "Status";
		ELSE
			
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS "ResponseCode"
					,'AlreadyExists'::VARCHAR				AS "ResponseString"
					,0::INT 								AS "RoleID"
					,''::VARCHAR 							AS "RoleName"
					,''::VARCHAR							AS "RoleCode"
					,''::VARCHAR							AS "RoleDescription"
					,''::VARCHAR							AS "RequestDate"
					,''::VARCHAR							AS "RequestUserName"
					,''::VARCHAR 							AS "Status";
		END IF;

	END IF;


	IF "@FlagID" = 4 THEN -- Update 

		IF EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1 AND "RoleID" = "@RoleID") THEN 
						

			IF NOT EXISTS (SELECT 1 FROM "LKP"."Role" WHERE 1 = 1 AND "RoleID" != "@RoleID" AND ("RoleName" ILIKE "@RoleName" OR "RoleCode" ILIKE "@RoleCode") LIMIT 1) THEN 

				UPDATE
					"LKP"."Role" 
				SET
					"RoleName" 				= "@RoleName" 
					,"RoleCode" 			= "@RoleCode" 
					,"RoleDescription"		= "@RoleDescription"
					,"IsDisabled"			= "@IsDisabled"
					,"UpdatedOn"			= "@RequestDate"
					,"UpdatedByUserName"	= "@RequestUserName"
				WHERE
					1 = 1
					AND "RoleID" = "@RoleID";
				
		
				RETURN QUERY
				SELECT
					 '000'::VARCHAR							AS "ResponseCode"
					,'Updated Successfully...!'::VARCHAR	AS "ResponseString"
					,"@RoleID"::INT 						AS "RoleID"
					,''::VARCHAR 							AS "RoleName"
					,''::VARCHAR							AS "RoleCode"
					,''::VARCHAR							AS "RoleDescription"
					,''::VARCHAR							AS "RequestDate"
					,''::VARCHAR							AS "RequestUserName"
					,''::VARCHAR 							AS "Status";


			ELSE
				
				RETURN QUERY
				SELECT
					 '-101'::VARCHAR						AS "ResponseCode"
					,'AlreadyExists'::VARCHAR				AS "ResponseString"
					,0::INT 								AS "RoleID"
					,''::VARCHAR 							AS "RoleName"
					,''::VARCHAR							AS "RoleCode"
					,''::VARCHAR							AS "RoleDescription"
					,''::VARCHAR							AS "RequestDate"
					,''::VARCHAR							AS "RequestUserName"
					,''::VARCHAR 							AS "Status";


			END IF;

		ELSE
			
			RETURN QUERY
			SELECT
				 '-101'::VARCHAR						AS "ResponseCode"
				,'Does Not Exists'::VARCHAR				AS "ResponseString"
				,0::INT 								AS "RoleID"
				,''::VARCHAR 							AS "RoleName"
				,''::VARCHAR							AS "RoleCode"
				,''::VARCHAR							AS "RoleDescription"
				,''::VARCHAR							AS "RequestDate"
				,''::VARCHAR							AS "RequestUserName"
				,''::VARCHAR 							AS "Status";
		END IF;

	 END IF;


	--=================================================================================================
		---------------------------------------- Execution Progress -----------------------------------
	--=================================================================================================

		"@EndTime" = CLOCK_TIMESTAMP();

		CALL "LOGS"."AddexecutionProgress" 
			  (
				"@ExecutionProcessName" 		
				,"@ExecutionObjectName" 			
				,"@StepDescription" 				
				,"@Request"						
				,"@ProcessDate"					
				,"@StartTime"				  	
				,"@EndTime"				  		
				,"@PG_BackEnd_PID"
				,"@RequestUserName"
			  );


	--=================================================================================================
		---------------------------------------- ErrorLog -----------------------------------
	--=================================================================================================

	EXCEPTION WHEN OTHERS THEN
	
		GET STACKED DIAGNOSTICS 
			 "@Returned_SQLState"		= RETURNED_SQLSTATE
			,"@Message_Text"			= MESSAGE_TEXT
			,"@PG_Exception_Detail"		= PG_EXCEPTION_DETAIL
			,"@PG_Exception_Hint"		= PG_EXCEPTION_HINT
			,"@PG_Exception_Context"	= PG_EXCEPTION_CONTEXT;

	CALL "LOGS"."DatabaseErrorLog"
		(
			"ExecutionProcessName"
			,"@PG_BackEnd_PID"		
			,"@Returned_SQLState"	
			,"@Message_Text"		
			,"@PG_Exception_Detail"	
			,"@PG_Exception_Hint"	
			,"@PG_Exception_Context"
			,"@RequestUserName" 	
		);


END
$$;
 �   DROP FUNCTION "STORE"."ClientRoleAllocation"("@FlagID" integer, "@ClientID" smallint, "@RoleID" smallint, "@IsDisabled" boolean, "@RequestUserName" character varying);
       STORE          postgres    false    26            `           1255    17338    iif(boolean, text, text)    FUNCTION        CREATE FUNCTION public.iif(condition boolean, true_result text, false_result text) RETURNS text
    LANGUAGE plpgsql
    AS $$
    BEGIN
     IF condition THEN
        RETURN true_result;
     ELSE
        RETURN false_result;
     END IF;
    END
    $$;
 R   DROP FUNCTION public.iif(condition boolean, true_result text, false_result text);
       public          postgres    false                       1259    17339    Configuration    TABLE        CREATE TABLE "CONFIG"."Configuration" (
    "ConfigurationID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ConfigurationName" character varying(500) NOT NULL,
    "ConfigurationDescription" character varying(500) NOT NULL,
    "ConfigurationCode" character varying(500) NOT NULL,
    "ConfigurationValue" character varying(500)
);
 %   DROP TABLE "CONFIG"."Configuration";
       CONFIG         heap    postgres    false    10                       1259    17345 !   Configuration_ConfigurationID_seq    SEQUENCE     �   ALTER TABLE "CONFIG"."Configuration" ALTER COLUMN "ConfigurationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "CONFIG"."Configuration_ConfigurationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            CONFIG          postgres    false    10    261                       1259    17346    Client    TABLE     �  CREATE TABLE "DATA"."Client" (
    "ClientID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "ClientName" character varying(500) NOT NULL,
    "ClientCode" character varying(500) NOT NULL,
    "ClientDescription" character varying(500) NOT NULL,
    "Logo" bytea,
    "ContactNumber" character varying(500) NOT NULL,
    "AlternateContactNumber" character varying(500),
    "MessengerNumber" character varying(500),
    "EmailAddress" character varying(500) NOT NULL,
    "AlternateEmailAddress" character varying(500),
    "GSTNo" character varying(500),
    "LoginName" character varying,
    "Password" character varying,
    "Longitude" double precision,
    "Latitude" double precision,
    "LocationCode" character varying(500) NOT NULL
);
    DROP TABLE "DATA"."Client";
       DATA         heap    postgres    false    11                       1259    17352    Client_ClientID_seq    SEQUENCE     �   ALTER TABLE "DATA"."Client" ALTER COLUMN "ClientID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "DATA"."Client_ClientID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            DATA          postgres    false    263    11            	           1259    17353 	   Geography    TABLE     w  CREATE TABLE "DATA"."Geography" (
    "GeographyID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "GeographyTypeID" smallint NOT NULL,
    "GeographyName" character varying(500) NOT NULL,
    "GeographyCode" character varying(500) NOT NULL,
    "GeographyDescription" character varying(500) NOT NULL,
    "PostalCode" character varying(500) NOT NULL,
    "ParentGeographyID" integer
);
    DROP TABLE "DATA"."Geography";
       DATA         heap    postgres    false    11            
           1259    17359    Geography_GeographyID_seq    SEQUENCE     �   ALTER TABLE "DATA"."Geography" ALTER COLUMN "GeographyID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "DATA"."Geography_GeographyID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            DATA          postgres    false    265    11                       1259    17360    Location    TABLE     5  CREATE TABLE "DATA"."Location" (
    "LocationID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "ClientID" integer NOT NULL,
    "LocationTypeID" smallint NOT NULL,
    "GeographyID" integer NOT NULL,
    "LocationName" character varying(500) NOT NULL,
    "LocationShortCode" character varying(500) NOT NULL,
    "AddressLine1" character varying(500) NOT NULL,
    "AddressLine2" character varying(500) NOT NULL,
    "AddressLine3" character varying(500) NOT NULL,
    "City" character varying(500) NOT NULL,
    "Locality" character varying(500) NOT NULL,
    "PostalCode" character varying(500) NOT NULL,
    "LocationImage" bytea,
    "Longitude" double precision,
    "Latitude" double precision,
    "LocationCode" character varying(500) NOT NULL,
    "ParentLocationID" integer,
    "HashValue" character varying NOT NULL
);
    DROP TABLE "DATA"."Location";
       DATA         heap    postgres    false    11                       1259    17366    LocationContactPerson    TABLE     =  CREATE TABLE "DATA"."LocationContactPerson" (
    "LocationContactPersonID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "LocationID" integer NOT NULL,
    "FirstName" character varying(500) NOT NULL,
    "MiddleName" character varying(500) NOT NULL,
    "LastName" character varying(500) NOT NULL,
    "GenderID" smallint NOT NULL,
    "EmailAddress" character varying(500),
    "AlternateEmailAddress" character varying(500),
    "ContactNumber" character varying(500),
    "AlternateContactNumber" character varying(500),
    "MessengerNumber" character varying(500),
    "IsPrimaryPerson" boolean DEFAULT false
);
 +   DROP TABLE "DATA"."LocationContactPerson";
       DATA         heap    postgres    false    11                       1259    17373 1   LocationContactPerson_LocationContactPersonID_seq    SEQUENCE       ALTER TABLE "DATA"."LocationContactPerson" ALTER COLUMN "LocationContactPersonID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "DATA"."LocationContactPerson_LocationContactPersonID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            DATA          postgres    false    268    11                       1259    17374    Location_LocationID_seq    SEQUENCE     �   ALTER TABLE "DATA"."Location" ALTER COLUMN "LocationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "DATA"."Location_LocationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            DATA          postgres    false    11    267                       1259    17375    User    TABLE     )  CREATE TABLE "DATA"."User" (
    "UserID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "HonorificID" smallint,
    "FirstName" character varying(500) NOT NULL,
    "MiddleName" character varying(500),
    "LastName" character varying(500),
    "DataOfBirth" date,
    "GenderD" smallint,
    "MaritalStatusID" smallint,
    "BloodGroupID" smallint,
    "HobbyID" character varying(500),
    "ClientID" smallint NOT NULL,
    "LoginName" character varying,
    "Password" character varying,
    "AttemptCount" smallint,
    "IsForcePasswordChange" boolean DEFAULT false NOT NULL,
    "PasswordLastChangedOn" timestamp without time zone,
    "PasswordExpiredOn" timestamp without time zone,
    "IsTempBlocked" boolean DEFAULT false,
    "IsBlocked" boolean DEFAULT false,
    "BlockedOn" timestamp without time zone,
    "UserProfileSettingID" integer
);
    DROP TABLE "DATA"."User";
       DATA         heap    postgres    false    11                       1259    17384    User_UserID_seq    SEQUENCE     �   ALTER TABLE "DATA"."User" ALTER COLUMN "UserID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "DATA"."User_UserID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            DATA          postgres    false    271    11                       1259    17385    DatabaseError    TABLE        CREATE TABLE "ERROR"."DatabaseError" (
    "DatabaseErrorID" bigint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ServerName" character varying(500),
    "DatabaseName" character varying(500),
    "ExecutionProcessName" character varying(500),
    "PG_BackEnd_PID" integer,
    "Returned_SQLState" character varying,
    "Message_Text" character varying,
    "PG_Exception_Detail" character varying,
    "PG_Exception_Hint" character varying,
    "PG_Exception_Context" character varying,
    "ApplicationName" character varying,
    "Version" character varying
);
 $   DROP TABLE "ERROR"."DatabaseError";
       ERROR         heap    postgres    false    13                       1259    17391 !   DatabaseError_DatabaseErrorID_seq    SEQUENCE     �   ALTER TABLE "ERROR"."DatabaseError" ALTER COLUMN "DatabaseErrorID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "ERROR"."DatabaseError_DatabaseErrorID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            ERROR          postgres    false    273    13                       1259    17392    FrontEndError    TABLE     �  CREATE TABLE "ERROR"."FrontEndError" (
    "FrontEndErrorID" bigint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "PageName" character varying(500),
    "Message" character varying
);
 $   DROP TABLE "ERROR"."FrontEndError";
       ERROR         heap    postgres    false    13                       1259    17398 !   FrontEndError_FrontEndErrorID_seq    SEQUENCE     �   ALTER TABLE "ERROR"."FrontEndError" ALTER COLUMN "FrontEndErrorID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "ERROR"."FrontEndError_FrontEndErrorID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            ERROR          postgres    false    275    13                       1259    17399    AccountType    TABLE     �  CREATE TABLE "LKP"."AccountType" (
    "AccountTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "AccountTypeName" character varying(500) NOT NULL,
    "AccountTypeCode" character varying(500) NOT NULL
);
     DROP TABLE "LKP"."AccountType";
       LKP         heap    postgres    false    22                       1259    17405    AccountType_AccountTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."AccountType" ALTER COLUMN "AccountTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."AccountType_AccountTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    277    22                       1259    17406    Application    TABLE     �  CREATE TABLE "LKP"."Application" (
    "ApplicationID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ApplicationName" character varying(500) NOT NULL,
    "ApplicationCode" character varying(500) NOT NULL
);
     DROP TABLE "LKP"."Application";
       LKP         heap    postgres    false    22                       1259    17412    ApplicationFeature    TABLE     �  CREATE TABLE "LKP"."ApplicationFeature" (
    "ApplicationFeatureID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ApplicationID" smallint NOT NULL,
    "ApplicationFeatureName" character varying(500) NOT NULL,
    "ApplicationFeatureCode" character varying(500) NOT NULL
);
 '   DROP TABLE "LKP"."ApplicationFeature";
       LKP         heap    postgres    false    22                       1259    17418 +   ApplicationFeature_ApplicationFeatureID_seq    SEQUENCE       ALTER TABLE "LKP"."ApplicationFeature" ALTER COLUMN "ApplicationFeatureID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."ApplicationFeature_ApplicationFeatureID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    280    22                       1259    17419    Application_ApplicationID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Application" ALTER COLUMN "ApplicationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Application_ApplicationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    279    22                       1259    17420    Bank    TABLE     �  CREATE TABLE "LKP"."Bank" (
    "BankID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "BankName" character varying(500) NOT NULL,
    "BankCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."Bank";
       LKP         heap    postgres    false    22                       1259    17426    Bank_BankID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Bank" ALTER COLUMN "BankID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Bank_BankID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    283                       1259    17427 
   BloodGroup    TABLE     �  CREATE TABLE "LKP"."BloodGroup" (
    "BloodGroupID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "BloodGroupName" character varying(500) NOT NULL,
    "BloodGroupCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."BloodGroup";
       LKP         heap    postgres    false    22                       1259    17433    BloodGroup_BloodGroupID_seq    SEQUENCE     �   ALTER TABLE "LKP"."BloodGroup" ALTER COLUMN "BloodGroupID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."BloodGroup_BloodGroupID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    285                       1259    17434    Branch    TABLE       CREATE TABLE "LKP"."Branch" (
    "BranchID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "BankID" smallint NOT NULL,
    "BranchName" character varying(500) NOT NULL,
    "BranchCode" character varying(500) NOT NULL,
    "BranchUniqueCode" character varying(500) NOT NULL,
    "IFSCCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."Branch";
       LKP         heap    postgres    false    22                        1259    17440    Branch_BranchID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Branch" ALTER COLUMN "BranchID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Branch_BranchID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    287            !           1259    17441    Country    TABLE     �  CREATE TABLE "LKP"."Country" (
    "CountryID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryName" character varying(500) NOT NULL,
    "CountryCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."Country";
       LKP         heap    postgres    false    22            "           1259    17447    Country_CountryID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Country" ALTER COLUMN "CountryID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Country_CountryID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    289    22            #           1259    17448 	   EmailType    TABLE     �  CREATE TABLE "LKP"."EmailType" (
    "EmailTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "EmailTypeName" character varying(500) NOT NULL,
    "EmailTypeCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."EmailType";
       LKP         heap    postgres    false    22            $           1259    17454    EmailType_EmailTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."EmailType" ALTER COLUMN "EmailTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."EmailType_EmailTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    291    22            %           1259    17455    EmailUseType    TABLE     �  CREATE TABLE "LKP"."EmailUseType" (
    "EmailUseTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "EmailUseTypeName" character varying(500) NOT NULL,
    "EmailUseTypeCode" character varying(500) NOT NULL
);
 !   DROP TABLE "LKP"."EmailUseType";
       LKP         heap    postgres    false    22            &           1259    17461    EmailUseType_EmailUseTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."EmailUseType" ALTER COLUMN "EmailUseTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."EmailUseType_EmailUseTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    293            '           1259    17462    Gender    TABLE     �  CREATE TABLE "LKP"."Gender" (
    "GenderID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "GenderName" character varying(500) NOT NULL,
    "GenderCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."Gender";
       LKP         heap    postgres    false    22            (           1259    17468    Gender_GenderID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Gender" ALTER COLUMN "GenderID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Gender_GenderID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    295    22            )           1259    17469    GeographyType    TABLE     5  CREATE TABLE "LKP"."GeographyType" (
    "GeographyTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "GeographyTypeName" character varying(500) NOT NULL,
    "GeographyTypeCode" character varying(500) NOT NULL,
    "GeographyTypeDescription" character varying(500) NOT NULL,
    "ParentGeographyTypeID" smallint
);
 "   DROP TABLE "LKP"."GeographyType";
       LKP         heap    postgres    false    22            *           1259    17475 !   GeographyType_GeographyTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."GeographyType" ALTER COLUMN "GeographyTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."GeographyType_GeographyTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    297    22            +           1259    17476    Hobby    TABLE     �  CREATE TABLE "LKP"."Hobby" (
    "HobbyID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "HobbyName" character varying(500) NOT NULL,
    "HobbyCode" character varying(500) NOT NULL
);
    DROP TABLE "LKP"."Hobby";
       LKP         heap    postgres    false    22            ,           1259    17482    Hobby_HobbyID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Hobby" ALTER COLUMN "HobbyID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Hobby_HobbyID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    299            -           1259    17483 	   Honorific    TABLE     �  CREATE TABLE "LKP"."Honorific" (
    "HonorificID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "HonorificName" character varying(500),
    "HonorificCode" character varying(500),
    "HonorificDescription" character varying(500)
);
    DROP TABLE "LKP"."Honorific";
       LKP         heap    postgres    false    22            .           1259    17489    Honorific_HonorificID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Honorific" ALTER COLUMN "HonorificID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Honorific_HonorificID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    301            /           1259    17490    LocationType    TABLE     P  CREATE TABLE "LKP"."LocationType" (
    "LocationTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "CountryID" smallint NOT NULL,
    "ClientID" integer NOT NULL,
    "LocationTypeName" character varying(500) NOT NULL,
    "LocationTypeCode" character varying(500) NOT NULL,
    "LocationTypeDescription" character varying(500) NOT NULL,
    "ParentLocationTypeID" smallint
);
 !   DROP TABLE "LKP"."LocationType";
       LKP         heap    postgres    false    22            0           1259    17496    LocationType_LocationTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."LocationType" ALTER COLUMN "LocationTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."LocationType_LocationTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    303            1           1259    17497    MaritalStatus    TABLE     �  CREATE TABLE "LKP"."MaritalStatus" (
    "MaritalStatusID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "MaritalStatusName" character varying(500) NOT NULL,
    "MaritalStatusCode" character varying(500) NOT NULL
);
 "   DROP TABLE "LKP"."MaritalStatus";
       LKP         heap    postgres    false    22            2           1259    17503 !   MaritalStatus_MaritalStatusID_seq    SEQUENCE     �   ALTER TABLE "LKP"."MaritalStatus" ALTER COLUMN "MaritalStatusID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."MaritalStatus_MaritalStatusID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    305    22            3           1259    17504    PhoneLineType    TABLE     �  CREATE TABLE "LKP"."PhoneLineType" (
    "PhoneLineTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "PhoneLineTypeName" character varying(500) NOT NULL,
    "PhoneLineTypeCode" character varying(500) NOT NULL
);
 "   DROP TABLE "LKP"."PhoneLineType";
       LKP         heap    postgres    false    22            4           1259    17510 !   PhoneLineType_PhoneLineTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."PhoneLineType" ALTER COLUMN "PhoneLineTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."PhoneLineType_PhoneLineTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    307            5           1259    17511    PhoneUseType    TABLE     �  CREATE TABLE "LKP"."PhoneUseType" (
    "PhoneUseTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "PhoneUseTypeName" character varying(500) NOT NULL,
    "PhoneUseTypeCode" character varying(500) NOT NULL
);
 !   DROP TABLE "LKP"."PhoneUseType";
       LKP         heap    postgres    false    22            6           1259    17517    PhoneUseType_PhoneUseTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."PhoneUseType" ALTER COLUMN "PhoneUseTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."PhoneUseType_PhoneUseTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    309            7           1259    17518    Role    TABLE     �  CREATE TABLE "LKP"."Role" (
    "RoleID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "RoleName" character varying(250) NOT NULL,
    "RoleDescription" character varying(250) NOT NULL,
    "RoleCode" character varying(100)
);
    DROP TABLE "LKP"."Role";
       LKP         heap    postgres    false    22            8           1259    17524    Role_RoleID_seq    SEQUENCE     �   ALTER TABLE "LKP"."Role" ALTER COLUMN "RoleID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."Role_RoleID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    311            9           1259    17525    SubScriptionCategory    TABLE     �  CREATE TABLE "LKP"."SubScriptionCategory" (
    "SubScriptionCategoryID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "SubScriptionCategoryName" character varying(500) NOT NULL,
    "SubScriptionCategoryCode" character varying(500) NOT NULL
);
 )   DROP TABLE "LKP"."SubScriptionCategory";
       LKP         heap    postgres    false    22            :           1259    17531 /   SubScriptionCategory_SubScriptionCategoryID_seq    SEQUENCE       ALTER TABLE "LKP"."SubScriptionCategory" ALTER COLUMN "SubScriptionCategoryID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."SubScriptionCategory_SubScriptionCategoryID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    313            ;           1259    17532    SubScriptionSubCategory    TABLE       CREATE TABLE "LKP"."SubScriptionSubCategory" (
    "SubScriptionSubCategoryID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "SubScriptionCategoryID" smallint NOT NULL,
    "SubScriptionSubCategoryName" character varying(500) NOT NULL,
    "SubScriptionSubCategoryCode" character varying(500) NOT NULL
);
 ,   DROP TABLE "LKP"."SubScriptionSubCategory";
       LKP         heap    postgres    false    22            <           1259    17538 5   SubScriptionSubCategory_SubScriptionSubCategoryID_seq    SEQUENCE       ALTER TABLE "LKP"."SubScriptionSubCategory" ALTER COLUMN "SubScriptionSubCategoryID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."SubScriptionSubCategory_SubScriptionSubCategoryID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    315            =           1259    17539    SubScriptionType    TABLE     �  CREATE TABLE "LKP"."SubScriptionType" (
    "SubScriptionTypeID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "SubScriptionTypeName" character varying(500) NOT NULL,
    "SubScriptionTypeCode" character varying(500) NOT NULL
);
 %   DROP TABLE "LKP"."SubScriptionType";
       LKP         heap    postgres    false    22            >           1259    17545 '   SubScriptionType_SubScriptionTypeID_seq    SEQUENCE     �   ALTER TABLE "LKP"."SubScriptionType" ALTER COLUMN "SubScriptionTypeID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "LKP"."SubScriptionType_SubScriptionTypeID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            LKP          postgres    false    22    317            ?           1259    17546    ExecutionProgress    TABLE     �  CREATE TABLE "TRACK"."ExecutionProgress" (
    "ExecutionProgressID" bigint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ServerName" character varying(500),
    "DatabaseName" character varying(500),
    "ProcessDate" date,
    "ExecutionProcessName" character varying(500) NOT NULL,
    "ExecutionObjectName" character varying(500) NOT NULL,
    "StepDescription" character varying(500) NOT NULL,
    "Request" character varying,
    "StartTime" time without time zone,
    "EndTime" time without time zone,
    "Duration" time without time zone,
    "CurrentQuery" character varying,
    "Inet_Client_Addr" inet,
    "Inet_Server_Addr" inet,
    "PG_BackEnd_PID" integer,
    "SessionUser" name,
    "ApplicationName" character varying(500),
    "VersionNo" character varying(500)
);
 (   DROP TABLE "TRACK"."ExecutionProgress";
       TRACK         heap    postgres    false    28            @           1259    17552 )   ExecutionProgress_ExecutionProgressID_seq    SEQUENCE       ALTER TABLE "TRACK"."ExecutionProgress" ALTER COLUMN "ExecutionProgressID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "TRACK"."ExecutionProgress_ExecutionProgressID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            TRACK          postgres    false    28    319            A           1259    17553    ClientBankAccount    TABLE       CREATE TABLE "XREF"."ClientBankAccount" (
    "ClientBankAccountID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ClientID" smallint NOT NULL,
    "BranchID" smallint NOT NULL,
    "AccountTypeID" smallint NOT NULL,
    "AccountNumber" character varying(500) NOT NULL,
    "IsPrimaryAccount" boolean DEFAULT false
);
 '   DROP TABLE "XREF"."ClientBankAccount";
       XREF         heap    postgres    false    30            B           1259    17560 )   ClientBankAccount_ClientBankAccountID_seq    SEQUENCE       ALTER TABLE "XREF"."ClientBankAccount" ALTER COLUMN "ClientBankAccountID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."ClientBankAccount_ClientBankAccountID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    321    30            C           1259    17561    ClientContactPerson    TABLE       CREATE TABLE "XREF"."ClientContactPerson" (
    "ClientContactPersonID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ClientID" smallint NOT NULL,
    "FirstName" character varying(500) NOT NULL,
    "MiddleName" character varying(500) NOT NULL,
    "LastName" character varying(500) NOT NULL,
    "EmailAddress" character varying(500),
    "AlternateEmailAddress" character varying(500),
    "ContactNumber" character varying(500),
    "AlternateContactNumber" character varying(500),
    "MessengerNumber" character varying(500),
    "IsPrimaryPerson" boolean DEFAULT false
);
 )   DROP TABLE "XREF"."ClientContactPerson";
       XREF         heap    postgres    false    30            D           1259    17568 -   ClientContactPerson_ClientContactPersonID_seq    SEQUENCE       ALTER TABLE "XREF"."ClientContactPerson" ALTER COLUMN "ClientContactPersonID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."ClientContactPerson_ClientContactPersonID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    323            E           1259    17569    ClientImage    TABLE     �  CREATE TABLE "XREF"."ClientImage" (
    "ClientImageID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ClientID" smallint NOT NULL,
    "ClientImage" bytea,
    "IsPrimaryAccount" boolean DEFAULT false
);
 !   DROP TABLE "XREF"."ClientImage";
       XREF         heap    postgres    false    30            F           1259    17576    ClientImage_ClientImageID_seq    SEQUENCE     �   ALTER TABLE "XREF"."ClientImage" ALTER COLUMN "ClientImageID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."ClientImage_ClientImageID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    325            G           1259    17577    ClientLocation    TABLE     �  CREATE TABLE "XREF"."ClientLocation" (
    "ClientLocationID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ClientID" smallint NOT NULL,
    "GeographyID" integer NOT NULL,
    "AddressLine1" character varying(500) NOT NULL,
    "AddressLine2" character varying(500) NOT NULL,
    "AddressLine3" character varying(500) NOT NULL,
    "City" character varying(500) NOT NULL,
    "Locality" character varying(500),
    "PostalCode" character varying(500) NOT NULL
);
 $   DROP TABLE "XREF"."ClientLocation";
       XREF         heap    postgres    false    30            H           1259    17583 #   ClientLocation_ClientLocationID_seq    SEQUENCE     �   ALTER TABLE "XREF"."ClientLocation" ALTER COLUMN "ClientLocationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."ClientLocation_ClientLocationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    327            I           1259    17584 
   ClientRole    TABLE     w  CREATE TABLE "XREF"."ClientRole" (
    "ClientRoleID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ClientID" smallint NOT NULL,
    "RoleID" smallint NOT NULL
);
     DROP TABLE "XREF"."ClientRole";
       XREF         heap    postgres    false    30            J           1259    17590    ClientRole_ClientRoleID_seq    SEQUENCE     �   ALTER TABLE "XREF"."ClientRole" ALTER COLUMN "ClientRoleID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."ClientRole_ClientRoleID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    329            K           1259    17591 	   UserEmail    TABLE     �  CREATE TABLE "XREF"."UserEmail" (
    "UserEmailID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "UserID" integer NOT NULL,
    "EmailAddress" character varying(500) NOT NULL,
    "EmailTypeID" smallint NOT NULL,
    "EmailUseTypeID" smallint NOT NULL,
    "IsPrimaryEmail" boolean DEFAULT false
);
    DROP TABLE "XREF"."UserEmail";
       XREF         heap    postgres    false    30            L           1259    17598    UserEmail_UserEmailID_seq    SEQUENCE     �   ALTER TABLE "XREF"."UserEmail" ALTER COLUMN "UserEmailID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."UserEmail_UserEmailID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    331    30            M           1259    17599    UserLocation    TABLE     �  CREATE TABLE "XREF"."UserLocation" (
    "UserLocationID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "UserID" smallint NOT NULL,
    "GeographyID" integer NOT NULL,
    "AddressLine1" character varying(500) NOT NULL,
    "AddressLine2" character varying(500) NOT NULL,
    "AddressLine3" character varying(500) NOT NULL,
    "City" character varying(500) NOT NULL,
    "Locality" character varying(500),
    "PostalCode" character varying(500) NOT NULL,
    "IsPrimaryLocation" boolean DEFAULT false
);
 "   DROP TABLE "XREF"."UserLocation";
       XREF         heap    postgres    false    30            N           1259    17606    UserLocation_UserLocationID_seq    SEQUENCE     �   ALTER TABLE "XREF"."UserLocation" ALTER COLUMN "UserLocationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."UserLocation_UserLocationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    333            O           1259    17607 	   UserPhone    TABLE       CREATE TABLE "XREF"."UserPhone" (
    "UserPhoneID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "UserID" integer NOT NULL,
    "PhoneNumber" character varying(500) NOT NULL,
    "PhoneLineTypeID" smallint NOT NULL,
    "PhoneUseTypeID" smallint NOT NULL,
    "IsPrimaryPhone" boolean DEFAULT false
);
    DROP TABLE "XREF"."UserPhone";
       XREF         heap    postgres    false    30            P           1259    17614    UserPhone_UserPhoneID_seq    SEQUENCE     �   ALTER TABLE "XREF"."UserPhone" ALTER COLUMN "UserPhoneID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."UserPhone_UserPhoneID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    335            Q           1259    17615    UserProfileSetting    TABLE     �  CREATE TABLE "XREF"."UserProfileSetting" (
    "UserProfileSettingID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "UserID" smallint NOT NULL,
    "ProfileSettingValue" json,
    "IsCurrent" boolean DEFAULT false
);
 (   DROP TABLE "XREF"."UserProfileSetting";
       XREF         heap    postgres    false    30            R           1259    17622 +   UserProfileSetting_UserProfileSettingID_seq    SEQUENCE     	  ALTER TABLE "XREF"."UserProfileSetting" ALTER COLUMN "UserProfileSettingID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."UserProfileSetting_UserProfileSettingID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    337            S           1259    17623    UserRole    TABLE     �  CREATE TABLE "XREF"."UserRole" (
    "UserRoleID" integer NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "UserID" smallint NOT NULL,
    "RoleID" integer NOT NULL,
    "LocationTypeID" integer NOT NULL,
    "LocationID" integer NOT NULL,
    "IsPrimaryLogin" boolean DEFAULT false
);
    DROP TABLE "XREF"."UserRole";
       XREF         heap    postgres    false    30            T           1259    17630    UserRole_UserRoleID_seq    SEQUENCE     �   ALTER TABLE "XREF"."UserRole" ALTER COLUMN "UserRoleID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREF"."UserRole_UserRoleID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            XREF          postgres    false    30    339            U           1259    17631    ClientConfiguration    TABLE     �  CREATE TABLE "XREFCONFIG"."ClientConfiguration" (
    "ClientConfigurationID" smallint NOT NULL,
    "IsDisabled" boolean DEFAULT false,
    "CreatedOn" timestamp without time zone NOT NULL,
    "CreatedByUserName" character varying,
    "UpdatedOn" timestamp without time zone NOT NULL,
    "UpdatedByUserName" character varying,
    "ConfigurationID" smallint NOT NULL,
    "ConfigurationValue" character varying(500)
);
 /   DROP TABLE "XREFCONFIG"."ClientConfiguration";
    
   XREFCONFIG         heap    postgres    false    31            V           1259    17637 -   ClientConfiguration_ClientConfigurationID_seq    SEQUENCE       ALTER TABLE "XREFCONFIG"."ClientConfiguration" ALTER COLUMN "ClientConfigurationID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "XREFCONFIG"."ClientConfiguration_ClientConfigurationID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
         
   XREFCONFIG          postgres    false    341    31            W           1259    18142    refreshtoken    TABLE     �   CREATE TABLE public.refreshtoken (
    id integer NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    token character varying(255) NOT NULL,
    user_id bigint
);
     DROP TABLE public.refreshtoken;
       public         heap    postgres    false            X           1259    18145    refreshtoken_id_seq    SEQUENCE     �   CREATE SEQUENCE public.refreshtoken_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;
 *   DROP SEQUENCE public.refreshtoken_id_seq;
       public          postgres    false    343            �           0    0    refreshtoken_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.refreshtoken_id_seq OWNED BY public.refreshtoken.id;
          public          postgres    false    344            Y           1259    18146    roles    TABLE     (  CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(20),
    role_desc character varying(30),
    isdisabled boolean DEFAULT false,
    updatedbyusername character varying(100),
    rolecode character varying(100),
    createdbyusername character varying(100)
);
    DROP TABLE public.roles;
       public         heap    postgres    false            Z           1259    18150    roles_id_seq    SEQUENCE     �   CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.roles_id_seq;
       public          postgres    false    345            �           0    0    roles_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;
          public          postgres    false    346            [           1259    18151 
   user_roles    TABLE     ^   CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id integer NOT NULL
);
    DROP TABLE public.user_roles;
       public         heap    postgres    false            \           1259    18154    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(50) DEFAULT NULL::character varying,
    password character varying(120) DEFAULT NULL::character varying,
    username character varying(20) DEFAULT NULL::character varying,
    image bytea,
    first_name character varying(20) DEFAULT NULL::character varying,
    last_name character varying(20) DEFAULT NULL::character varying,
    phone character varying(12) DEFAULT NULL::character varying,
    gender_id character varying(2) DEFAULT 1,
    change_password_at date DEFAULT CURRENT_DATE NOT NULL,
    full_name character varying(30) DEFAULT NULL::character varying
);
    DROP TABLE public.users;
       public         heap    postgres    false            ]           1259    18168    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    348            �           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    349            a           2604    18169    roles id    DEFAULT     d   ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);
 7   ALTER TABLE public.roles ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    346    345            c           2604    18170    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    349    348            (          0    17339    Configuration 
   TABLE DATA           �   COPY "CONFIG"."Configuration" ("ConfigurationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ConfigurationName", "ConfigurationDescription", "ConfigurationCode", "ConfigurationValue") FROM stdin;
    CONFIG          postgres    false    261   ��      *          0    17346    Client 
   TABLE DATA           x  COPY "DATA"."Client" ("ClientID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "ClientName", "ClientCode", "ClientDescription", "Logo", "ContactNumber", "AlternateContactNumber", "MessengerNumber", "EmailAddress", "AlternateEmailAddress", "GSTNo", "LoginName", "Password", "Longitude", "Latitude", "LocationCode") FROM stdin;
    DATA          postgres    false    263   ×      ,          0    17353 	   Geography 
   TABLE DATA             COPY "DATA"."Geography" ("GeographyID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "GeographyTypeID", "GeographyName", "GeographyCode", "GeographyDescription", "PostalCode", "ParentGeographyID") FROM stdin;
    DATA          postgres    false    265   1�      .          0    17360    Location 
   TABLE DATA           �  COPY "DATA"."Location" ("LocationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "ClientID", "LocationTypeID", "GeographyID", "LocationName", "LocationShortCode", "AddressLine1", "AddressLine2", "AddressLine3", "City", "Locality", "PostalCode", "LocationImage", "Longitude", "Latitude", "LocationCode", "ParentLocationID", "HashValue") FROM stdin;
    DATA          postgres    false    267   N�      /          0    17366    LocationContactPerson 
   TABLE DATA           Y  COPY "DATA"."LocationContactPerson" ("LocationContactPersonID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "LocationID", "FirstName", "MiddleName", "LastName", "GenderID", "EmailAddress", "AlternateEmailAddress", "ContactNumber", "AlternateContactNumber", "MessengerNumber", "IsPrimaryPerson") FROM stdin;
    DATA          postgres    false    268   k�      2          0    17375    User 
   TABLE DATA           �  COPY "DATA"."User" ("UserID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "HonorificID", "FirstName", "MiddleName", "LastName", "DataOfBirth", "GenderD", "MaritalStatusID", "BloodGroupID", "HobbyID", "ClientID", "LoginName", "Password", "AttemptCount", "IsForcePasswordChange", "PasswordLastChangedOn", "PasswordExpiredOn", "IsTempBlocked", "IsBlocked", "BlockedOn", "UserProfileSettingID") FROM stdin;
    DATA          postgres    false    271   ��      4          0    17385    DatabaseError 
   TABLE DATA           ^  COPY "ERROR"."DatabaseError" ("DatabaseErrorID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ServerName", "DatabaseName", "ExecutionProcessName", "PG_BackEnd_PID", "Returned_SQLState", "Message_Text", "PG_Exception_Detail", "PG_Exception_Hint", "PG_Exception_Context", "ApplicationName", "Version") FROM stdin;
    ERROR          postgres    false    273   ��      6          0    17392    FrontEndError 
   TABLE DATA           �   COPY "ERROR"."FrontEndError" ("FrontEndErrorID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "PageName", "Message") FROM stdin;
    ERROR          postgres    false    275   ��      8          0    17399    AccountType 
   TABLE DATA           �   COPY "LKP"."AccountType" ("AccountTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "AccountTypeName", "AccountTypeCode") FROM stdin;
    LKP          postgres    false    277   ��      :          0    17406    Application 
   TABLE DATA           �   COPY "LKP"."Application" ("ApplicationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ApplicationName", "ApplicationCode") FROM stdin;
    LKP          postgres    false    279   ��      ;          0    17412    ApplicationFeature 
   TABLE DATA           �   COPY "LKP"."ApplicationFeature" ("ApplicationFeatureID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ApplicationID", "ApplicationFeatureName", "ApplicationFeatureCode") FROM stdin;
    LKP          postgres    false    280   #�      >          0    17420    Bank 
   TABLE DATA           �   COPY "LKP"."Bank" ("BankID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "BankName", "BankCode") FROM stdin;
    LKP          postgres    false    283   ��      @          0    17427 
   BloodGroup 
   TABLE DATA           �   COPY "LKP"."BloodGroup" ("BloodGroupID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "BloodGroupName", "BloodGroupCode") FROM stdin;
    LKP          postgres    false    285   ��      B          0    17434    Branch 
   TABLE DATA           �   COPY "LKP"."Branch" ("BranchID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "BankID", "BranchName", "BranchCode", "BranchUniqueCode", "IFSCCode") FROM stdin;
    LKP          postgres    false    287          D          0    17441    Country 
   TABLE DATA           �   COPY "LKP"."Country" ("CountryID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryName", "CountryCode") FROM stdin;
    LKP          postgres    false    289   ߠ      F          0    17448 	   EmailType 
   TABLE DATA           �   COPY "LKP"."EmailType" ("EmailTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "EmailTypeName", "EmailTypeCode") FROM stdin;
    LKP          postgres    false    291   /�      H          0    17455    EmailUseType 
   TABLE DATA           �   COPY "LKP"."EmailUseType" ("EmailUseTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "EmailUseTypeName", "EmailUseTypeCode") FROM stdin;
    LKP          postgres    false    293   L�      J          0    17462    Gender 
   TABLE DATA           �   COPY "LKP"."Gender" ("GenderID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "GenderName", "GenderCode") FROM stdin;
    LKP          postgres    false    295   i�      L          0    17469    GeographyType 
   TABLE DATA           �   COPY "LKP"."GeographyType" ("GeographyTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "GeographyTypeName", "GeographyTypeCode", "GeographyTypeDescription", "ParentGeographyTypeID") FROM stdin;
    LKP          postgres    false    297   ��      N          0    17476    Hobby 
   TABLE DATA           �   COPY "LKP"."Hobby" ("HobbyID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "HobbyName", "HobbyCode") FROM stdin;
    LKP          postgres    false    299   �      P          0    17483 	   Honorific 
   TABLE DATA           �   COPY "LKP"."Honorific" ("HonorificID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "HonorificName", "HonorificCode", "HonorificDescription") FROM stdin;
    LKP          postgres    false    301   ��      R          0    17490    LocationType 
   TABLE DATA           �   COPY "LKP"."LocationType" ("LocationTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "CountryID", "ClientID", "LocationTypeName", "LocationTypeCode", "LocationTypeDescription", "ParentLocationTypeID") FROM stdin;
    LKP          postgres    false    303   �      T          0    17497    MaritalStatus 
   TABLE DATA           �   COPY "LKP"."MaritalStatus" ("MaritalStatusID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "MaritalStatusName", "MaritalStatusCode") FROM stdin;
    LKP          postgres    false    305   v�      V          0    17504    PhoneLineType 
   TABLE DATA           �   COPY "LKP"."PhoneLineType" ("PhoneLineTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "PhoneLineTypeName", "PhoneLineTypeCode") FROM stdin;
    LKP          postgres    false    307   ��      X          0    17511    PhoneUseType 
   TABLE DATA           �   COPY "LKP"."PhoneUseType" ("PhoneUseTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "PhoneUseTypeName", "PhoneUseTypeCode") FROM stdin;
    LKP          postgres    false    309   ��      Z          0    17518    Role 
   TABLE DATA           �   COPY "LKP"."Role" ("RoleID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "RoleName", "RoleDescription", "RoleCode") FROM stdin;
    LKP          postgres    false    311   ͢      \          0    17525    SubScriptionCategory 
   TABLE DATA           �   COPY "LKP"."SubScriptionCategory" ("SubScriptionCategoryID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "SubScriptionCategoryName", "SubScriptionCategoryCode") FROM stdin;
    LKP          postgres    false    313   £      ^          0    17532    SubScriptionSubCategory 
   TABLE DATA           �   COPY "LKP"."SubScriptionSubCategory" ("SubScriptionSubCategoryID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "SubScriptionCategoryID", "SubScriptionSubCategoryName", "SubScriptionSubCategoryCode") FROM stdin;
    LKP          postgres    false    315   ߣ      `          0    17539    SubScriptionType 
   TABLE DATA           �   COPY "LKP"."SubScriptionType" ("SubScriptionTypeID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "SubScriptionTypeName", "SubScriptionTypeCode") FROM stdin;
    LKP          postgres    false    317   ��      b          0    17546    ExecutionProgress 
   TABLE DATA           �  COPY "TRACK"."ExecutionProgress" ("ExecutionProgressID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ServerName", "DatabaseName", "ProcessDate", "ExecutionProcessName", "ExecutionObjectName", "StepDescription", "Request", "StartTime", "EndTime", "Duration", "CurrentQuery", "Inet_Client_Addr", "Inet_Server_Addr", "PG_BackEnd_PID", "SessionUser", "ApplicationName", "VersionNo") FROM stdin;
    TRACK          postgres    false    319   �      d          0    17553    ClientBankAccount 
   TABLE DATA           �   COPY "XREF"."ClientBankAccount" ("ClientBankAccountID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ClientID", "BranchID", "AccountTypeID", "AccountNumber", "IsPrimaryAccount") FROM stdin;
    XREF          postgres    false    321   5�      f          0    17561    ClientContactPerson 
   TABLE DATA           G  COPY "XREF"."ClientContactPerson" ("ClientContactPersonID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ClientID", "FirstName", "MiddleName", "LastName", "EmailAddress", "AlternateEmailAddress", "ContactNumber", "AlternateContactNumber", "MessengerNumber", "IsPrimaryPerson") FROM stdin;
    XREF          postgres    false    323   R�      h          0    17569    ClientImage 
   TABLE DATA           �   COPY "XREF"."ClientImage" ("ClientImageID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ClientID", "ClientImage", "IsPrimaryAccount") FROM stdin;
    XREF          postgres    false    325   o�      j          0    17577    ClientLocation 
   TABLE DATA           �   COPY "XREF"."ClientLocation" ("ClientLocationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ClientID", "GeographyID", "AddressLine1", "AddressLine2", "AddressLine3", "City", "Locality", "PostalCode") FROM stdin;
    XREF          postgres    false    327   ��      l          0    17584 
   ClientRole 
   TABLE DATA           �   COPY "XREF"."ClientRole" ("ClientRoleID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ClientID", "RoleID") FROM stdin;
    XREF          postgres    false    329   ��      n          0    17591 	   UserEmail 
   TABLE DATA           �   COPY "XREF"."UserEmail" ("UserEmailID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "UserID", "EmailAddress", "EmailTypeID", "EmailUseTypeID", "IsPrimaryEmail") FROM stdin;
    XREF          postgres    false    331   ��      p          0    17599    UserLocation 
   TABLE DATA             COPY "XREF"."UserLocation" ("UserLocationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "UserID", "GeographyID", "AddressLine1", "AddressLine2", "AddressLine3", "City", "Locality", "PostalCode", "IsPrimaryLocation") FROM stdin;
    XREF          postgres    false    333   ��      r          0    17607 	   UserPhone 
   TABLE DATA           �   COPY "XREF"."UserPhone" ("UserPhoneID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "UserID", "PhoneNumber", "PhoneLineTypeID", "PhoneUseTypeID", "IsPrimaryPhone") FROM stdin;
    XREF          postgres    false    335    �      t          0    17615    UserProfileSetting 
   TABLE DATA           �   COPY "XREF"."UserProfileSetting" ("UserProfileSettingID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "UserID", "ProfileSettingValue", "IsCurrent") FROM stdin;
    XREF          postgres    false    337   �      v          0    17623    UserRole 
   TABLE DATA           �   COPY "XREF"."UserRole" ("UserRoleID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "UserID", "RoleID", "LocationTypeID", "LocationID", "IsPrimaryLogin") FROM stdin;
    XREF          postgres    false    339   :�      x          0    17631    ClientConfiguration 
   TABLE DATA           �   COPY "XREFCONFIG"."ClientConfiguration" ("ClientConfigurationID", "IsDisabled", "CreatedOn", "CreatedByUserName", "UpdatedOn", "UpdatedByUserName", "ConfigurationID", "ConfigurationValue") FROM stdin;
 
   XREFCONFIG          postgres    false    341   W�      z          0    18142    refreshtoken 
   TABLE DATA           G   COPY public.refreshtoken (id, expiry_date, token, user_id) FROM stdin;
    public          postgres    false    343   t�      |          0    18146    roles 
   TABLE DATA           u   COPY public.roles (id, role_name, role_desc, isdisabled, updatedbyusername, rolecode, createdbyusername) FROM stdin;
    public          postgres    false    345   C�      ~          0    18151 
   user_roles 
   TABLE DATA           6   COPY public.user_roles (user_id, role_id) FROM stdin;
    public          postgres    false    347   6�                0    18154    users 
   TABLE DATA           �   COPY public.users (id, email, password, username, image, first_name, last_name, phone, gender_id, change_password_at, full_name) FROM stdin;
    public          postgres    false    348   \�      �           0    0 !   Configuration_ConfigurationID_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('"CONFIG"."Configuration_ConfigurationID_seq"', 1, false);
          CONFIG          postgres    false    262            �           0    0    Client_ClientID_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('"DATA"."Client_ClientID_seq"', 6, true);
          DATA          postgres    false    264            �           0    0    Geography_GeographyID_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('"DATA"."Geography_GeographyID_seq"', 1, false);
          DATA          postgres    false    266            �           0    0 1   LocationContactPerson_LocationContactPersonID_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('"DATA"."LocationContactPerson_LocationContactPersonID_seq"', 1, false);
          DATA          postgres    false    269            �           0    0    Location_LocationID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('"DATA"."Location_LocationID_seq"', 1, false);
          DATA          postgres    false    270            �           0    0    User_UserID_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"DATA"."User_UserID_seq"', 1, false);
          DATA          postgres    false    272            �           0    0 !   DatabaseError_DatabaseErrorID_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('"ERROR"."DatabaseError_DatabaseErrorID_seq"', 45, true);
          ERROR          postgres    false    274            �           0    0 !   FrontEndError_FrontEndErrorID_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('"ERROR"."FrontEndError_FrontEndErrorID_seq"', 1, false);
          ERROR          postgres    false    276            �           0    0    AccountType_AccountTypeID_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('"LKP"."AccountType_AccountTypeID_seq"', 1, false);
          LKP          postgres    false    278            �           0    0 +   ApplicationFeature_ApplicationFeatureID_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('"LKP"."ApplicationFeature_ApplicationFeatureID_seq"', 1, true);
          LKP          postgres    false    281            �           0    0    Application_ApplicationID_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('"LKP"."Application_ApplicationID_seq"', 1, true);
          LKP          postgres    false    282            �           0    0    Bank_BankID_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('"LKP"."Bank_BankID_seq"', 1, false);
          LKP          postgres    false    284            �           0    0    BloodGroup_BloodGroupID_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('"LKP"."BloodGroup_BloodGroupID_seq"', 1, false);
          LKP          postgres    false    286            �           0    0    Branch_BranchID_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('"LKP"."Branch_BranchID_seq"', 1, false);
          LKP          postgres    false    288            �           0    0    Country_CountryID_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('"LKP"."Country_CountryID_seq"', 1, true);
          LKP          postgres    false    290            �           0    0    EmailType_EmailTypeID_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('"LKP"."EmailType_EmailTypeID_seq"', 1, false);
          LKP          postgres    false    292            �           0    0    EmailUseType_EmailUseTypeID_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('"LKP"."EmailUseType_EmailUseTypeID_seq"', 1, false);
          LKP          postgres    false    294            �           0    0    Gender_GenderID_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('"LKP"."Gender_GenderID_seq"', 1, false);
          LKP          postgres    false    296            �           0    0 !   GeographyType_GeographyTypeID_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('"LKP"."GeographyType_GeographyTypeID_seq"', 1, true);
          LKP          postgres    false    298            �           0    0    Hobby_HobbyID_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('"LKP"."Hobby_HobbyID_seq"', 1, false);
          LKP          postgres    false    300            �           0    0    Honorific_HonorificID_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('"LKP"."Honorific_HonorificID_seq"', 1, false);
          LKP          postgres    false    302            �           0    0    LocationType_LocationTypeID_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('"LKP"."LocationType_LocationTypeID_seq"', 1, true);
          LKP          postgres    false    304            �           0    0 !   MaritalStatus_MaritalStatusID_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('"LKP"."MaritalStatus_MaritalStatusID_seq"', 1, false);
          LKP          postgres    false    306            �           0    0 !   PhoneLineType_PhoneLineTypeID_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('"LKP"."PhoneLineType_PhoneLineTypeID_seq"', 1, false);
          LKP          postgres    false    308            �           0    0    PhoneUseType_PhoneUseTypeID_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('"LKP"."PhoneUseType_PhoneUseTypeID_seq"', 1, false);
          LKP          postgres    false    310            �           0    0    Role_RoleID_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('"LKP"."Role_RoleID_seq"', 20, true);
          LKP          postgres    false    312            �           0    0 /   SubScriptionCategory_SubScriptionCategoryID_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('"LKP"."SubScriptionCategory_SubScriptionCategoryID_seq"', 1, false);
          LKP          postgres    false    314            �           0    0 5   SubScriptionSubCategory_SubScriptionSubCategoryID_seq    SEQUENCE SET     e   SELECT pg_catalog.setval('"LKP"."SubScriptionSubCategory_SubScriptionSubCategoryID_seq"', 1, false);
          LKP          postgres    false    316            �           0    0 '   SubScriptionType_SubScriptionTypeID_seq    SEQUENCE SET     W   SELECT pg_catalog.setval('"LKP"."SubScriptionType_SubScriptionTypeID_seq"', 1, false);
          LKP          postgres    false    318            �           0    0 )   ExecutionProgress_ExecutionProgressID_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('"TRACK"."ExecutionProgress_ExecutionProgressID_seq"', 434, true);
          TRACK          postgres    false    320            �           0    0 )   ClientBankAccount_ClientBankAccountID_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('"XREF"."ClientBankAccount_ClientBankAccountID_seq"', 1, false);
          XREF          postgres    false    322            �           0    0 -   ClientContactPerson_ClientContactPersonID_seq    SEQUENCE SET     ^   SELECT pg_catalog.setval('"XREF"."ClientContactPerson_ClientContactPersonID_seq"', 1, false);
          XREF          postgres    false    324            �           0    0    ClientImage_ClientImageID_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('"XREF"."ClientImage_ClientImageID_seq"', 1, false);
          XREF          postgres    false    326            �           0    0 #   ClientLocation_ClientLocationID_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('"XREF"."ClientLocation_ClientLocationID_seq"', 1, false);
          XREF          postgres    false    328            �           0    0    ClientRole_ClientRoleID_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('"XREF"."ClientRole_ClientRoleID_seq"', 1, false);
          XREF          postgres    false    330            �           0    0    UserEmail_UserEmailID_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('"XREF"."UserEmail_UserEmailID_seq"', 1, false);
          XREF          postgres    false    332            �           0    0    UserLocation_UserLocationID_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('"XREF"."UserLocation_UserLocationID_seq"', 1, false);
          XREF          postgres    false    334            �           0    0    UserPhone_UserPhoneID_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('"XREF"."UserPhone_UserPhoneID_seq"', 1, false);
          XREF          postgres    false    336            �           0    0 +   UserProfileSetting_UserProfileSettingID_seq    SEQUENCE SET     \   SELECT pg_catalog.setval('"XREF"."UserProfileSetting_UserProfileSettingID_seq"', 1, false);
          XREF          postgres    false    338            �           0    0    UserRole_UserRoleID_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('"XREF"."UserRole_UserRoleID_seq"', 1, false);
          XREF          postgres    false    340            �           0    0 -   ClientConfiguration_ClientConfigurationID_seq    SEQUENCE SET     d   SELECT pg_catalog.setval('"XREFCONFIG"."ClientConfiguration_ClientConfigurationID_seq"', 1, false);
       
   XREFCONFIG          postgres    false    342            �           0    0    refreshtoken_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.refreshtoken_id_seq', 110, true);
          public          postgres    false    344            �           0    0    roles_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.roles_id_seq', 34, true);
          public          postgres    false    346            �           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 14, true);
          public          postgres    false    349            n           2606    17639 1   Configuration Configuration_ConfigurationCode_key 
   CONSTRAINT     �   ALTER TABLE ONLY "CONFIG"."Configuration"
    ADD CONSTRAINT "Configuration_ConfigurationCode_key" UNIQUE ("ConfigurationCode");
 a   ALTER TABLE ONLY "CONFIG"."Configuration" DROP CONSTRAINT "Configuration_ConfigurationCode_key";
       CONFIG            postgres    false    261            p           2606    17641 8   Configuration Configuration_ConfigurationDescription_key 
   CONSTRAINT     �   ALTER TABLE ONLY "CONFIG"."Configuration"
    ADD CONSTRAINT "Configuration_ConfigurationDescription_key" UNIQUE ("ConfigurationDescription");
 h   ALTER TABLE ONLY "CONFIG"."Configuration" DROP CONSTRAINT "Configuration_ConfigurationDescription_key";
       CONFIG            postgres    false    261            r           2606    17643 1   Configuration Configuration_ConfigurationName_key 
   CONSTRAINT     �   ALTER TABLE ONLY "CONFIG"."Configuration"
    ADD CONSTRAINT "Configuration_ConfigurationName_key" UNIQUE ("ConfigurationName");
 a   ALTER TABLE ONLY "CONFIG"."Configuration" DROP CONSTRAINT "Configuration_ConfigurationName_key";
       CONFIG            postgres    false    261            t           2606    17645     Configuration Configuration_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY "CONFIG"."Configuration"
    ADD CONSTRAINT "Configuration_pkey" PRIMARY KEY ("ConfigurationID");
 P   ALTER TABLE ONLY "CONFIG"."Configuration" DROP CONSTRAINT "Configuration_pkey";
       CONFIG            postgres    false    261            x           2606    17647    Client Client_ClientCode_key 
   CONSTRAINT     c   ALTER TABLE ONLY "DATA"."Client"
    ADD CONSTRAINT "Client_ClientCode_key" UNIQUE ("ClientCode");
 J   ALTER TABLE ONLY "DATA"."Client" DROP CONSTRAINT "Client_ClientCode_key";
       DATA            postgres    false    263            z           2606    17649    Client Client_LoginName_key 
   CONSTRAINT     a   ALTER TABLE ONLY "DATA"."Client"
    ADD CONSTRAINT "Client_LoginName_key" UNIQUE ("LoginName");
 I   ALTER TABLE ONLY "DATA"."Client" DROP CONSTRAINT "Client_LoginName_key";
       DATA            postgres    false    263            |           2606    17651    Client Client_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY "DATA"."Client"
    ADD CONSTRAINT "Client_pkey" PRIMARY KEY ("ClientID");
 @   ALTER TABLE ONLY "DATA"."Client" DROP CONSTRAINT "Client_pkey";
       DATA            postgres    false    263            �           2606    17653 ?   Geography Geography_GeographyCode_GeographyTypeID_CountryID_key 
   CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Geography"
    ADD CONSTRAINT "Geography_GeographyCode_GeographyTypeID_CountryID_key" UNIQUE ("GeographyCode", "GeographyTypeID", "CountryID");
 m   ALTER TABLE ONLY "DATA"."Geography" DROP CONSTRAINT "Geography_GeographyCode_GeographyTypeID_CountryID_key";
       DATA            postgres    false    265    265    265            �           2606    17655    Geography Geography_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY "DATA"."Geography"
    ADD CONSTRAINT "Geography_pkey" PRIMARY KEY ("GeographyID");
 F   ALTER TABLE ONLY "DATA"."Geography" DROP CONSTRAINT "Geography_pkey";
       DATA            postgres    false    265            �           2606    17657 0   LocationContactPerson LocationContactPerson_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "DATA"."LocationContactPerson"
    ADD CONSTRAINT "LocationContactPerson_pkey" PRIMARY KEY ("LocationContactPersonID");
 ^   ALTER TABLE ONLY "DATA"."LocationContactPerson" DROP CONSTRAINT "LocationContactPerson_pkey";
       DATA            postgres    false    268            �           2606    17659    Location Location_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY "DATA"."Location"
    ADD CONSTRAINT "Location_pkey" PRIMARY KEY ("LocationID");
 D   ALTER TABLE ONLY "DATA"."Location" DROP CONSTRAINT "Location_pkey";
       DATA            postgres    false    267            �           2606    17661    User User_LoginName_key 
   CONSTRAINT     ]   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_LoginName_key" UNIQUE ("LoginName");
 E   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_LoginName_key";
       DATA            postgres    false    271            �           2606    17663    User User_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY ("UserID");
 <   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_pkey";
       DATA            postgres    false    271            �           2606    17665     DatabaseError DatabaseError_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY "ERROR"."DatabaseError"
    ADD CONSTRAINT "DatabaseError_pkey" PRIMARY KEY ("DatabaseErrorID");
 O   ALTER TABLE ONLY "ERROR"."DatabaseError" DROP CONSTRAINT "DatabaseError_pkey";
       ERROR            postgres    false    273            �           2606    17667     FrontEndError FrontEndError_pkey 
   CONSTRAINT     r   ALTER TABLE ONLY "ERROR"."FrontEndError"
    ADD CONSTRAINT "FrontEndError_pkey" PRIMARY KEY ("FrontEndErrorID");
 O   ALTER TABLE ONLY "ERROR"."FrontEndError" DROP CONSTRAINT "FrontEndError_pkey";
       ERROR            postgres    false    275            �           2606    17669 +   AccountType AccountType_AccountTypeCode_key 
   CONSTRAINT     v   ALTER TABLE ONLY "LKP"."AccountType"
    ADD CONSTRAINT "AccountType_AccountTypeCode_key" UNIQUE ("AccountTypeCode");
 X   ALTER TABLE ONLY "LKP"."AccountType" DROP CONSTRAINT "AccountType_AccountTypeCode_key";
       LKP            postgres    false    277            �           2606    17671    AccountType AccountType_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY "LKP"."AccountType"
    ADD CONSTRAINT "AccountType_pkey" PRIMARY KEY ("AccountTypeID");
 I   ALTER TABLE ONLY "LKP"."AccountType" DROP CONSTRAINT "AccountType_pkey";
       LKP            postgres    false    277            �           2606    17673 @   ApplicationFeature ApplicationFeature_ApplicationFeatureCode_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."ApplicationFeature"
    ADD CONSTRAINT "ApplicationFeature_ApplicationFeatureCode_key" UNIQUE ("ApplicationFeatureCode");
 m   ALTER TABLE ONLY "LKP"."ApplicationFeature" DROP CONSTRAINT "ApplicationFeature_ApplicationFeatureCode_key";
       LKP            postgres    false    280            �           2606    17675 *   ApplicationFeature ApplicationFeature_pkey 
   CONSTRAINT        ALTER TABLE ONLY "LKP"."ApplicationFeature"
    ADD CONSTRAINT "ApplicationFeature_pkey" PRIMARY KEY ("ApplicationFeatureID");
 W   ALTER TABLE ONLY "LKP"."ApplicationFeature" DROP CONSTRAINT "ApplicationFeature_pkey";
       LKP            postgres    false    280            �           2606    17677 +   Application Application_ApplicationCode_key 
   CONSTRAINT     v   ALTER TABLE ONLY "LKP"."Application"
    ADD CONSTRAINT "Application_ApplicationCode_key" UNIQUE ("ApplicationCode");
 X   ALTER TABLE ONLY "LKP"."Application" DROP CONSTRAINT "Application_ApplicationCode_key";
       LKP            postgres    false    279            �           2606    17679    Application Application_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY "LKP"."Application"
    ADD CONSTRAINT "Application_pkey" PRIMARY KEY ("ApplicationID");
 I   ALTER TABLE ONLY "LKP"."Application" DROP CONSTRAINT "Application_pkey";
       LKP            postgres    false    279            �           2606    17681    Bank Bank_BankCode_key 
   CONSTRAINT     Z   ALTER TABLE ONLY "LKP"."Bank"
    ADD CONSTRAINT "Bank_BankCode_key" UNIQUE ("BankCode");
 C   ALTER TABLE ONLY "LKP"."Bank" DROP CONSTRAINT "Bank_BankCode_key";
       LKP            postgres    false    283            �           2606    17683    Bank Bank_BankName_key 
   CONSTRAINT     Z   ALTER TABLE ONLY "LKP"."Bank"
    ADD CONSTRAINT "Bank_BankName_key" UNIQUE ("BankName");
 C   ALTER TABLE ONLY "LKP"."Bank" DROP CONSTRAINT "Bank_BankName_key";
       LKP            postgres    false    283            �           2606    17685    Bank Bank_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY "LKP"."Bank"
    ADD CONSTRAINT "Bank_pkey" PRIMARY KEY ("BankID");
 ;   ALTER TABLE ONLY "LKP"."Bank" DROP CONSTRAINT "Bank_pkey";
       LKP            postgres    false    283            �           2606    17687 (   BloodGroup BloodGroup_BloodGroupCode_key 
   CONSTRAINT     r   ALTER TABLE ONLY "LKP"."BloodGroup"
    ADD CONSTRAINT "BloodGroup_BloodGroupCode_key" UNIQUE ("BloodGroupCode");
 U   ALTER TABLE ONLY "LKP"."BloodGroup" DROP CONSTRAINT "BloodGroup_BloodGroupCode_key";
       LKP            postgres    false    285            �           2606    17689 (   BloodGroup BloodGroup_BloodGroupName_key 
   CONSTRAINT     r   ALTER TABLE ONLY "LKP"."BloodGroup"
    ADD CONSTRAINT "BloodGroup_BloodGroupName_key" UNIQUE ("BloodGroupName");
 U   ALTER TABLE ONLY "LKP"."BloodGroup" DROP CONSTRAINT "BloodGroup_BloodGroupName_key";
       LKP            postgres    false    285            �           2606    17691    BloodGroup BloodGroup_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY "LKP"."BloodGroup"
    ADD CONSTRAINT "BloodGroup_pkey" PRIMARY KEY ("BloodGroupID");
 G   ALTER TABLE ONLY "LKP"."BloodGroup" DROP CONSTRAINT "BloodGroup_pkey";
       LKP            postgres    false    285            �           2606    17693    Branch Branch_BranchCode_key 
   CONSTRAINT     b   ALTER TABLE ONLY "LKP"."Branch"
    ADD CONSTRAINT "Branch_BranchCode_key" UNIQUE ("BranchCode");
 I   ALTER TABLE ONLY "LKP"."Branch" DROP CONSTRAINT "Branch_BranchCode_key";
       LKP            postgres    false    287            �           2606    17695    Branch Branch_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY "LKP"."Branch"
    ADD CONSTRAINT "Branch_pkey" PRIMARY KEY ("BranchID");
 ?   ALTER TABLE ONLY "LKP"."Branch" DROP CONSTRAINT "Branch_pkey";
       LKP            postgres    false    287            �           2606    17697    Country Country_CountryCode_key 
   CONSTRAINT     f   ALTER TABLE ONLY "LKP"."Country"
    ADD CONSTRAINT "Country_CountryCode_key" UNIQUE ("CountryCode");
 L   ALTER TABLE ONLY "LKP"."Country" DROP CONSTRAINT "Country_CountryCode_key";
       LKP            postgres    false    289            �           2606    17699    Country Country_CountryName_key 
   CONSTRAINT     f   ALTER TABLE ONLY "LKP"."Country"
    ADD CONSTRAINT "Country_CountryName_key" UNIQUE ("CountryName");
 L   ALTER TABLE ONLY "LKP"."Country" DROP CONSTRAINT "Country_CountryName_key";
       LKP            postgres    false    289            �           2606    17701    Country Country_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY "LKP"."Country"
    ADD CONSTRAINT "Country_pkey" PRIMARY KEY ("CountryID");
 A   ALTER TABLE ONLY "LKP"."Country" DROP CONSTRAINT "Country_pkey";
       LKP            postgres    false    289            �           2606    17703 %   EmailType EmailType_EmailTypeCode_key 
   CONSTRAINT     n   ALTER TABLE ONLY "LKP"."EmailType"
    ADD CONSTRAINT "EmailType_EmailTypeCode_key" UNIQUE ("EmailTypeCode");
 R   ALTER TABLE ONLY "LKP"."EmailType" DROP CONSTRAINT "EmailType_EmailTypeCode_key";
       LKP            postgres    false    291            �           2606    17705 %   EmailType EmailType_EmailTypeName_key 
   CONSTRAINT     n   ALTER TABLE ONLY "LKP"."EmailType"
    ADD CONSTRAINT "EmailType_EmailTypeName_key" UNIQUE ("EmailTypeName");
 R   ALTER TABLE ONLY "LKP"."EmailType" DROP CONSTRAINT "EmailType_EmailTypeName_key";
       LKP            postgres    false    291            �           2606    17707    EmailType EmailType_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY "LKP"."EmailType"
    ADD CONSTRAINT "EmailType_pkey" PRIMARY KEY ("EmailTypeID");
 E   ALTER TABLE ONLY "LKP"."EmailType" DROP CONSTRAINT "EmailType_pkey";
       LKP            postgres    false    291            �           2606    17709 .   EmailUseType EmailUseType_EmailUseTypeCode_key 
   CONSTRAINT     z   ALTER TABLE ONLY "LKP"."EmailUseType"
    ADD CONSTRAINT "EmailUseType_EmailUseTypeCode_key" UNIQUE ("EmailUseTypeCode");
 [   ALTER TABLE ONLY "LKP"."EmailUseType" DROP CONSTRAINT "EmailUseType_EmailUseTypeCode_key";
       LKP            postgres    false    293            �           2606    17711 .   EmailUseType EmailUseType_EmailUseTypeName_key 
   CONSTRAINT     z   ALTER TABLE ONLY "LKP"."EmailUseType"
    ADD CONSTRAINT "EmailUseType_EmailUseTypeName_key" UNIQUE ("EmailUseTypeName");
 [   ALTER TABLE ONLY "LKP"."EmailUseType" DROP CONSTRAINT "EmailUseType_EmailUseTypeName_key";
       LKP            postgres    false    293            �           2606    17713    EmailUseType EmailUseType_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY "LKP"."EmailUseType"
    ADD CONSTRAINT "EmailUseType_pkey" PRIMARY KEY ("EmailUseTypeID");
 K   ALTER TABLE ONLY "LKP"."EmailUseType" DROP CONSTRAINT "EmailUseType_pkey";
       LKP            postgres    false    293            �           2606    17715    Gender Gender_GenderCode_key 
   CONSTRAINT     b   ALTER TABLE ONLY "LKP"."Gender"
    ADD CONSTRAINT "Gender_GenderCode_key" UNIQUE ("GenderCode");
 I   ALTER TABLE ONLY "LKP"."Gender" DROP CONSTRAINT "Gender_GenderCode_key";
       LKP            postgres    false    295            �           2606    17717    Gender Gender_GenderName_key 
   CONSTRAINT     b   ALTER TABLE ONLY "LKP"."Gender"
    ADD CONSTRAINT "Gender_GenderName_key" UNIQUE ("GenderName");
 I   ALTER TABLE ONLY "LKP"."Gender" DROP CONSTRAINT "Gender_GenderName_key";
       LKP            postgres    false    295            �           2606    17719    Gender Gender_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY "LKP"."Gender"
    ADD CONSTRAINT "Gender_pkey" PRIMARY KEY ("GenderID");
 ?   ALTER TABLE ONLY "LKP"."Gender" DROP CONSTRAINT "Gender_pkey";
       LKP            postgres    false    295            �           2606    17721 ;   GeographyType GeographyType_GeographyTypeCode_CountryID_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."GeographyType"
    ADD CONSTRAINT "GeographyType_GeographyTypeCode_CountryID_key" UNIQUE ("GeographyTypeCode", "CountryID");
 h   ALTER TABLE ONLY "LKP"."GeographyType" DROP CONSTRAINT "GeographyType_GeographyTypeCode_CountryID_key";
       LKP            postgres    false    297    297            �           2606    17723     GeographyType GeographyType_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY "LKP"."GeographyType"
    ADD CONSTRAINT "GeographyType_pkey" PRIMARY KEY ("GeographyTypeID");
 M   ALTER TABLE ONLY "LKP"."GeographyType" DROP CONSTRAINT "GeographyType_pkey";
       LKP            postgres    false    297            �           2606    17725    Hobby Hobby_HobbyCode_key 
   CONSTRAINT     ^   ALTER TABLE ONLY "LKP"."Hobby"
    ADD CONSTRAINT "Hobby_HobbyCode_key" UNIQUE ("HobbyCode");
 F   ALTER TABLE ONLY "LKP"."Hobby" DROP CONSTRAINT "Hobby_HobbyCode_key";
       LKP            postgres    false    299            �           2606    17727    Hobby Hobby_HobbyName_key 
   CONSTRAINT     ^   ALTER TABLE ONLY "LKP"."Hobby"
    ADD CONSTRAINT "Hobby_HobbyName_key" UNIQUE ("HobbyName");
 F   ALTER TABLE ONLY "LKP"."Hobby" DROP CONSTRAINT "Hobby_HobbyName_key";
       LKP            postgres    false    299            �           2606    17729    Hobby Hobby_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY "LKP"."Hobby"
    ADD CONSTRAINT "Hobby_pkey" PRIMARY KEY ("HobbyID");
 =   ALTER TABLE ONLY "LKP"."Hobby" DROP CONSTRAINT "Hobby_pkey";
       LKP            postgres    false    299            �           2606    17731 %   Honorific Honorific_HonorificCode_key 
   CONSTRAINT     n   ALTER TABLE ONLY "LKP"."Honorific"
    ADD CONSTRAINT "Honorific_HonorificCode_key" UNIQUE ("HonorificCode");
 R   ALTER TABLE ONLY "LKP"."Honorific" DROP CONSTRAINT "Honorific_HonorificCode_key";
       LKP            postgres    false    301            �           2606    17733 %   Honorific Honorific_HonorificName_key 
   CONSTRAINT     n   ALTER TABLE ONLY "LKP"."Honorific"
    ADD CONSTRAINT "Honorific_HonorificName_key" UNIQUE ("HonorificName");
 R   ALTER TABLE ONLY "LKP"."Honorific" DROP CONSTRAINT "Honorific_HonorificName_key";
       LKP            postgres    false    301            �           2606    17735    Honorific Honorific_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY "LKP"."Honorific"
    ADD CONSTRAINT "Honorific_pkey" PRIMARY KEY ("HonorificID");
 E   ALTER TABLE ONLY "LKP"."Honorific" DROP CONSTRAINT "Honorific_pkey";
       LKP            postgres    false    301            �           2606    17737 A   LocationType LocationType_LocationTypeCode_ClientID_CountryID_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."LocationType"
    ADD CONSTRAINT "LocationType_LocationTypeCode_ClientID_CountryID_key" UNIQUE ("LocationTypeCode", "ClientID", "CountryID");
 n   ALTER TABLE ONLY "LKP"."LocationType" DROP CONSTRAINT "LocationType_LocationTypeCode_ClientID_CountryID_key";
       LKP            postgres    false    303    303    303                       2606    17739    LocationType LocationType_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY "LKP"."LocationType"
    ADD CONSTRAINT "LocationType_pkey" PRIMARY KEY ("LocationTypeID");
 K   ALTER TABLE ONLY "LKP"."LocationType" DROP CONSTRAINT "LocationType_pkey";
       LKP            postgres    false    303                       2606    17741 1   MaritalStatus MaritalStatus_MaritalStatusCode_key 
   CONSTRAINT     ~   ALTER TABLE ONLY "LKP"."MaritalStatus"
    ADD CONSTRAINT "MaritalStatus_MaritalStatusCode_key" UNIQUE ("MaritalStatusCode");
 ^   ALTER TABLE ONLY "LKP"."MaritalStatus" DROP CONSTRAINT "MaritalStatus_MaritalStatusCode_key";
       LKP            postgres    false    305                       2606    17743 1   MaritalStatus MaritalStatus_MaritalStatusName_key 
   CONSTRAINT     ~   ALTER TABLE ONLY "LKP"."MaritalStatus"
    ADD CONSTRAINT "MaritalStatus_MaritalStatusName_key" UNIQUE ("MaritalStatusName");
 ^   ALTER TABLE ONLY "LKP"."MaritalStatus" DROP CONSTRAINT "MaritalStatus_MaritalStatusName_key";
       LKP            postgres    false    305            	           2606    17745     MaritalStatus MaritalStatus_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY "LKP"."MaritalStatus"
    ADD CONSTRAINT "MaritalStatus_pkey" PRIMARY KEY ("MaritalStatusID");
 M   ALTER TABLE ONLY "LKP"."MaritalStatus" DROP CONSTRAINT "MaritalStatus_pkey";
       LKP            postgres    false    305                       2606    17747 1   PhoneLineType PhoneLineType_PhoneLineTypeCode_key 
   CONSTRAINT     ~   ALTER TABLE ONLY "LKP"."PhoneLineType"
    ADD CONSTRAINT "PhoneLineType_PhoneLineTypeCode_key" UNIQUE ("PhoneLineTypeCode");
 ^   ALTER TABLE ONLY "LKP"."PhoneLineType" DROP CONSTRAINT "PhoneLineType_PhoneLineTypeCode_key";
       LKP            postgres    false    307                       2606    17749 1   PhoneLineType PhoneLineType_PhoneLineTypeName_key 
   CONSTRAINT     ~   ALTER TABLE ONLY "LKP"."PhoneLineType"
    ADD CONSTRAINT "PhoneLineType_PhoneLineTypeName_key" UNIQUE ("PhoneLineTypeName");
 ^   ALTER TABLE ONLY "LKP"."PhoneLineType" DROP CONSTRAINT "PhoneLineType_PhoneLineTypeName_key";
       LKP            postgres    false    307                       2606    17751     PhoneLineType PhoneLineType_pkey 
   CONSTRAINT     p   ALTER TABLE ONLY "LKP"."PhoneLineType"
    ADD CONSTRAINT "PhoneLineType_pkey" PRIMARY KEY ("PhoneLineTypeID");
 M   ALTER TABLE ONLY "LKP"."PhoneLineType" DROP CONSTRAINT "PhoneLineType_pkey";
       LKP            postgres    false    307                       2606    17753 .   PhoneUseType PhoneUseType_PhoneUseTypeCode_key 
   CONSTRAINT     z   ALTER TABLE ONLY "LKP"."PhoneUseType"
    ADD CONSTRAINT "PhoneUseType_PhoneUseTypeCode_key" UNIQUE ("PhoneUseTypeCode");
 [   ALTER TABLE ONLY "LKP"."PhoneUseType" DROP CONSTRAINT "PhoneUseType_PhoneUseTypeCode_key";
       LKP            postgres    false    309                       2606    17755 .   PhoneUseType PhoneUseType_PhoneUseTypeName_key 
   CONSTRAINT     z   ALTER TABLE ONLY "LKP"."PhoneUseType"
    ADD CONSTRAINT "PhoneUseType_PhoneUseTypeName_key" UNIQUE ("PhoneUseTypeName");
 [   ALTER TABLE ONLY "LKP"."PhoneUseType" DROP CONSTRAINT "PhoneUseType_PhoneUseTypeName_key";
       LKP            postgres    false    309                       2606    17757    PhoneUseType PhoneUseType_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY "LKP"."PhoneUseType"
    ADD CONSTRAINT "PhoneUseType_pkey" PRIMARY KEY ("PhoneUseTypeID");
 K   ALTER TABLE ONLY "LKP"."PhoneUseType" DROP CONSTRAINT "PhoneUseType_pkey";
       LKP            postgres    false    309                       2606    17759    Role Role_RoleCode_key 
   CONSTRAINT     Z   ALTER TABLE ONLY "LKP"."Role"
    ADD CONSTRAINT "Role_RoleCode_key" UNIQUE ("RoleCode");
 C   ALTER TABLE ONLY "LKP"."Role" DROP CONSTRAINT "Role_RoleCode_key";
       LKP            postgres    false    311                       2606    17761    Role Role_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY "LKP"."Role"
    ADD CONSTRAINT "Role_pkey" PRIMARY KEY ("RoleID");
 ;   ALTER TABLE ONLY "LKP"."Role" DROP CONSTRAINT "Role_pkey";
       LKP            postgres    false    311            #           2606    17763 F   SubScriptionCategory SubScriptionCategory_SubScriptionCategoryCode_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionCategory"
    ADD CONSTRAINT "SubScriptionCategory_SubScriptionCategoryCode_key" UNIQUE ("SubScriptionCategoryCode");
 s   ALTER TABLE ONLY "LKP"."SubScriptionCategory" DROP CONSTRAINT "SubScriptionCategory_SubScriptionCategoryCode_key";
       LKP            postgres    false    313            %           2606    17765 .   SubScriptionCategory SubScriptionCategory_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionCategory"
    ADD CONSTRAINT "SubScriptionCategory_pkey" PRIMARY KEY ("SubScriptionCategoryID");
 [   ALTER TABLE ONLY "LKP"."SubScriptionCategory" DROP CONSTRAINT "SubScriptionCategory_pkey";
       LKP            postgres    false    313            )           2606    17767 W   SubScriptionSubCategory SubScriptionSubCategory_SubScriptionSubCategoryCode_SubScri_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory"
    ADD CONSTRAINT "SubScriptionSubCategory_SubScriptionSubCategoryCode_SubScri_key" UNIQUE ("SubScriptionSubCategoryCode", "SubScriptionCategoryID");
 �   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory" DROP CONSTRAINT "SubScriptionSubCategory_SubScriptionSubCategoryCode_SubScri_key";
       LKP            postgres    false    315    315            +           2606    17769 4   SubScriptionSubCategory SubScriptionSubCategory_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory"
    ADD CONSTRAINT "SubScriptionSubCategory_pkey" PRIMARY KEY ("SubScriptionSubCategoryID");
 a   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory" DROP CONSTRAINT "SubScriptionSubCategory_pkey";
       LKP            postgres    false    315            /           2606    17771 :   SubScriptionType SubScriptionType_SubScriptionTypeCode_key 
   CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionType"
    ADD CONSTRAINT "SubScriptionType_SubScriptionTypeCode_key" UNIQUE ("SubScriptionTypeCode");
 g   ALTER TABLE ONLY "LKP"."SubScriptionType" DROP CONSTRAINT "SubScriptionType_SubScriptionTypeCode_key";
       LKP            postgres    false    317            1           2606    17773 &   SubScriptionType SubScriptionType_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY "LKP"."SubScriptionType"
    ADD CONSTRAINT "SubScriptionType_pkey" PRIMARY KEY ("SubScriptionTypeID");
 S   ALTER TABLE ONLY "LKP"."SubScriptionType" DROP CONSTRAINT "SubScriptionType_pkey";
       LKP            postgres    false    317            3           2606    17775 (   ExecutionProgress ExecutionProgress_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY "TRACK"."ExecutionProgress"
    ADD CONSTRAINT "ExecutionProgress_pkey" PRIMARY KEY ("ExecutionProgressID");
 W   ALTER TABLE ONLY "TRACK"."ExecutionProgress" DROP CONSTRAINT "ExecutionProgress_pkey";
       TRACK            postgres    false    319            7           2606    17777 (   ClientBankAccount ClientBankAccount_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY "XREF"."ClientBankAccount"
    ADD CONSTRAINT "ClientBankAccount_pkey" PRIMARY KEY ("ClientBankAccountID");
 V   ALTER TABLE ONLY "XREF"."ClientBankAccount" DROP CONSTRAINT "ClientBankAccount_pkey";
       XREF            postgres    false    321            ;           2606    17779 ,   ClientContactPerson ClientContactPerson_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientContactPerson"
    ADD CONSTRAINT "ClientContactPerson_pkey" PRIMARY KEY ("ClientContactPersonID");
 Z   ALTER TABLE ONLY "XREF"."ClientContactPerson" DROP CONSTRAINT "ClientContactPerson_pkey";
       XREF            postgres    false    323            ?           2606    17781    ClientImage ClientImage_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY "XREF"."ClientImage"
    ADD CONSTRAINT "ClientImage_pkey" PRIMARY KEY ("ClientImageID");
 J   ALTER TABLE ONLY "XREF"."ClientImage" DROP CONSTRAINT "ClientImage_pkey";
       XREF            postgres    false    325            C           2606    17783 "   ClientLocation ClientLocation_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY "XREF"."ClientLocation"
    ADD CONSTRAINT "ClientLocation_pkey" PRIMARY KEY ("ClientLocationID");
 P   ALTER TABLE ONLY "XREF"."ClientLocation" DROP CONSTRAINT "ClientLocation_pkey";
       XREF            postgres    false    327            G           2606    17785 )   ClientRole ClientRole_RoleID_ClientID_key 
   CONSTRAINT     x   ALTER TABLE ONLY "XREF"."ClientRole"
    ADD CONSTRAINT "ClientRole_RoleID_ClientID_key" UNIQUE ("RoleID", "ClientID");
 W   ALTER TABLE ONLY "XREF"."ClientRole" DROP CONSTRAINT "ClientRole_RoleID_ClientID_key";
       XREF            postgres    false    329    329            I           2606    17787    ClientRole ClientRole_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY "XREF"."ClientRole"
    ADD CONSTRAINT "ClientRole_pkey" PRIMARY KEY ("ClientRoleID");
 H   ALTER TABLE ONLY "XREF"."ClientRole" DROP CONSTRAINT "ClientRole_pkey";
       XREF            postgres    false    329            P           2606    17789    UserEmail UserEmail_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY "XREF"."UserEmail"
    ADD CONSTRAINT "UserEmail_pkey" PRIMARY KEY ("UserEmailID");
 F   ALTER TABLE ONLY "XREF"."UserEmail" DROP CONSTRAINT "UserEmail_pkey";
       XREF            postgres    false    331            T           2606    17791    UserLocation UserLocation_pkey 
   CONSTRAINT     n   ALTER TABLE ONLY "XREF"."UserLocation"
    ADD CONSTRAINT "UserLocation_pkey" PRIMARY KEY ("UserLocationID");
 L   ALTER TABLE ONLY "XREF"."UserLocation" DROP CONSTRAINT "UserLocation_pkey";
       XREF            postgres    false    333            Y           2606    17793    UserPhone UserPhone_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY "XREF"."UserPhone"
    ADD CONSTRAINT "UserPhone_pkey" PRIMARY KEY ("UserPhoneID");
 F   ALTER TABLE ONLY "XREF"."UserPhone" DROP CONSTRAINT "UserPhone_pkey";
       XREF            postgres    false    335            ]           2606    17795 *   UserProfileSetting UserProfileSetting_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserProfileSetting"
    ADD CONSTRAINT "UserProfileSetting_pkey" PRIMARY KEY ("UserProfileSettingID");
 X   ALTER TABLE ONLY "XREF"."UserProfileSetting" DROP CONSTRAINT "UserProfileSetting_pkey";
       XREF            postgres    false    337            a           2606    17797    UserRole UserRole_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY "XREF"."UserRole"
    ADD CONSTRAINT "UserRole_pkey" PRIMARY KEY ("UserRoleID");
 D   ALTER TABLE ONLY "XREF"."UserRole" DROP CONSTRAINT "UserRole_pkey";
       XREF            postgres    false    339            c           2606    17799 ,   ClientConfiguration ClientConfiguration_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY "XREFCONFIG"."ClientConfiguration"
    ADD CONSTRAINT "ClientConfiguration_pkey" PRIMARY KEY ("ClientConfigurationID");
 `   ALTER TABLE ONLY "XREFCONFIG"."ClientConfiguration" DROP CONSTRAINT "ClientConfiguration_pkey";
    
   XREFCONFIG            postgres    false    341            g           2606    18172    refreshtoken refreshtoken_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT refreshtoken_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.refreshtoken DROP CONSTRAINT refreshtoken_pkey;
       public            postgres    false    343            i           2606    18174    roles roles_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.roles DROP CONSTRAINT roles_pkey;
       public            postgres    false    345            k           2606    18176    user_roles user_roles_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);
 D   ALTER TABLE ONLY public.user_roles DROP CONSTRAINT user_roles_pkey;
       public            postgres    false    347    347            m           2606    18178    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    348            u           1259    17800    IX_Configuration_00    INDEX     �   CREATE INDEX "IX_Configuration_00" ON "CONFIG"."Configuration" USING btree ("ConfigurationID", "ConfigurationCode", "ConfigurationValue", "IsDisabled");
 +   DROP INDEX "CONFIG"."IX_Configuration_00";
       CONFIG            postgres    false    261    261    261    261            v           1259    17801    IX_Configuration_01    INDEX     u   CREATE INDEX "IX_Configuration_01" ON "CONFIG"."Configuration" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 +   DROP INDEX "CONFIG"."IX_Configuration_01";
       CONFIG            postgres    false    261    261    261            }           1259    17802    IX_Client_00    INDEX     W   CREATE INDEX "IX_Client_00" ON "DATA"."Client" USING btree ("ClientID", "IsDisabled");
 "   DROP INDEX "DATA"."IX_Client_00";
       DATA            postgres    false    263    263            ~           1259    17803    IX_Client_01    INDEX     e   CREATE INDEX "IX_Client_01" ON "DATA"."Client" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 "   DROP INDEX "DATA"."IX_Client_01";
       DATA            postgres    false    263    263    263            �           1259    17804    IX_Geography_00    INDEX     �   CREATE INDEX "IX_Geography_00" ON "DATA"."Geography" USING btree ("GeographyID", "ParentGeographyID", "GeographyTypeID", "CountryID", "GeographyCode", "IsDisabled");
 %   DROP INDEX "DATA"."IX_Geography_00";
       DATA            postgres    false    265    265    265    265    265    265            �           1259    17805    IX_Geography_01    INDEX     k   CREATE INDEX "IX_Geography_01" ON "DATA"."Geography" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 %   DROP INDEX "DATA"."IX_Geography_01";
       DATA            postgres    false    265    265    265            �           1259    17806    IX_LocationContactPerson_00    INDEX     �   CREATE INDEX "IX_LocationContactPerson_00" ON "DATA"."LocationContactPerson" USING btree ("LocationContactPersonID", "LocationID", "IsDisabled");
 1   DROP INDEX "DATA"."IX_LocationContactPerson_00";
       DATA            postgres    false    268    268    268            �           1259    17807    IX_LocationContactPerson_01    INDEX     �   CREATE INDEX "IX_LocationContactPerson_01" ON "DATA"."LocationContactPerson" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 1   DROP INDEX "DATA"."IX_LocationContactPerson_01";
       DATA            postgres    false    268    268    268            �           1259    17808    IX_LocationContactPerson_02    INDEX     �   CREATE INDEX "IX_LocationContactPerson_02" ON "DATA"."LocationContactPerson" USING btree ("FirstName", "LastName", "IsDisabled");
 1   DROP INDEX "DATA"."IX_LocationContactPerson_02";
       DATA            postgres    false    268    268    268            �           1259    17809    IX_Location_00    INDEX     �   CREATE INDEX "IX_Location_00" ON "DATA"."Location" USING btree ("LocationID", "ParentLocationID", "LocationTypeID", "CountryID", "ClientID", "GeographyID", "IsDisabled");
 $   DROP INDEX "DATA"."IX_Location_00";
       DATA            postgres    false    267    267    267    267    267    267    267            �           1259    17810    IX_Location_01    INDEX     �   CREATE INDEX "IX_Location_01" ON "DATA"."Location" USING btree ("LocationName", "LocationCode", "AddressLine1", "AddressLine2", "AddressLine3", "City", "Locality", "PostalCode");
 $   DROP INDEX "DATA"."IX_Location_01";
       DATA            postgres    false    267    267    267    267    267    267    267    267            �           1259    17811    IX_Location_02    INDEX     i   CREATE INDEX "IX_Location_02" ON "DATA"."Location" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 $   DROP INDEX "DATA"."IX_Location_02";
       DATA            postgres    false    267    267    267            �           1259    17812 
   IX_User_00    INDEX     ]   CREATE INDEX "IX_User_00" ON "DATA"."User" USING btree ("UserID", "ClientID", "IsDisabled");
     DROP INDEX "DATA"."IX_User_00";
       DATA            postgres    false    271    271    271            �           1259    17813 
   IX_User_01    INDEX     T   CREATE INDEX "IX_User_01" ON "DATA"."User" USING btree ("LoginName", "IsDisabled");
     DROP INDEX "DATA"."IX_User_01";
       DATA            postgres    false    271    271            �           1259    17814 
   IX_User_02    INDEX     a   CREATE INDEX "IX_User_02" ON "DATA"."User" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
     DROP INDEX "DATA"."IX_User_02";
       DATA            postgres    false    271    271    271            �           1259    17815    IX_DatabaseError_00    INDEX     m   CREATE INDEX "IX_DatabaseError_00" ON "ERROR"."DatabaseError" USING btree ("DatabaseErrorID", "IsDisabled");
 *   DROP INDEX "ERROR"."IX_DatabaseError_00";
       ERROR            postgres    false    273    273            �           1259    17816    IX_DatabaseError_01    INDEX     t   CREATE INDEX "IX_DatabaseError_01" ON "ERROR"."DatabaseError" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 *   DROP INDEX "ERROR"."IX_DatabaseError_01";
       ERROR            postgres    false    273    273    273            �           1259    17817    IX_FrontEndError_00    INDEX     m   CREATE INDEX "IX_FrontEndError_00" ON "ERROR"."FrontEndError" USING btree ("FrontEndErrorID", "IsDisabled");
 *   DROP INDEX "ERROR"."IX_FrontEndError_00";
       ERROR            postgres    false    275    275            �           1259    17818    IX_FrontEndError_01    INDEX     t   CREATE INDEX "IX_FrontEndError_01" ON "ERROR"."FrontEndError" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 *   DROP INDEX "ERROR"."IX_FrontEndError_01";
       ERROR            postgres    false    275    275    275            �           1259    17819    IX_AccountType_00    INDEX     x   CREATE INDEX "IX_AccountType_00" ON "LKP"."AccountType" USING btree ("AccountTypeID", "AccountTypeCode", "IsDisabled");
 &   DROP INDEX "LKP"."IX_AccountType_00";
       LKP            postgres    false    277    277    277            �           1259    17820    IX_AccountType_01    INDEX     n   CREATE INDEX "IX_AccountType_01" ON "LKP"."AccountType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 &   DROP INDEX "LKP"."IX_AccountType_01";
       LKP            postgres    false    277    277    277            �           1259    17821    IX_ApplicationFeature_00    INDEX     �   CREATE INDEX "IX_ApplicationFeature_00" ON "LKP"."ApplicationFeature" USING btree ("ApplicationFeatureID", "ApplicationID", "ApplicationFeatureCode", "IsDisabled");
 -   DROP INDEX "LKP"."IX_ApplicationFeature_00";
       LKP            postgres    false    280    280    280    280            �           1259    17822    IX_ApplicationFeature_01    INDEX     |   CREATE INDEX "IX_ApplicationFeature_01" ON "LKP"."ApplicationFeature" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 -   DROP INDEX "LKP"."IX_ApplicationFeature_01";
       LKP            postgres    false    280    280    280            �           1259    17823    IX_Application_00    INDEX     x   CREATE INDEX "IX_Application_00" ON "LKP"."Application" USING btree ("ApplicationID", "ApplicationCode", "IsDisabled");
 &   DROP INDEX "LKP"."IX_Application_00";
       LKP            postgres    false    279    279    279            �           1259    17824    IX_Application_01    INDEX     n   CREATE INDEX "IX_Application_01" ON "LKP"."Application" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 &   DROP INDEX "LKP"."IX_Application_01";
       LKP            postgres    false    279    279    279            �           1259    17825 
   IX_Bank_00    INDEX     i   CREATE INDEX "IX_Bank_00" ON "LKP"."Bank" USING btree ("BankID", "CountryID", "BankCode", "IsDisabled");
    DROP INDEX "LKP"."IX_Bank_00";
       LKP            postgres    false    283    283    283    283            �           1259    17826 
   IX_Bank_01    INDEX     `   CREATE INDEX "IX_Bank_01" ON "LKP"."Bank" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
    DROP INDEX "LKP"."IX_Bank_01";
       LKP            postgres    false    283    283    283            �           1259    17827    IX_BloodGroup_00    INDEX     t   CREATE INDEX "IX_BloodGroup_00" ON "LKP"."BloodGroup" USING btree ("BloodGroupID", "BloodGroupCode", "IsDisabled");
 %   DROP INDEX "LKP"."IX_BloodGroup_00";
       LKP            postgres    false    285    285    285            �           1259    17828    IX_BloodGroup_01    INDEX     l   CREATE INDEX "IX_BloodGroup_01" ON "LKP"."BloodGroup" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 %   DROP INDEX "LKP"."IX_BloodGroup_01";
       LKP            postgres    false    285    285    285            �           1259    17829    IX_Branch_00    INDEX     n   CREATE INDEX "IX_Branch_00" ON "LKP"."Branch" USING btree ("BranchID", "BankID", "BranchCode", "IsDisabled");
 !   DROP INDEX "LKP"."IX_Branch_00";
       LKP            postgres    false    287    287    287    287            �           1259    17830    IX_Branch_01    INDEX     d   CREATE INDEX "IX_Branch_01" ON "LKP"."Branch" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 !   DROP INDEX "LKP"."IX_Branch_01";
       LKP            postgres    false    287    287    287            �           1259    17831    IX_Country_00    INDEX     h   CREATE INDEX "IX_Country_00" ON "LKP"."Country" USING btree ("CountryID", "CountryCode", "IsDisabled");
 "   DROP INDEX "LKP"."IX_Country_00";
       LKP            postgres    false    289    289    289            �           1259    17832    IX_Country_01    INDEX     f   CREATE INDEX "IX_Country_01" ON "LKP"."Country" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 "   DROP INDEX "LKP"."IX_Country_01";
       LKP            postgres    false    289    289    289            �           1259    17833    IX_EmailType_00    INDEX     p   CREATE INDEX "IX_EmailType_00" ON "LKP"."EmailType" USING btree ("EmailTypeID", "EmailTypeCode", "IsDisabled");
 $   DROP INDEX "LKP"."IX_EmailType_00";
       LKP            postgres    false    291    291    291            �           1259    17834    IX_EmailType_01    INDEX     j   CREATE INDEX "IX_EmailType_01" ON "LKP"."EmailType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 $   DROP INDEX "LKP"."IX_EmailType_01";
       LKP            postgres    false    291    291    291            �           1259    17835    IX_EmailUseType_00    INDEX     |   CREATE INDEX "IX_EmailUseType_00" ON "LKP"."EmailUseType" USING btree ("EmailUseTypeID", "EmailUseTypeCode", "IsDisabled");
 '   DROP INDEX "LKP"."IX_EmailUseType_00";
       LKP            postgres    false    293    293    293            �           1259    17836    IX_EmailUseType_01    INDEX     p   CREATE INDEX "IX_EmailUseType_01" ON "LKP"."EmailUseType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 '   DROP INDEX "LKP"."IX_EmailUseType_01";
       LKP            postgres    false    293    293    293            �           1259    17837    IX_Gender_00    INDEX     d   CREATE INDEX "IX_Gender_00" ON "LKP"."Gender" USING btree ("GenderID", "GenderCode", "IsDisabled");
 !   DROP INDEX "LKP"."IX_Gender_00";
       LKP            postgres    false    295    295    295            �           1259    17838    IX_Gender_01    INDEX     d   CREATE INDEX "IX_Gender_01" ON "LKP"."Gender" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 !   DROP INDEX "LKP"."IX_Gender_01";
       LKP            postgres    false    295    295    295            �           1259    17839    IX_GeographyType_00    INDEX     �   CREATE INDEX "IX_GeographyType_00" ON "LKP"."GeographyType" USING btree ("GeographyTypeID", "ParentGeographyTypeID", "CountryID", "GeographyTypeCode", "IsDisabled");
 (   DROP INDEX "LKP"."IX_GeographyType_00";
       LKP            postgres    false    297    297    297    297    297            �           1259    17840    IX_GeographyType_01    INDEX     r   CREATE INDEX "IX_GeographyType_01" ON "LKP"."GeographyType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 (   DROP INDEX "LKP"."IX_GeographyType_01";
       LKP            postgres    false    297    297    297            �           1259    17841    IX_Hobby_00    INDEX     `   CREATE INDEX "IX_Hobby_00" ON "LKP"."Hobby" USING btree ("HobbyID", "HobbyCode", "IsDisabled");
     DROP INDEX "LKP"."IX_Hobby_00";
       LKP            postgres    false    299    299    299            �           1259    17842    IX_Hobby_01    INDEX     b   CREATE INDEX "IX_Hobby_01" ON "LKP"."Hobby" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
     DROP INDEX "LKP"."IX_Hobby_01";
       LKP            postgres    false    299    299    299            �           1259    17843    IX_Honorific_00    INDEX     _   CREATE INDEX "IX_Honorific_00" ON "LKP"."Honorific" USING btree ("HonorificID", "IsDisabled");
 $   DROP INDEX "LKP"."IX_Honorific_00";
       LKP            postgres    false    301    301            �           1259    17844    IX_Honorific_01    INDEX     j   CREATE INDEX "IX_Honorific_01" ON "LKP"."Honorific" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 $   DROP INDEX "LKP"."IX_Honorific_01";
       LKP            postgres    false    301    301    301            �           1259    17845    IX_LocationType_00    INDEX     �   CREATE INDEX "IX_LocationType_00" ON "LKP"."LocationType" USING btree ("LocationTypeID", "ParentLocationTypeID", "CountryID", "ClientID", "IsDisabled");
 '   DROP INDEX "LKP"."IX_LocationType_00";
       LKP            postgres    false    303    303    303    303    303            �           1259    17846    IX_LocationType_01    INDEX     p   CREATE INDEX "IX_LocationType_01" ON "LKP"."LocationType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 '   DROP INDEX "LKP"."IX_LocationType_01";
       LKP            postgres    false    303    303    303                       1259    17847    IX_MaritalStatus_00    INDEX     �   CREATE INDEX "IX_MaritalStatus_00" ON "LKP"."MaritalStatus" USING btree ("MaritalStatusID", "MaritalStatusCode", "IsDisabled");
 (   DROP INDEX "LKP"."IX_MaritalStatus_00";
       LKP            postgres    false    305    305    305                       1259    17848    IX_MaritalStatus_01    INDEX     r   CREATE INDEX "IX_MaritalStatus_01" ON "LKP"."MaritalStatus" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 (   DROP INDEX "LKP"."IX_MaritalStatus_01";
       LKP            postgres    false    305    305    305            
           1259    17849    IX_PhoneLineType_00    INDEX     �   CREATE INDEX "IX_PhoneLineType_00" ON "LKP"."PhoneLineType" USING btree ("PhoneLineTypeID", "PhoneLineTypeCode", "IsDisabled");
 (   DROP INDEX "LKP"."IX_PhoneLineType_00";
       LKP            postgres    false    307    307    307                       1259    17850    IX_PhoneLineType_01    INDEX     r   CREATE INDEX "IX_PhoneLineType_01" ON "LKP"."PhoneLineType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 (   DROP INDEX "LKP"."IX_PhoneLineType_01";
       LKP            postgres    false    307    307    307                       1259    17851    IX_PhoneUseType_00    INDEX     |   CREATE INDEX "IX_PhoneUseType_00" ON "LKP"."PhoneUseType" USING btree ("PhoneUseTypeID", "PhoneUseTypeCode", "IsDisabled");
 '   DROP INDEX "LKP"."IX_PhoneUseType_00";
       LKP            postgres    false    309    309    309                       1259    17852    IX_PhoneUseType_01    INDEX     p   CREATE INDEX "IX_PhoneUseType_01" ON "LKP"."PhoneUseType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 '   DROP INDEX "LKP"."IX_PhoneUseType_01";
       LKP            postgres    false    309    309    309                       1259    17853 
   IX_Role_00    INDEX     h   CREATE INDEX "IX_Role_00" ON "LKP"."Role" USING btree ("RoleID", "RoleName", "RoleCode", "IsDisabled");
    DROP INDEX "LKP"."IX_Role_00";
       LKP            postgres    false    311    311    311    311                       1259    17854 
   IX_Role_01    INDEX     `   CREATE INDEX "IX_Role_01" ON "LKP"."Role" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
    DROP INDEX "LKP"."IX_Role_01";
       LKP            postgres    false    311    311    311                        1259    17855    IX_SubScriptionCategory_00    INDEX     �   CREATE INDEX "IX_SubScriptionCategory_00" ON "LKP"."SubScriptionCategory" USING btree ("SubScriptionCategoryID", "SubScriptionCategoryCode", "IsDisabled");
 /   DROP INDEX "LKP"."IX_SubScriptionCategory_00";
       LKP            postgres    false    313    313    313            !           1259    17856    IX_SubScriptionCategory_01    INDEX     �   CREATE INDEX "IX_SubScriptionCategory_01" ON "LKP"."SubScriptionCategory" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 /   DROP INDEX "LKP"."IX_SubScriptionCategory_01";
       LKP            postgres    false    313    313    313            &           1259    17857    IX_SubScriptionSubCategory_00    INDEX     �   CREATE INDEX "IX_SubScriptionSubCategory_00" ON "LKP"."SubScriptionSubCategory" USING btree ("SubScriptionSubCategoryID", "SubScriptionCategoryID", "SubScriptionSubCategoryCode", "IsDisabled");
 2   DROP INDEX "LKP"."IX_SubScriptionSubCategory_00";
       LKP            postgres    false    315    315    315    315            '           1259    17858    IX_SubScriptionSubCategory_01    INDEX     �   CREATE INDEX "IX_SubScriptionSubCategory_01" ON "LKP"."SubScriptionSubCategory" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 2   DROP INDEX "LKP"."IX_SubScriptionSubCategory_01";
       LKP            postgres    false    315    315    315            ,           1259    17859    IX_SubScriptionType_00    INDEX     �   CREATE INDEX "IX_SubScriptionType_00" ON "LKP"."SubScriptionType" USING btree ("SubScriptionTypeID", "SubScriptionTypeCode", "IsDisabled");
 +   DROP INDEX "LKP"."IX_SubScriptionType_00";
       LKP            postgres    false    317    317    317            -           1259    17860    IX_SubScriptionTypee_01    INDEX     y   CREATE INDEX "IX_SubScriptionTypee_01" ON "LKP"."SubScriptionType" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 ,   DROP INDEX "LKP"."IX_SubScriptionTypee_01";
       LKP            postgres    false    317    317    317            4           1259    17861    IX_ExecutionProgress_00    INDEX     y   CREATE INDEX "IX_ExecutionProgress_00" ON "TRACK"."ExecutionProgress" USING btree ("ExecutionProgressID", "IsDisabled");
 .   DROP INDEX "TRACK"."IX_ExecutionProgress_00";
       TRACK            postgres    false    319    319            5           1259    17862    IX_ExecutionProgress_01    INDEX     |   CREATE INDEX "IX_ExecutionProgress_01" ON "TRACK"."ExecutionProgress" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 .   DROP INDEX "TRACK"."IX_ExecutionProgress_01";
       TRACK            postgres    false    319    319    319            8           1259    17863    IX_ClientBankAccount_00    INDEX     �   CREATE INDEX "IX_ClientBankAccount_00" ON "XREF"."ClientBankAccount" USING btree ("ClientBankAccountID", "ClientID", "AccountNumber", "IsDisabled");
 -   DROP INDEX "XREF"."IX_ClientBankAccount_00";
       XREF            postgres    false    321    321    321    321            9           1259    17864    IX_ClientBankAccount_01    INDEX     {   CREATE INDEX "IX_ClientBankAccount_01" ON "XREF"."ClientBankAccount" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 -   DROP INDEX "XREF"."IX_ClientBankAccount_01";
       XREF            postgres    false    321    321    321            <           1259    17865    IX_ClientContactPerson_00    INDEX     �   CREATE INDEX "IX_ClientContactPerson_00" ON "XREF"."ClientContactPerson" USING btree ("ClientContactPersonID", "ClientID", "IsDisabled");
 /   DROP INDEX "XREF"."IX_ClientContactPerson_00";
       XREF            postgres    false    323    323    323            =           1259    17866    IX_ClientContactPerson_01    INDEX        CREATE INDEX "IX_ClientContactPerson_01" ON "XREF"."ClientContactPerson" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 /   DROP INDEX "XREF"."IX_ClientContactPerson_01";
       XREF            postgres    false    323    323    323            @           1259    17867    IX_ClientImage_00    INDEX     r   CREATE INDEX "IX_ClientImage_00" ON "XREF"."ClientImage" USING btree ("ClientImageID", "ClientID", "IsDisabled");
 '   DROP INDEX "XREF"."IX_ClientImage_00";
       XREF            postgres    false    325    325    325            A           1259    17868    IX_ClientImage_01    INDEX     o   CREATE INDEX "IX_ClientImage_01" ON "XREF"."ClientImage" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 '   DROP INDEX "XREF"."IX_ClientImage_01";
       XREF            postgres    false    325    325    325            D           1259    17869    IX_ClientLocation_00    INDEX     {   CREATE INDEX "IX_ClientLocation_00" ON "XREF"."ClientLocation" USING btree ("ClientLocationID", "ClientID", "IsDisabled");
 *   DROP INDEX "XREF"."IX_ClientLocation_00";
       XREF            postgres    false    327    327    327            E           1259    17870    IX_ClientLocation_01    INDEX     u   CREATE INDEX "IX_ClientLocation_01" ON "XREF"."ClientLocation" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 *   DROP INDEX "XREF"."IX_ClientLocation_01";
       XREF            postgres    false    327    327    327            J           1259    17871    IX_ClientRole_00    INDEX     i   CREATE INDEX "IX_ClientRole_00" ON "XREF"."ClientRole" USING btree ("RoleID", "ClientID", "IsDisabled");
 &   DROP INDEX "XREF"."IX_ClientRole_00";
       XREF            postgres    false    329    329    329            K           1259    17872    IX_ClientRole_01    INDEX     m   CREATE INDEX "IX_ClientRole_01" ON "XREF"."ClientRole" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 &   DROP INDEX "XREF"."IX_ClientRole_01";
       XREF            postgres    false    329    329    329            L           1259    17873    IX_UserEmail_00    INDEX     [   CREATE INDEX "IX_UserEmail_00" ON "XREF"."UserEmail" USING btree ("UserID", "IsDisabled");
 %   DROP INDEX "XREF"."IX_UserEmail_00";
       XREF            postgres    false    331    331            M           1259    17874    IX_UserEmail_01    INDEX     �   CREATE INDEX "IX_UserEmail_01" ON "XREF"."UserEmail" USING btree ("UserID", "EmailAddress", "EmailTypeID", "EmailUseTypeID", "IsPrimaryEmail");
 %   DROP INDEX "XREF"."IX_UserEmail_01";
       XREF            postgres    false    331    331    331    331    331            N           1259    17875    IX_UserEmail_02    INDEX     k   CREATE INDEX "IX_UserEmail_02" ON "XREF"."UserEmail" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 %   DROP INDEX "XREF"."IX_UserEmail_02";
       XREF            postgres    false    331    331    331            Q           1259    17876    IX_UserLocation_00    INDEX     i   CREATE INDEX "IX_UserLocation_00" ON "XREF"."UserLocation" USING btree ("UserLocationID", "IsDisabled");
 (   DROP INDEX "XREF"."IX_UserLocation_00";
       XREF            postgres    false    333    333            R           1259    17877    IX_UserLocation_01    INDEX     q   CREATE INDEX "IX_UserLocation_01" ON "XREF"."UserLocation" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 (   DROP INDEX "XREF"."IX_UserLocation_01";
       XREF            postgres    false    333    333    333            U           1259    17878    IX_UserPhone_00    INDEX     [   CREATE INDEX "IX_UserPhone_00" ON "XREF"."UserPhone" USING btree ("UserID", "IsDisabled");
 %   DROP INDEX "XREF"."IX_UserPhone_00";
       XREF            postgres    false    335    335            V           1259    17879    IX_UserPhone_01    INDEX     �   CREATE INDEX "IX_UserPhone_01" ON "XREF"."UserPhone" USING btree ("UserID", "PhoneNumber", "PhoneLineTypeID", "PhoneUseTypeID", "IsPrimaryPhone");
 %   DROP INDEX "XREF"."IX_UserPhone_01";
       XREF            postgres    false    335    335    335    335    335            W           1259    17880    IX_UserPhone_02    INDEX     k   CREATE INDEX "IX_UserPhone_02" ON "XREF"."UserPhone" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 %   DROP INDEX "XREF"."IX_UserPhone_02";
       XREF            postgres    false    335    335    335            Z           1259    17881    IX_UserProfileSetting_00    INDEX     w   CREATE INDEX "IX_UserProfileSetting_00" ON "XREF"."UserProfileSetting" USING btree ("UserID", "UserID", "IsDisabled");
 .   DROP INDEX "XREF"."IX_UserProfileSetting_00";
       XREF            postgres    false    337    337            [           1259    17882    IX_UserProfileSetting_01    INDEX     }   CREATE INDEX "IX_UserProfileSetting_01" ON "XREF"."UserProfileSetting" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 .   DROP INDEX "XREF"."IX_UserProfileSetting_01";
       XREF            postgres    false    337    337    337            ^           1259    17883    IX_UserRole_00    INDEX     q   CREATE INDEX "IX_UserRole_00" ON "XREF"."UserRole" USING btree ("UserID", "RoleID", "LocationID", "IsDisabled");
 $   DROP INDEX "XREF"."IX_UserRole_00";
       XREF            postgres    false    339    339    339    339            _           1259    17884    IX_UserRole_01    INDEX     i   CREATE INDEX "IX_UserRole_01" ON "XREF"."UserRole" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 $   DROP INDEX "XREF"."IX_UserRole_01";
       XREF            postgres    false    339    339    339            d           1259    17885    IX_ClientConfiguration_00    INDEX     ~   CREATE INDEX "IX_ClientConfiguration_00" ON "XREFCONFIG"."ClientConfiguration" USING btree ("ConfigurationID", "IsDisabled");
 5   DROP INDEX "XREFCONFIG"."IX_ClientConfiguration_00";
    
   XREFCONFIG            postgres    false    341    341            e           1259    17886    IX_ClientConfiguration_01    INDEX     �   CREATE INDEX "IX_ClientConfiguration_01" ON "XREFCONFIG"."ClientConfiguration" USING btree ("CreatedOn", "UpdatedOn", "IsDisabled");
 5   DROP INDEX "XREFCONFIG"."IX_ClientConfiguration_01";
    
   XREFCONFIG            postgres    false    341    341    341            n           2606    17887    Client Client_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Client"
    ADD CONSTRAINT "Client_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 J   ALTER TABLE ONLY "DATA"."Client" DROP CONSTRAINT "Client_CountryID_fkey";
       DATA          postgres    false    5067    289    263            o           2606    17892 "   Geography Geography_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Geography"
    ADD CONSTRAINT "Geography_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 P   ALTER TABLE ONLY "DATA"."Geography" DROP CONSTRAINT "Geography_CountryID_fkey";
       DATA          postgres    false    265    289    5067            p           2606    17897 (   Geography Geography_GeographyTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Geography"
    ADD CONSTRAINT "Geography_GeographyTypeID_fkey" FOREIGN KEY ("GeographyTypeID") REFERENCES "LKP"."GeographyType"("GeographyTypeID");
 V   ALTER TABLE ONLY "DATA"."Geography" DROP CONSTRAINT "Geography_GeographyTypeID_fkey";
       DATA          postgres    false    265    5097    297            t           2606    17902 9   LocationContactPerson LocationContactPerson_GenderID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."LocationContactPerson"
    ADD CONSTRAINT "LocationContactPerson_GenderID_fkey" FOREIGN KEY ("GenderID") REFERENCES "LKP"."Gender"("GenderID");
 g   ALTER TABLE ONLY "DATA"."LocationContactPerson" DROP CONSTRAINT "LocationContactPerson_GenderID_fkey";
       DATA          postgres    false    295    5091    268            u           2606    17907 ;   LocationContactPerson LocationContactPerson_LocationID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."LocationContactPerson"
    ADD CONSTRAINT "LocationContactPerson_LocationID_fkey" FOREIGN KEY ("LocationID") REFERENCES "DATA"."Location"("LocationID");
 i   ALTER TABLE ONLY "DATA"."LocationContactPerson" DROP CONSTRAINT "LocationContactPerson_LocationID_fkey";
       DATA          postgres    false    5001    267    268            q           2606    17912     Location Location_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Location"
    ADD CONSTRAINT "Location_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 N   ALTER TABLE ONLY "DATA"."Location" DROP CONSTRAINT "Location_CountryID_fkey";
       DATA          postgres    false    289    267    5067            r           2606    17917 "   Location Location_GeographyID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Location"
    ADD CONSTRAINT "Location_GeographyID_fkey" FOREIGN KEY ("GeographyID") REFERENCES "DATA"."Geography"("GeographyID");
 P   ALTER TABLE ONLY "DATA"."Location" DROP CONSTRAINT "Location_GeographyID_fkey";
       DATA          postgres    false    267    265    4994            s           2606    17922 %   Location Location_LocationTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."Location"
    ADD CONSTRAINT "Location_LocationTypeID_fkey" FOREIGN KEY ("LocationTypeID") REFERENCES "LKP"."LocationType"("LocationTypeID");
 S   ALTER TABLE ONLY "DATA"."Location" DROP CONSTRAINT "Location_LocationTypeID_fkey";
       DATA          postgres    false    267    5121    303            v           2606    17927    User User_BloodGroupID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_BloodGroupID_fkey" FOREIGN KEY ("BloodGroupID") REFERENCES "LKP"."BloodGroup"("BloodGroupID");
 I   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_BloodGroupID_fkey";
       DATA          postgres    false    5053    271    285            w           2606    17932    User User_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 E   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_ClientID_fkey";
       DATA          postgres    false    263    271    4988            x           2606    17937    User User_GenderD_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_GenderD_fkey" FOREIGN KEY ("GenderD") REFERENCES "LKP"."Gender"("GenderID");
 D   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_GenderD_fkey";
       DATA          postgres    false    295    271    5091            y           2606    17942    User User_HonorificID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_HonorificID_fkey" FOREIGN KEY ("HonorificID") REFERENCES "LKP"."Honorific"("HonorificID");
 H   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_HonorificID_fkey";
       DATA          postgres    false    5113    271    301            z           2606    17947    User User_MaritalStatusID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "DATA"."User"
    ADD CONSTRAINT "User_MaritalStatusID_fkey" FOREIGN KEY ("MaritalStatusID") REFERENCES "LKP"."MaritalStatus"("MaritalStatusID");
 L   ALTER TABLE ONLY "DATA"."User" DROP CONSTRAINT "User_MaritalStatusID_fkey";
       DATA          postgres    false    5129    271    305            {           2606    17952 8   ApplicationFeature ApplicationFeature_ApplicationID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."ApplicationFeature"
    ADD CONSTRAINT "ApplicationFeature_ApplicationID_fkey" FOREIGN KEY ("ApplicationID") REFERENCES "LKP"."Application"("ApplicationID");
 e   ALTER TABLE ONLY "LKP"."ApplicationFeature" DROP CONSTRAINT "ApplicationFeature_ApplicationID_fkey";
       LKP          postgres    false    5031    280    279            |           2606    17957    Bank Bank_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."Bank"
    ADD CONSTRAINT "Bank_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 E   ALTER TABLE ONLY "LKP"."Bank" DROP CONSTRAINT "Bank_CountryID_fkey";
       LKP          postgres    false    5067    283    289            }           2606    17962    Branch Branch_BankID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."Branch"
    ADD CONSTRAINT "Branch_BankID_fkey" FOREIGN KEY ("BankID") REFERENCES "LKP"."Bank"("BankID");
 F   ALTER TABLE ONLY "LKP"."Branch" DROP CONSTRAINT "Branch_BankID_fkey";
       LKP          postgres    false    5045    287    283            ~           2606    17967 *   GeographyType GeographyType_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."GeographyType"
    ADD CONSTRAINT "GeographyType_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 W   ALTER TABLE ONLY "LKP"."GeographyType" DROP CONSTRAINT "GeographyType_CountryID_fkey";
       LKP          postgres    false    297    5067    289                       2606    17972 (   LocationType LocationType_CountryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."LocationType"
    ADD CONSTRAINT "LocationType_CountryID_fkey" FOREIGN KEY ("CountryID") REFERENCES "LKP"."Country"("CountryID");
 U   ALTER TABLE ONLY "LKP"."LocationType" DROP CONSTRAINT "LocationType_CountryID_fkey";
       LKP          postgres    false    289    303    5067            �           2606    17977 K   SubScriptionSubCategory SubScriptionSubCategory_SubScriptionCategoryID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory"
    ADD CONSTRAINT "SubScriptionSubCategory_SubScriptionCategoryID_fkey" FOREIGN KEY ("SubScriptionCategoryID") REFERENCES "LKP"."SubScriptionCategory"("SubScriptionCategoryID");
 x   ALTER TABLE ONLY "LKP"."SubScriptionSubCategory" DROP CONSTRAINT "SubScriptionSubCategory_SubScriptionCategoryID_fkey";
       LKP          postgres    false    5157    315    313            �           2606    17982 6   ClientBankAccount ClientBankAccount_AccountTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientBankAccount"
    ADD CONSTRAINT "ClientBankAccount_AccountTypeID_fkey" FOREIGN KEY ("AccountTypeID") REFERENCES "LKP"."AccountType"("AccountTypeID");
 d   ALTER TABLE ONLY "XREF"."ClientBankAccount" DROP CONSTRAINT "ClientBankAccount_AccountTypeID_fkey";
       XREF          postgres    false    5025    321    277            �           2606    17987 1   ClientBankAccount ClientBankAccount_BranchID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientBankAccount"
    ADD CONSTRAINT "ClientBankAccount_BranchID_fkey" FOREIGN KEY ("BranchID") REFERENCES "LKP"."Branch"("BranchID");
 _   ALTER TABLE ONLY "XREF"."ClientBankAccount" DROP CONSTRAINT "ClientBankAccount_BranchID_fkey";
       XREF          postgres    false    321    5059    287            �           2606    17992 1   ClientBankAccount ClientBankAccount_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientBankAccount"
    ADD CONSTRAINT "ClientBankAccount_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 _   ALTER TABLE ONLY "XREF"."ClientBankAccount" DROP CONSTRAINT "ClientBankAccount_ClientID_fkey";
       XREF          postgres    false    263    4988    321            �           2606    17997 5   ClientContactPerson ClientContactPerson_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientContactPerson"
    ADD CONSTRAINT "ClientContactPerson_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 c   ALTER TABLE ONLY "XREF"."ClientContactPerson" DROP CONSTRAINT "ClientContactPerson_ClientID_fkey";
       XREF          postgres    false    4988    323    263            �           2606    18002 %   ClientImage ClientImage_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientImage"
    ADD CONSTRAINT "ClientImage_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 S   ALTER TABLE ONLY "XREF"."ClientImage" DROP CONSTRAINT "ClientImage_ClientID_fkey";
       XREF          postgres    false    325    263    4988            �           2606    18007 +   ClientLocation ClientLocation_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientLocation"
    ADD CONSTRAINT "ClientLocation_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 Y   ALTER TABLE ONLY "XREF"."ClientLocation" DROP CONSTRAINT "ClientLocation_ClientID_fkey";
       XREF          postgres    false    327    4988    263            �           2606    18012 .   ClientLocation ClientLocation_GeographyID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientLocation"
    ADD CONSTRAINT "ClientLocation_GeographyID_fkey" FOREIGN KEY ("GeographyID") REFERENCES "DATA"."Geography"("GeographyID");
 \   ALTER TABLE ONLY "XREF"."ClientLocation" DROP CONSTRAINT "ClientLocation_GeographyID_fkey";
       XREF          postgres    false    327    265    4994            �           2606    18017 #   ClientRole ClientRole_ClientID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientRole"
    ADD CONSTRAINT "ClientRole_ClientID_fkey" FOREIGN KEY ("ClientID") REFERENCES "DATA"."Client"("ClientID");
 Q   ALTER TABLE ONLY "XREF"."ClientRole" DROP CONSTRAINT "ClientRole_ClientID_fkey";
       XREF          postgres    false    263    329    4988            �           2606    18022 !   ClientRole ClientRole_RoleID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."ClientRole"
    ADD CONSTRAINT "ClientRole_RoleID_fkey" FOREIGN KEY ("RoleID") REFERENCES "LKP"."Role"("RoleID");
 O   ALTER TABLE ONLY "XREF"."ClientRole" DROP CONSTRAINT "ClientRole_RoleID_fkey";
       XREF          postgres    false    329    5151    311            �           2606    18027 $   UserEmail UserEmail_EmailTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserEmail"
    ADD CONSTRAINT "UserEmail_EmailTypeID_fkey" FOREIGN KEY ("EmailTypeID") REFERENCES "LKP"."EmailType"("EmailTypeID");
 R   ALTER TABLE ONLY "XREF"."UserEmail" DROP CONSTRAINT "UserEmail_EmailTypeID_fkey";
       XREF          postgres    false    291    331    5075            �           2606    18032 '   UserEmail UserEmail_EmailUseTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserEmail"
    ADD CONSTRAINT "UserEmail_EmailUseTypeID_fkey" FOREIGN KEY ("EmailUseTypeID") REFERENCES "LKP"."EmailUseType"("EmailUseTypeID");
 U   ALTER TABLE ONLY "XREF"."UserEmail" DROP CONSTRAINT "UserEmail_EmailUseTypeID_fkey";
       XREF          postgres    false    293    5083    331            �           2606    18037    UserEmail UserEmail_UserID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserEmail"
    ADD CONSTRAINT "UserEmail_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES "DATA"."User"("UserID");
 M   ALTER TABLE ONLY "XREF"."UserEmail" DROP CONSTRAINT "UserEmail_UserID_fkey";
       XREF          postgres    false    271    331    5013            �           2606    18042 *   UserLocation UserLocation_GeographyID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserLocation"
    ADD CONSTRAINT "UserLocation_GeographyID_fkey" FOREIGN KEY ("GeographyID") REFERENCES "DATA"."Geography"("GeographyID");
 X   ALTER TABLE ONLY "XREF"."UserLocation" DROP CONSTRAINT "UserLocation_GeographyID_fkey";
       XREF          postgres    false    265    333    4994            �           2606    18047 %   UserLocation UserLocation_UserID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserLocation"
    ADD CONSTRAINT "UserLocation_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES "DATA"."User"("UserID");
 S   ALTER TABLE ONLY "XREF"."UserLocation" DROP CONSTRAINT "UserLocation_UserID_fkey";
       XREF          postgres    false    333    271    5013            �           2606    18052 (   UserPhone UserPhone_PhoneLineTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserPhone"
    ADD CONSTRAINT "UserPhone_PhoneLineTypeID_fkey" FOREIGN KEY ("PhoneLineTypeID") REFERENCES "LKP"."PhoneLineType"("PhoneLineTypeID");
 V   ALTER TABLE ONLY "XREF"."UserPhone" DROP CONSTRAINT "UserPhone_PhoneLineTypeID_fkey";
       XREF          postgres    false    307    335    5137            �           2606    18057 '   UserPhone UserPhone_PhoneUseTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserPhone"
    ADD CONSTRAINT "UserPhone_PhoneUseTypeID_fkey" FOREIGN KEY ("PhoneUseTypeID") REFERENCES "LKP"."PhoneUseType"("PhoneUseTypeID");
 U   ALTER TABLE ONLY "XREF"."UserPhone" DROP CONSTRAINT "UserPhone_PhoneUseTypeID_fkey";
       XREF          postgres    false    309    5145    335            �           2606    18062    UserPhone UserPhone_UserID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserPhone"
    ADD CONSTRAINT "UserPhone_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES "DATA"."User"("UserID");
 M   ALTER TABLE ONLY "XREF"."UserPhone" DROP CONSTRAINT "UserPhone_UserID_fkey";
       XREF          postgres    false    5013    335    271            �           2606    18067 1   UserProfileSetting UserProfileSetting_UserID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserProfileSetting"
    ADD CONSTRAINT "UserProfileSetting_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES "DATA"."User"("UserID");
 _   ALTER TABLE ONLY "XREF"."UserProfileSetting" DROP CONSTRAINT "UserProfileSetting_UserID_fkey";
       XREF          postgres    false    271    5013    337            �           2606    18072 !   UserRole UserRole_LocationID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserRole"
    ADD CONSTRAINT "UserRole_LocationID_fkey" FOREIGN KEY ("LocationID") REFERENCES "DATA"."Location"("LocationID");
 O   ALTER TABLE ONLY "XREF"."UserRole" DROP CONSTRAINT "UserRole_LocationID_fkey";
       XREF          postgres    false    267    5001    339            �           2606    18077 %   UserRole UserRole_LocationTypeID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserRole"
    ADD CONSTRAINT "UserRole_LocationTypeID_fkey" FOREIGN KEY ("LocationTypeID") REFERENCES "LKP"."LocationType"("LocationTypeID");
 S   ALTER TABLE ONLY "XREF"."UserRole" DROP CONSTRAINT "UserRole_LocationTypeID_fkey";
       XREF          postgres    false    303    339    5121            �           2606    18082    UserRole UserRole_RoleID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserRole"
    ADD CONSTRAINT "UserRole_RoleID_fkey" FOREIGN KEY ("RoleID") REFERENCES "LKP"."Role"("RoleID");
 K   ALTER TABLE ONLY "XREF"."UserRole" DROP CONSTRAINT "UserRole_RoleID_fkey";
       XREF          postgres    false    5151    311    339            �           2606    18087    UserRole UserRole_UserID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREF"."UserRole"
    ADD CONSTRAINT "UserRole_UserID_fkey" FOREIGN KEY ("UserID") REFERENCES "DATA"."User"("UserID");
 K   ALTER TABLE ONLY "XREF"."UserRole" DROP CONSTRAINT "UserRole_UserID_fkey";
       XREF          postgres    false    339    5013    271            �           2606    18092 <   ClientConfiguration ClientConfiguration_ConfigurationID_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY "XREFCONFIG"."ClientConfiguration"
    ADD CONSTRAINT "ClientConfiguration_ConfigurationID_fkey" FOREIGN KEY ("ConfigurationID") REFERENCES "CONFIG"."Configuration"("ConfigurationID");
 p   ALTER TABLE ONLY "XREFCONFIG"."ClientConfiguration" DROP CONSTRAINT "ClientConfiguration_ConfigurationID_fkey";
    
   XREFCONFIG          postgres    false    261    341    4980            �           2606    18179    refreshtoken fk_user    FK CONSTRAINT     s   ALTER TABLE ONLY public.refreshtoken
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id);
 >   ALTER TABLE ONLY public.refreshtoken DROP CONSTRAINT fk_user;
       public          postgres    false    5229    343    348            (      x������ � �      *   ^   x�3�L�4202�50�54P04�20�20�325�00�,�/.I/J-&J�!gjp~Z	
��ihdlb
b QIjq��{nbf�^r~.Tr��qqq �%�      ,      x������ � �      .      x������ � �      /      x������ � �      2      x������ � �      4   �  x���O�8�_�����V2?�Q�Dה�} ��&M:�֔Hm�KRn��紴M��0ش3�Ee�Ŀ����K��r�`��1��Dmʹ��j��4�8AȒ�'(�h�:�YKa^t�:�8H��`⧷Q<U����Q[�Qk6�C?�PA5�B��2�&�i���?e�h�`��Q
�� IE\|����p;��4Gh���1G�ԟL�0m������,�~��cA�MM��k��k�O���2�F� �v�׳&�@e%�8f�I"]�M0���`�F��|	��?�����<�� ���:=�	�LʖX6�*�!ի,(�[2�H���_����@�2��4��L�N!I��MY���?T�FT̀�JJ�WY2Kw�[��/���oZ�7����"�A�	|�P<۷S��)��aѽ�����;%�,��g	x��`�Ù�4�߲��C�;V3B���P�n�c#��?�|33��\]�=py�q����4b ��|=o>�6�md�1-��ٲ��I��}���//��]�.���O�Rb%�O&<�9|�+�2�Òa̖+������"^��ǋn�Q�����PN���t��߬8�	8�QʄMP=�&X�쩪.�.�~�h�{��t�2z�*Ja-��y��W��o��s޻�/.,|�-���<��x��	����x,�U7�OT6ꇻj?=\',^�q[q=�h�X��}v�
Aۦ��mN�������uǫ�ɞ���9KR��d�`3��~w�N���$�M���v�l1�j^�j����u,��?�Om���=�_D2CD2l����۪I&�� &�?�d��d��$�P%I&I&I��Hf�H���D�+�dbM�ixq3eR]�a���	�W?�xQ��槺�6�m�1ai��
�X"w��Z�|;]�@S�:Cu�J{�������hCK50�x�*�k���of�=�� �=�T��4���G���z�E�A�#����m�&�&Ҕ���N�~ꏃ�H똅-K�]�*eo,�0t��."����5�`W�T��
vѲ]���J��Y�~BM�[TC��Gكc�⻶=�i�T��WXM��5���6,﷫Z*�z���s�ۄ��e��k���sd����uH��#��Ԛ�	6�� �`��V�i9�� cw=pZW�|&���
�S��m�a`U��R@�"���ǲ�����P^hUJ�}�ʘ��.�ϧ��fs-����:n!�|(_��9��s�4�jx�����2���u�B�K���k��whjp�_�3hC��e;f�v����6Ϛ�~:�۸5�,Ѯ���	�P��jɾ����v��J�:��z�C�mi������W۟�\��8��mվy�]�����G�/��y��X���/[/T�V�<qu�LWl�ɡ�nY�8?_�8'����Pك�]�'�W������<t�����!lw���V�������L��)3��|�8�����w��-@��] �X�u:.���.-����ˤoq�`��El�T�MUsK����DT7%�$�$�$��E.
��2Tj`��'�CS�\D�K�K�K���B"rQ�M�ZD����B�-�-�-ɭ�q��E�ȱN)��Wjj����$�$�$�$���ED�Ґ���;4���Q"��\�\�\�$-�K�)�O&D��W*^�*�������oK��xK�j"niX%AD+�URHnInInIn�������j�      6      x������ � �      8      x������ � �      :   X   x�3�L�4202�50�54T04�20�21Գ�4532�t��K-����\�������µ8?�$%3=�$1��5��-����3�ч+F��� �X�      ;   U   x�3�L�4202�50�54T02�24�25�335705�t��K-�@Waje`�glhha`	Sa��X�R�X������������       >      x������ � �      @      x������ � �      B      x������ � �      D   @   x�3�L�4202�50�54P04�22�26�3011�4�,�/.I/J-&J�g^Jf"���W� �lG      F      x������ � �      H      x������ � �      J      x������ � �      L   J   x�3�L�4202�50�54P04�22�26�3�0�0��,�/.I/J-&J�!�s~i^IQ%��hHP$'�W� �S�      N      x������ � �      P      x������ � �      R   L   x�3�L�4202�50�54P04�24�24�33�0�0�,�/.I/J-&J�!:��$�Ur:��8�E���\1z\\\ '�^      T      x������ � �      V      x������ � �      X      x������ � �      Z   �   x���KN�0���)r��l�5ͮR+Ģ��M4J$RF�� RZ��d�������>�>���6�(iQw�r���,��j��?���5�ZB}+�����E=hI��#7�w1�^�n���Ǯa큤r�5n�)��:h�U�yN9^�k����W(�@Y��aK��O�5]⪛��8r<���F�:	 ���Ɯ �輲��]��	R�ŐJ<�~a�2�G�9�����      \      x������ � �      ^      x������ � �      `      x������ � �      b      x��}[������WL(���Q�K�qE�rV���v�q��2#$JA�W���{@P�c!gh�+Zd�r� >��/�Ȅ��h�?3��K���d�?����w�������/������?��y��77/����/o^����/�x��WϟN�_�����߽{�ӟ���_����?�0�?��+���g�^_�,�eFC���k2�\|����/�~��������]~2��d�dقO�v��������t�����W���<���ӫ�����_~���������<~���?���7o��|���%O�?��ylɓ�7/������w�~|���n��88����w�_����%_~v��W_~�d�"�k���/.�Nxu��?�����W������y���_~���~��?����%rW��?�㛛_a~�)@�@�r��헢g*�7d�#���|��lY�]��:�	ـR��k��~�n�~bB�U����B�h��?������7>�M���?7���}�?��o��v�!NF8�t�o��'�e
���7^>¿�k�O��A�ۀ��s�����a��Ǐ�o������~M�{��؀R��������?��G�#;��뿭��?��P�R����o.�S��hL 6q0���3~���(�8 ��Z�	��r ��v&Ll	v'@Sg��y|���޼�k�=���ek
٣���&܉�9��жG��23�`�F�-�P���{��#3��w�u��!>o���r0b�-�[�gO!��)t�P�}�(;v��\�]����uٚB��ǅ����s!?�y�*#_��{��m0DטC:O���ϯ���g��_����81�8ϥ�?~��B�ҿ.?w���͏o�XZ�2���'����$������>ūO��S��T�>�W��__�)6ſb��O�qA�����O����'������_���_�;�'p�B�����Y�pz��ɲ�"F��b����I�vG�'�������1��I�[S�h�
����N<��D=J�q�I�v?G◐� ��$j�h�ΘD�5��kg��;#>N�_�ډ!������ϤM-��(����w�$b��=ˡ�q�
֞�A<Q�tɸ5��:�)[S��n�����9s5��v��o!��5�:�)[S�B�#��-��^<!��y������I��y�QnM)^|��v$��%:s5��n~2�3��΃����3\_�������I�t����_n�$���:*w�B_����;Π�bvj
Ս)D|D��5qi�<b6l2]��өj��5�"�q��O�S+~�tZ^D0l����S۝OM��
ϝPek
��V.a��u�g�9���3j5��~���G0:�q���ΨܚRvlk�ہ�gԀ�tj�xD�����ƌj�<��ʭ)e�87Ѷ���PO�86����\����}�-]�0�#���ۻP兀�ptu��nL	�U_08�1�'\���U&\T�����㯟^~��?�xڛo��\��ef�k<�	@[g�ܔ���᧗o�����j~V-�2^\m��'�97ŋ	:��Q����}���d�.��3�8�S�x:z:�'���$�-*��kV>q]OR�q�~ �ty10Ûޫ	ޚ��I
�N�ܢB&o��9w���LR�8Iu')-/�����tO�m��������q�=�8��$��&iu���Bd'a2(>��'o�^����MP���O?}�f?���,���e)\�{-��:4dپ,�#[^�H<
��kъ���QيGKq?����Ehy��y� H� �Z\@�$�=�X��m}h�Lh�+�ŧ�=���x��,5�u�'�����RCY����e�=ԏ�s��H|��rYq�	�Ȯ4>���}��DQ31s����K-�n䘼��\��_�o"x~w�D���%Ї�Հ���^�{���w��G���Ͳ�$��>���qԇf��пmԣ�}ԭ�<_��*��P�-ԉ'� �u��h<�x깽��Pg{G�{�$8ꮅz��YqFZG���C��硞ۛ���Qݙ��#꽍�GݯQO�7����Qoh<�r�e{����zz:~7��z)��Z���� ��}��:��zno)��/]�����Mt1;o�w�kh|���r���Y7�����:,Z��Ў"K�s+�nC��~h�w1����Ų-G9p����#	?��.	���77���n����������e�G����(~���i3׆���EbC���r+;�΃a��R�>-��	!- ���ʄ��|���w��0�z�/o^~��.�*���\ͣp��ɳ��޼�y����wW�/�M�2�7%�@ƺ���3��ͬ4���بG��o���y1\��y��G�n]V笇_�2��<TB8IijO�W�J{q�ܤRT��B��u�o,�"�e�K	�0���vlᾭ���-*D���l�CC�8o�;��F*�=|_�!��&2B���_�K��������2R�X�'TՀ�Փ��G��O__�����u����hc�-�ꎚ��)�+,�J��Bb�B.}��dŸ�m�� �WgCw��������Q��[�q��31��h��&�*�a�b"��6u��[�J(�/ �ln���S�%���3��t����L�cr�o������XȞ�����5���N���f�]�ЉE�����E����&U\��|z���i*��qvj�T}²hR)ׇ��B��c�?5O��g*�OCEB8�mn�>�e��̈��GDi���e�_:(M��Z��:�[me1� �~��}{{�ւ�V�tĞ�e"#���nCGu�K��읯������ʴOք�#���6�Ss�EΆ�* ��BvqT ��� ��el��ݩk4���o�hp��e)mUi"���� J��5XS��5������Z*��4�ET?8#���
���2�$�'^��s�T�LXgZ�/}�k��*�����ԉ{S����M*�cU7�N��s���2��PD�獦���4X��G-�]�Χ�`�2B
��5�7�$~��ub�m�깶�ο޿����ۛ˧o�{����vݕm*�x*��r���c���Ȯ��Į���`�g �WUD�����\��8k�r��d���1[�~�d�z��kw�����H�4�:����b!{4�a^�y�k���/�	h�74���oU���Q���,3ZW�"��N�����j�5 �JR�I���J��p{���}s�������dQ�?��"[g��#����Cľ�ztCGu}�9ԟ'�0�b�:�
�Z�/qjYv���W��r����H.��)do�_�c=��u��t "��En,�����9��CT��� GFuw���]�L��Û:� ���l����d�m��q��~\
밓g�U	}CGs�+�Y��j�E�H�)�2 � Srm�gEם�mU J�Y�l�!h+;��1�E��9n�?���R������g���)]Gu%L##Q!�. i@<yƷˢvu����HX߈�wS#]O���,�0E�a<�Ǐ��lWCi��3���l�QNn�b�=m>{��}�~p�׿g�����}��ݚ����ɝ?�4cS�>h�ŲY�q�U�Hȇ��9՜��Z3�}׬u��]�:���b����% ��[S `I�ag0e,��5t����f�k*�8Xz��{���v�!4N�������h�e1�,P���lO�`Hu��%��9��xH�x�����W�쑠����d���^�Kz��`&�&�wf�xB�~��E#�B�3834	��^�%��E�kۑ`]յQZ̲�[T�9 �z� u#���y�]����pzm�U�qm�Fd9`��)�����VV^KJ~۳���wu��F���@\���f, �|j�KJ�^ڥ �#��HOG��b���ʌ���98����s�'	�Px�۴�zoߦ��LuQt22ti�U>Q-�m�l 
]J��Q^�b!�[��%��P?�    .u�H���{������b���H5��7`)���T�O�&4�!u=M *�YI��J��檴� ,Y��k~r������hp�X��T�N����A�2 KVM��"��S2��񨧣��b��|���#� ��U����η=s�C��܆���,f9�E��/�|�7p0] ����k���Eg���p��e�]u
�[�z�@q�W`ɐ�]�ɥ�?� �u�8Z�2zS?���C#���!hɐ)�n��/�v�f:*��_<�L�W��lጛ��G���c��dǷ=K��:������,f�����C�ߢSu�%����#F6���=���;��#�������%�w�'���"V{:����� �J@�z �uC��,p���>��{�z:���r��O[2`K��H���=��YR�}�p����oZ���F�h1�(Xgr�2m���2 0k��f'@I5^6X�h#p��e˩�TF����F7�̚����J"����h#p��e�Pg?�2�y��К���@�l|��:���옪�<d����t��[�)U�����BMe��,ǳgu�.O�����>�� ¼�|�`�d����@i�(�H��j֍M���@�s��ȡ��a�����b�=�G��QȌ}d�dL��|����߇�:� -f98�����(_v�|L�s*<'��A��:� d�����#1��}� >�����ퟃ�:� -f���
���-re�4����H����}@[G���QFd�K.� ~�;�{%	���s߈م�p[G���,��'=��S�5���5dzqA=} ����.!gy$&�|�v�h*�)���Q [,� ure��`�w��}�9�>n�m�9�������K�nh"��#���\�5�oP[G���Q�������}n�ի�lx߷��{�=}�,dC�N���#��N�b �t8������C����@i�(�u�B��=�
*{�`͇�}��ǵu�8X�r
�Z��t�y�Gǀk:�<�n���=��/���h�υ�n>�5F������<��PZ<ʜ
�U�Y�
���]&�k*|�Z�\���4u�8X�r��[��B0�JA7�#��
�&�B?:�����b����Wg��H�h{�pͅ��Lq�"��QE��x�={_�hY36�l��o�qͅq�:��K����F�h1�.x�C����+���s�"���^���p���8Va��w�bQ~(M�H�|�%���X[G���Q% ��W������I��0R��Sɞ�&��,�:� ����M�T��5�{Zw	�u����B[\c�>�W�r�&����2�=	�u�8X,d�\�S����Qވi͇i__����uT(-�7��؜m$SvHКSH��0ή�sն�* �ţL�|\�n��աI��&iM��}�uϢm}���,�&;�}��*��pS<`l�˴u�8Z�2���x$��>!Z�a���*�b�$�����x�ٸ:H��E=6N�usj���-���k���6G�Y��җ'!�<�C�&E�,�&�)aL`�bk4t�����>�265��YtM�c߄&���u#E�:�d���������jF׌X`�2"~c���:�T�rk�
Q���Ѻ��xM��S)�T]�@SG��b������2#s+��_��|LB�\d�L�#��QE���e���% �I�ȳ()�1^{$]KO�>���= ��X`K ؏-z>(�\�5!N}��l�j�h#p���HW+�D$�nh
3��v�ׄ8���w���:�d�Y�T��B �z�в���\��@z�(�Y�`C�n��,-e�UaC#Ϣ�p+o��E'�8�} �L�}]h���8Zʱ��Z����6��QF [,�^JV����TB��b�B��䘚���*��4X���y�Ź�<,*�sh�ZDԼ�����h1�)Φ|.��&�t���F ��A���UTǿ0�EAk�'c26}*W� ����A���:� ��b!���n3�P��%�*4 �A�XL�������b!��u9��Ni��Ox���{��2�b!\|���'c��.Q�5 �b?⁢�O}CG��b�}ջUJ^䡻0*S1iP1�3<105o�7tT(-fٓ��7�e�I�/Ƥ�8tC3{���= ��X���_?��F�~jP�k�	��	4u�8X,d/uͷ�7�N9VZLإ�˴� �*��4X��~�����#=�vs�.���w����g���D5�C3ݒ2`<��$q��j#t+��VU���������K�Yf4R���Q�A�)�m��o�������ECGy]d�Yf��}�j��L�9�;���B3v}CGu�K�Y�>=�-�h����}�6���T:�3������zOF�7��f1@3�↎>�Y&I�o�si0C�H���A�B
���Y�P���*��B��$j���,(�t����3���R����B�H�w4�u����$l��9y3�߆�=���b�i�Q��f���c���::~"������,f9�]��cc�X�ڏ]s�Է0!9ۿ"k�h#p�����7�����D��Q�����E��~�������b!;_��e���r��sk�&vJ	"��	�u���l��l*"C3�:���ϭ�0�N��8��MU%�_=������7?��z�Փ����?�������������^��>��b��,ۈX�c��q�+{�ܚK�����X����*-�zW�Z����� h'�sk.����6}�:���2���Rb��Ԍ�J�. k*��D�T�����b!�ڝd��f�O�2uX���7��6�x�@`�����b��vf0۱��E�N�5����H�gf���>��l� �a(�@�.T��z�7a�,ش�s�-r ��50�x��3pנԒ�	�rnh��~�w�R]US%A�T�s(�S�v�2��[��)�6t���`1�yA��ؼ��ʗ��A�羑��Y�uCG���,;�\��~��Kd�����ݎx����bCG���Q�XZ�"U��]��\8vM��nV�����h�(c
e�"0v	X庭���ݎa
���^SG�l1�^���dǾ� ������}J/ ��'<z[�*pЕ������w�O�^&��Nʯ/�M-d�E}-14�)k��*=w-v�C� ��Q]A��BnA#phr��Ze L:� UU2�T����~��D؇W���&�P~��4|�[��6�U[*���0xӳ�*O�`:6�h���TH��G|7U���h0�$��gb?4�	��ixX�p4)٫!�$'�^����jj�#k7�$�C�X�(����.�����\B��,{`Y8R�uf�JaM�;@����6UU����޿Lw�W�߿�]Ϳ�z�z�X�6eY����0��0N���5����R���bi�(-�z��7o��y��`أS�&�,��u��DΈ���ų�_|��/��*��h6�h��mC]���/�^=z��o�^�v0�1�a�?}7��\��g���嗻�K�6���� ���O9�~����C"xlM!S�M.>����p�p�ݗ0��ѡ{�k�h�W��,{���	<���@��qX;����9�C�������e�b�J��Q����Wε����ӭ�@SG��b�)���`���4b�iϚ����3����X�h#p��e���>4��5��2�k����1q�awh�(�-r ����	���& h��?v-��z�����J��]�ؓ�߼x2��zrKZn.�m�rpub�����;2�B�h��7���Zi�(��l1����},a(�W���c� & 3:�u�uT(-f�t�%W���)�Fj�Y���5H������h1�A�K.76VND�f
FZ!@�/)9$�OLMUJ�Y&�@@�F�qн�E�&��w<W��8��QE���e��e����]چ�A�}z]j`��6 G���B��zC���͒7Ü��Mbz�6�z�_�˒8'��s��ofL�M͈fɘ    �����]{:�2��b� Q����`�ST�YR�o�� �c���PU�fZ]�>k��.Z�eo�V�v���u�i+�,{ߵ�Fvܬ�����j��,�:�ڜq#q��6�/���9vͦR�a�th�PZ�2�1�bnf�3'+ʧ&XrgHY��_�Iu$O|��T�M������˧����7q .�z��ͷ�[��ӯ����b�܃�ڀ��;?sC�#����aɿo���K��2j�.���Q� WQ�d�VD
�/f��Rj3�Sz�'w�-U�et����_�o���r�s���-�_U��@X��۞Y<un�z:�k������껍Tojdy吸���� �dSa�pz��U`��\,�e W_3b(�AeNN?���M�'䦎�j�ي�S��$H#�Z��]x��D (c0���򼧣�@e1�QujOoƾB�XX3��7�|��9��TU�^�n_=~�>~�^���|���7o�o��U�� ���Ы�x���Z�����u[�t��J�X�Bu���%Ht�"�	}��`�����u�U�B��h5��f��-����o�-���Q^-�b!��I8��u�]Ƹ���N�@�p������e�ZD��jI��k�N�2���K2���D��x�����ǹ`t���Z �B���}�hC��GOG���,��U���YN�]��$�s�0L��tk�>��0d|Ѩ����U���8m'#.��m�\�g�y{:ʋ%[,d�v]����oKpA�����'1�ګ��QC`i�([b���044�td��dC�����q���6G�YvqˮRn�I9��Y�w���:��:� ���g���\�U�Μ` ���P��LGCs�{Y����hh�7���q��B�Kl ���۱�]��_X<�b�QuZ��%��2 �@R�� �u[tuT(-fك�U�?�А��ش���B�}z�i�p�i���D��x�T��-�CڇP�.ܫD�չf��rZ�럢w�׀]#R�	�x�k�3tuT(-f�9�\�04�#2U�xgr�:%W�:�,�u��@��hk��K*�rn�m.��1=���D��Xȁ�����@m*LK*�6��tA�RO��"PZ<�>���������릖�S�F 1�%�|���7h]5���Q�Өű_���PX#�;���s�o��]UJ�Y����g�%f�[d�5���1ô�@WG��b�%��� ��Ġ[z8e�j @�m�`�f|�)���X6*����݌ǡ�� �U����M��;�뮎�j�ٳ��^dl�AP�m�,k�\�+��;E�:���,&��MR��H'*k#`[�O8��ᬫ��@��eG�jc�+44L��k �Z ��QΞ�0�T�?���ŲMY�6`O��]+º�(�}*!��w�k����V��Bf��Z�CK���@X! nghB�v�mM*�G� �ڱ٘�C���C�$;��ƣ{�Rv^SEu��Y��k~g��Jp�W��f��FW&�wc�:� d����m-��F����� Yl��2���o��a0�N�N�L�YK��$krM&��G�ԩ������b�-1� �������G֔9�e�L�+��RUK�������6r
���جC^�RwJ�܆��c^�����8��B�.���xh}86�{ÚJ��L\蔨��PZ̲��s���v�9Ys��7��'8�~�vJ���Ne��5��Q�����6N��ʚ;���`'-lWGyqd�Yv��">�rβ��i͜	�b�:�ۺ:��_Z�2��z+8ᡮnk���5s�]II\"i?�i�м�/SфBtd�B:n��5�A��W�����é�Na4t�F�X��.OMcЎ�kJM|�7�;붎* ��,���a:E��k����������/�����f�Z��d������i�m0jNI����xbc�R���;Cن,H�n��&��8��_������-t#��:�K#[̲Ű�i`�<+:۠�.��`��mUJ�Y&�<��04�2���ܠ�>�U�Z�o'>O[��up-ېeF5�z�m���`�~.��}��:GGum��p�_�I��Ʊ�e�mpj�C�'m�N<��A��]F��YNQ�Uc_p�L ]���}�Mg��:j�(��l1˞�t�~���g�5�ON7�'=#���oѤ�7.c���J���}CoM?T����P��,�:"էʝS��T�(�pݚ�3�"����hPY�r*#R�(3��Q�P9E�[���7���
�9:�d�Y�M��׺�����ٹ5'gJ�+��m�]��QE���e!�5���5��v���oSzNտIj�(#�-r�~Ro~h�8���֔�%8Z밿�uT(-eg�ߨ���V��sk��6��Z ����Q��b!;/�c69ч^Y�[nM�c� ���{c�TQ���,"������Մ�G߯	3�T���U�SGu�K�Y����&je�4�~M�c�H����oL�:� d�Y����o���{�8Z�i���
���:��~� ���D���e7�(C�`h��H������Ǿ	%�oy���2�b!��ы*�c�vV9�_saI_Sp���@mUJ�٧s?U�ӄal�����n�5�0ע"׍�n�"PZ�2�P��H���O�U����\�R5Pv�/��z:z,,eˆ���M��W�~]���7J����n'@���:���,�E�0���Q��K.L)�b<bP��˛��z}Ѧ,{�8Kg���MeN��UK�|�7���6�騮��b�%U+���ply_��saI���ӠO�[�ciN����̥�߼���ɛw�ߦ�@Ϟ4~x�tr������+l�&u"�|���{�7�������VQ^8G�Y���,rj��D�}��l�R$���o�ݎ�9��A���\,�[��ԕ����[��$�]�}/=cOGu���q�_13�Z���,	��7�T��a�u�	U�e�~{���]�Ӽ��%��g�ݮ�ܺBv���[�P�	 ʞư���}#��x��Q^6�b![Z�zql��}hkP|��s`J��fK���|�'������WV8�i~<�+��	7����O�pM�eTZ�2��u�4��U�v����Ĺ%���>[���`ц,[õ��"i�
��|Q�
Z��z:�K��X�.,�ڍ-�╿Mdn���'�؜P}��E��,s}�*T}�{4U��#`�[�!�%���(��l�(���C�d:eWL:L��;�ɒ�?7uT(-f��y�gjh6`�#�&��#E>����C��y��Z�e�˦���[��7��bȬ��[���b��vWGs�T���u�����.�$���k���FN.���E"o.�-DS�b���x�}	Mf��w�I<�t���:�K([,��^=���$8���)<$7�d%���D'T�BVm�r*]��� �R9 �̚�����=��uT�Fi1˞�W�n蓄�E�v�̚�����:L'�����z�#�����Yd(�`�yY�������S:��ɫ���6��B�6��GF˓��`��cט�ȼ�!���諪-�/gC���f��tys���Xr��w�ez��nb"�=��~�5�@n�����R9,Dk�}���}���K�A�i���kќP�*^�����>}����i��\,��e��hh�ƞ���#�~���I ��Q^.�b!��N����`u/�	*Ro�Ɣ��:c[W':wC�ޭ�qi1�C�r=m(C/�rPk*��B��x�w�	Ć�*��Bv���C�"�5��r+����a�)�C����@e1�,R���y$ ���[	|=��in%7Bh]Im訍��b�-Y�^�����7�� �`B+�~CG���,N���0���(�4k8��w]3�ۆ�*��,�9_=Ǎ�m�ӆ��6����_)���> MU J�YfN�����0rpA�-nڲV����;��r�n討i1˞*����E��\� ��B ]]�)���;�mM*�Y�6�b>�D���y��\�θ���5��o��!����TK�t���PN� �
  	~���ՆfN�m��L��+�	��+j���v5�H;�	8��:�pOGs�+�Y�T�O#>2rx�ȉn=�!}]�hf���Q���QSU%vc��9�KP\R�۞E���������,��Ǡ�4:/��G�Lx.��`��mo\WG��b��ԙ!=�kf��DK����������tTǿ��e�T����i�@���-������ҵy����D�����ʄQ@9��Tx�7?ߣam��?�+$��"1FF!9��0Z��}¹H�b3lCGs�+�G9�KI_�̴C�ÜW���5�QH�جX���
@i1���&�C�Q%G��Xs`����ƭ�Y�{CG��b��બx�# ��5?�{`���:���,.��)i0���X�6��4�RW'�j��� �G�c0P�'�4�yeFK|�G��п����b!ǃJu!9g�NT�AK"L�e+M$�]m{CG��b�����;#C7�@�/xɄ�E��qu��H�Ӫ*p��ߟ��]�|u�.������!�@٘,3�EBB��Wf���9�;���A�m�=�E�-�w�:
���A��^r�o����BO�����*�WǼR�N�0�:��ܴ,[�RG��ؔω��"�dط}cB�Z�t��L�X�q����YX�\}�,�B w���/'�̖���y���������y����*��e��UFW�������g�6��WPSGu���Ց2�ƆK�nC�%?�犓	�ǸwK��Q��X�!N�:��dhN���A��9rɅ���RG���,3�C���x���\&6R�^�^OG�l��%غ����������_�Me�,����	@e1����ϹC��H&uW��	:�y�9��Ċ�t��9�S?����䲦�)�ON�7Sm�h"PY̲�j7m�u�TI5%�Y!�����^�LOG���Q�&F��R
0���S>�ʚN��Cwh��#p��e��9�3#c�R
G�}`M�cߘ'Ai���QF [�2׉y-�&��o�dM�1�gI?�~#?�iU5�Ʒ�˷W��/���o�o���iQ5'��z�.���:ko�kҼ��>in�.��b!���º��M��+�5i&��0�@}��T����Qtd�a�\ Κ��&�뼑�s���J��vB[{:� d�Y&�HꝚƦ�6�a��̩oqv�tj]����F�h1˞�N�#al�IL�G��5gf�I<Zý�&�ţP|���FJ74����(�9�B�����s�-�@_� .��_!�7na͙S�b 8��Z�u�8Z�2��}��vg$ V�#��̌��x��sSU�.D�0������mO�&r _m>��h#��X����o���dm�.��b!4�E��oQ�WkjͲC?�Nz���������9
 �T�rR���̱kB��*�uRS�;���oޖ�~�����c}ղM�(���:���jM��}s~���_'兒-��u(&�З� A���mz� ���.5UTǿ0X���*mC<��u�+�pkf�.]�Zk+Ny��������J�U�hh�[2F��4�����-���ĵu�8X,d+�������0�R�E���ݎhB���uSG�l1ˑj׹$�-C� կ���;��> ��qiCS��tnU��qY��;U����"���[6">��)���:�+��XȖ���������ƈ͚_�������=M *�Y��Ժ�y��Wbu�(٬���o���nm�{@`o����rǓ�ؔK�u�٬9v��$�(�����f�A���i�:c-��Y3gI�b_һ�����ڮ=o�o�~w��ͻ�o�s�ٓ�睻ja!s���!4���W.J�fM��}�ؿLm먮��b![�u���oE9��͚t�0�� �$M��/Eg���? �#�N�Y�ք{�5�a��������Bv	�r�3���v�;7�	wJB�]���TQ����()3\5�֏�wē�.y�5���ȅ����ν��w=�.��.�߻�6fٓH�(���A<�)C�&���	���{ն���)-�u��W����Q���̛S�h�f���2�b�	�C��-�h�������W�o|�a�ֹ�Y���|g$���e�}��G��x����QF [�r�؅�o�3j��{��|��&;�)�G��"�6U�c?o/6��
�}�lx!��ŉ؎�lSNL��JZ�}C�U��stTWTi1�R# fhk2��xUI+��΄�%=��!��QE���e1B�7M���F��x�*�u�!�;EZ*�0���,b*t_:E��	��YUњ�F<!S*.������g����"��Pb�n'��h�����	M�����p�#���e䫼�T5�ĺ�츮�U���J�o"���G�`�(��+W��V�y��Y	���u;���. ؖkvCG�l��C���y741&�r	��hͣ��[HU)�st4�,fY�G��%gdhdbP�u%����T����U����`!�Q:ǁ�����|�]Һ[�)2�f`M_Ey���(\�7nlTh'O溎�����b�s��m�(�-fY���x����Ny��SѼm�:�,r \�o�Խ�u%����@D� e ��,[�|A.����ʯ�����]N��g�XMUJ�Y�T����X2l��)2��0�9���t{��o�VU�����]vs�lb�G�\"g`lb9��O�&������讝����)-f���ŋ���<@�J�Lk~g���;�>�k�"PZ<��x�9t��S~����_����� /      d      x������ � �      f      x������ � �      h      x������ � �      j      x������ � �      l      x������ � �      n      x������ � �      p      x������ � �      r      x������ � �      t      x������ � �      v      x������ � �      x      x������ � �      z   �  x�mXK�#��g��7��"E�ky}���fN9�FWt��N�"A *ዉ%~��O����9_���~F>3I/�Z1O�3[-m�W�)o���v�k�ɵ�Q�GN�V�VW��h�y ���w�r��
�q��N�-��	~�lm�B_\?�o1�r;�|������N�gK�x ���V�ڹO9��ʽ�m��wO�q�*�[~ ��>��|ͲkFK�����i̭��Ԗ����/����;tF�=ِ�d��F�&98Y#�y����`��쪒�g%�l9	��z�;y=�2�yT���~��h�	�Jr)5��4��)��A���J �B��]A�����r�`M�	�p��G�[��}����k��8�`y���ۺT�M&� ��,��k��⭜v�d������k�Yu{4R�`��w�|���`�(1�ڒ��Dͭ��'�5�A�C���嘱NN���I���Kbת\w�S�+�ֳ�G�6𡮢cՒ��TS�Õ��Gly �}(��e��ς<�C>�ī<fݼ���� @�  �#d��g:��4���nG{���m��/�җ��7@%�vvB#�"����J_����8��g�4%F1���6�1I��i��5!��M0ү2�(�xj��(���4Ϭ���O�z�D�m����3m&���@�U츳��؉Z�t��\0J��Rp84�6P����/[�Y�����G�C�S���!eH�,��53��ՙSy�A!O��؊N���R�.>z���`'m�{��B`�>�ڰ�ʮ5Ja= S�����},� }R�$�X���G�5T������ro��)�� �d�a �@fu��VFn�mrd�u.�l�U�fd6��(a���?�	6�ᕫ��Լ��j���EH��۲�|�V��$Y� d7l� \4 �8J��"d����T ����r�����&y��HZ�>��E�����{�jЅ%?(�Q�2f ����t��J��I�7��6���
W�J��A(X���@�(����r��m������N�:���u�̶7D�1LbK�(���֩��@���d��.�ں�Uî�>��I�ƹ�~Na/h$�;C^���:-!+@)�#y�z 7[G?b~�_R�V�*۵�S�
��i���yH)Y$�Ï�G�L2[>��X��^�`�f�� QkV]N�=���B�b!Y�kde�9�jk�(�A�={q�@�od ����\X�t��2�e�� V~!h��x�b��B��b2ร�#p��z���<x��!
�Tn�}�λa��f��
�
�C�|~� _�!{X�����Q`%�f�_ƀ<l]����x��b��؏��u�H	���+�%���k���B��A �6t�MJ�
d�(fq8)����q2�0���S�-���"��V{7��3�B�|�F_�oĹO���U'�D^�D;c�SC{!D�C�Bmж� 'N�:j����)o�i6����s�Yx�N��m�":	�j�NZ�=Zy����P(�" n(a/Ԏ�$�|l�v��#�w�Y4�B(a�0�Jr	�0�#'xW����'��VV<�C+o}Ј�*���v�8���[��`��9f�~qR�հ,���[��l��E n`'�n��`Z�#�6�����cHH����k�v�ՠ�W�js��D�*E�,�U�谈���({"�,L!7�¾ "�<�f��s�{�G�G�
���*�2�D(n�h��b���e�&�j�6 8��-AB9�5q#��/�0�A�{\"�I��t,u���l}n}@�ν!$�_.*�X���X-�W�e��������@�n��iɥ��b
��'�����b��g;3�G�,�,ȃb3A]aڒ� �f����>֙�� +�`k�f%�
��`6JHOhnjŠw�D�L�Q"ω!	�5��h9���f�䛡�{�������(- pG���s:���@̾���*H�����^��Щ�!(.JךQ����
��ݐ"�T� -�� ��e}��ft�-Zʖʓg�V��Zds����%ς�&	�XpzC#x�a𪠛����8"���"4�.��A����ra;�=�
6��$�B��2Pm�Ʃ�3�{��,��,���<��������H���      |   �   x����j�0@��W�ʶ��٠�-4	X�0�[C��8���u.��a���=Y��A���[a�k@�k�B3�x�����Ɍ��ؼe���J��\�e�
�K��Z���'k.L��6jS���u�nr��vu�(�,�BE`M��W�0	,/�d�W�4ӈE�OQ��o��v���[��TV�0�l���4R\���E1G��K�4�
U���v���o�E�ew+���      ~      x�3�4�24�4����� >�         �   x�}�Ko�@��ïp����e���O[%�F�f�f
J���*ibR������s>�NB��x�.�R�e"T�7i�t:%��d$�u��u�-�I�m����PC��w��Xف��^��L�R=ע�M��p�{��i���(�K~d<���U��D^�d<nur���Ǳ���,]�>ނ yQm���eF���Mb�W��q�8�]���݃�k�i���eo     