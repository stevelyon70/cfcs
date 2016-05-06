component {

    this.name = "solDemo";
    this.applicationTimeout = CreateTimeSpan(10, 0, 0, 0); //10 days    
    this.sessionManagement = true;
    this.sessionTimeout = CreateTimeSpan(0, 0, 30, 0); //30 minutes    

    function onApplicationStart() {
    	application.appStartTime = now();
    	application.dsn = "Ultra10";
        return true;
    }

    function onSessionStart() {    	
    	session.sessionStartTime = now();
    }

	    // the target page is passed in for reference, 
	    // but you are not required to include it
    function onRequestStart( string targetPage ) { 

        
        
         
      }//end onRequestStart
            


    function onRequest( string targetPage ) {
 				param request.SCRIPT_DEFER=0;
                include "\ultra10\global\settings.cfm";
	            include arguments.targetPage; 
        		
    }

    function onRequestEnd() {
   
 	abort;   
    }

    function onSessionEnd( struct SessionScope, struct ApplicationScope ) {}

    function onApplicationEnd( struct ApplicationScope ) {}

    function onError( any Exception, string EventName ) {
    	writeDump(arguments);
    }

}	