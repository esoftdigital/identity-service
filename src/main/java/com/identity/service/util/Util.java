package com.identity.service.util;

public class Util {

	/** ROLES FLAGS  */
    public final static short ROLE_FIND_ALL_FLAG = 1;
    public final static short ROLE_SAVE_FLAG = 2;
    public final static short ROLE_UPDATE_FLAG = 3;
    
	/** CLIENTS ROLES FLAGS  */
    public final static short CLIENT_ROLE_GET_COUNTRY = 1;
    public final static short CLIENT_ROLE_GET_CLIENT = 2;
    public final static short CLIENT_ROLE_GET_ALL = 3;
    public final static short CLIENT_ROLE_SAVE_CLIENT_ROLE = 4;

    public final static short PASSWORD_CHANGE_USER = 1;
    public final static short PASSWORD_CHANGE_CLINET = 2;
    
    /** USERS FLAGS  */
    public final static short USER_CONST_FLAG = 1;
    public final static short USER_COUNTRY_FLAG = 2;
    public final static short USER_CLIENT_FLAG = 3;
    public final static short USER_LOCATION_TYPE_FLAG = 4;
    public final static short USER_LOCATION_FLAG = 5;
    public final static short USER_GEOGRAPY_TYPE_FLAG = 6;
    public final static short USER_GEOGRAPY_FLAG = 7;
    public final static short USER_WAIT_FLAG = 8;
    public final static short USER_CHECK_AVAILABILITY_FLAG = 9;
    public final static short USER_SAVE_FLAG = 10;
    public final static short USER_USERID_FLAG = 11;

    public final static short GET_USER_DETAILS = 1;
    public final static short GET_USER_ROLE = 2;
    public final static short GET_USER_DETAILS_BY_NAME = 3;
    public final static short INSERT_REFRESH_TOKEN = 4;
    public final static short DELETE_REFRESH_TOKEN = 6;
    public final static short GET_REFRESH_TOKEN = 5;
}
